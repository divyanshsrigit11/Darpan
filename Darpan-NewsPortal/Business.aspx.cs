using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Darpan
{
    public partial class Business : Page
    {
        private const int BusinessCategoryId = 17; // ID for 'Business'

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
                string query = @"
                    SELECT
                        Id, Title, Discription, ThumbPath, ImagePath, CreatedOn, author_editorid
                    FROM
                        dbo.News
                    WHERE
                        NewsCategoryId = @NewsCategoryId
                    ORDER BY
                        CreatedOn DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@NewsCategoryId", BusinessCategoryId);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        rptNewsArticles.DataSource = reader;
                        rptNewsArticles.DataBind();

                        pnlNoContent.Visible = rptNewsArticles.Items.Count == 0;
                        rptNewsArticles.Visible = rptNewsArticles.Items.Count > 0;

                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Log the error (e.g., to a file or monitoring system)
                        // For demonstration, you might display it or rethrow as a custom exception
                        // Response.Write("<div class='alert alert-danger'>Database Error: " + ex.Message + "</div>");
                        pnlNoContent.Visible = true; // Show no content message on error
                        rptNewsArticles.Visible = false;
                    }
                }
            }
        }

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
            return ResolveUrl("~/img/default-news.jpg"); // Fallback default image
        }
    }
}