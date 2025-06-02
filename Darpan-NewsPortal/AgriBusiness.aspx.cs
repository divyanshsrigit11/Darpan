using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Darpan
{
    public partial class AgriBusiness : Page
    {
        private const int AgriBusinessCategoryId = 18; // ID for 'Agri Business' from dbo.NewsCategory

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

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Query to fetch news articles for the Agri Business category
                string query = @"
                    SELECT
                        Id, Title, Discription, ThumbPath, ImagePath, CreatedOn, author_editorid
                    FROM
                        dbo.News
                    WHERE
                        NewsCategoryId = @NewsCategoryId
                    ORDER BY
                        CreatedOn DESC;"; // Order by most recent first

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@NewsCategoryId", AgriBusinessCategoryId);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        rptNewsArticles.DataSource = reader;
                        rptNewsArticles.DataBind();

                        // Show/hide "No Content Available Yet" panel
                        pnlNoContent.Visible = rptNewsArticles.Items.Count == 0;
                        rptNewsArticles.Visible = rptNewsArticles.Items.Count > 0;

                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Handle database connection or query errors
                        // For debugging, you might display the error:
                        // Response.Write("<div class='alert alert-danger'>Database Error: " + ex.Message + "</div>");
                        pnlNoContent.Visible = true; // Show no content message on error
                        rptNewsArticles.Visible = false;
                    }
                }
            }
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
            return ResolveUrl("~/img/default-news.jpg"); // Ensure you have a default image here
        }
    }
}