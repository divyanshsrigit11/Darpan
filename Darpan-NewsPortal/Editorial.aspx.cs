using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls; // Required for Literal, etc.

namespace Darpan
{
    public partial class Editorial : Page
    {
        private const int PageSize = 5; // Number of articles per page
        private const int EditorialCategoryId = 1; // ID for 'Editorial' news category from dbo.NewsCategory table

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNewsArticles();
            }
        }

        private void BindNewsArticles()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;
            int currentPage = GetCurrentPage();
            int offset = (currentPage - 1) * PageSize;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // This query fetches articles for the current page and counts total articles
                string query = @"
                    SELECT
                        Id, Title, Discription, ThumbPath, ImagePath, CreatedOn, author_editorid
                    FROM
                        dbo.News
                    WHERE
                        NewsCategoryId = @NewsCategoryId -- Filter by Editorial category
                    ORDER BY
                        CreatedOn DESC -- Order by most recent news
                    OFFSET @Offset ROWS
                    FETCH NEXT @PageSize ROWS ONLY;

                    SELECT COUNT(Id)
                    FROM dbo.News
                    WHERE NewsCategoryId = @NewsCategoryId;"; // Count total articles for pagination

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@NewsCategoryId", EditorialCategoryId);
                    cmd.Parameters.AddWithValue("@Offset", offset);
                    cmd.Parameters.AddWithValue("@PageSize", PageSize);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        // Read articles for the current page
                        DataTable dt = new DataTable();
                        dt.Load(reader); // Load the first result set (news articles)

                        // Move to the next result set (total count)
                        reader.NextResult();
                        int totalArticles = 0;
                        if (reader.Read())
                        {
                            totalArticles = reader.GetInt32(0); // Get the total count
                        }
                        reader.Close(); // Close reader as soon as we're done

                        rptNewsArticles.DataSource = dt;
                        rptNewsArticles.DataBind();

                        // Check if pnlNoArticles exists in FooterTemplate and set its visibility
                        if (rptNewsArticles.Controls.Count > 0 && rptNewsArticles.Controls[0] is RepeaterItem footerItem && footerItem.ItemType == ListItemType.Footer)
                        {
                            Panel pnlNoArticles = footerItem.FindControl("pnlNoArticles") as Panel;
                            if (pnlNoArticles != null)
                            {
                                pnlNoArticles.Visible = (totalArticles == 0);
                            }
                        }

                        GeneratePagination(totalArticles, currentPage);
                    }
                    catch (Exception ex)
                    {
                        // Log the error (e.g., using a logging framework)
                        // For demonstration, display a generic error message
                        // You might want a more user-friendly error page or message
                        Response.Write($"<div class='alert alert-danger'>Error loading articles: {ex.Message}</div>");
                    }
                }
            }
        }

        private int GetCurrentPage()
        {
            // Get page number from query string, default to 1
            if (int.TryParse(Request.QueryString["page"], out int page))
            {
                return Math.Max(1, page); // Ensure page is at least 1
            }
            return 1;
        }

        private void GeneratePagination(int totalArticles, int currentPage)
        {
            int totalPages = (int)Math.Ceiling((double)totalArticles / PageSize);
            paginationList.Controls.Clear(); // Clear existing links if any

            // Previous button
            string prevClass = (currentPage == 1) ? "page-item disabled" : "page-item";
            paginationList.Controls.Add(new LiteralControl($"<li class=\"{prevClass}\"><a class=\"page-link\" href=\"Editorial.aspx?page={currentPage - 1}\" tabindex=\"-1\" aria-disabled=\"true\">Previous</a></li>"));

            // Page numbers
            for (int i = 1; i <= totalPages; i++)
            {
                string pageClass = (i == currentPage) ? "page-item active" : "page-item";
                paginationList.Controls.Add(new LiteralControl($"<li class=\"{pageClass}\"><a class=\"page-link\" href=\"Editorial.aspx?page={i}\">{i}</a></li>"));
            }

            // Next button
            string nextClass = (currentPage == totalPages) ? "page-item disabled" : "page-item";
            paginationList.Controls.Add(new LiteralControl($"<li class=\"{nextClass}\"><a class=\"page-link\" href=\"Editorial.aspx?page={currentPage + 1}\">Next</a></li>"));
        }

        // Helper method for image URL, handling potential nulls or empty paths
        protected string GetImageUrl(object imagePath, object thumbPath)
        {
            if (imagePath != DBNull.Value && !string.IsNullOrEmpty(imagePath?.ToString()))
            {
                return ResolveUrl(imagePath.ToString());
            }
            else if (thumbPath != DBNull.Value && !string.IsNullOrEmpty(thumbPath?.ToString()))
            {
                return ResolveUrl(thumbPath.ToString());
            }
            // Provide a default placeholder image if both are null or empty
            return ResolveUrl("~/img/default-news.jpg"); // Make sure you have a default image here
        }
    }
}
