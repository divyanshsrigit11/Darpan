using System;
using System.Configuration; // For ConfigurationManager
using System.Data;
using System.Data.SqlClient; // For SQL Server interaction
using System.Web.UI;
using System.Web.UI.WebControls; // Required for Repeater, RadioButtonList

namespace Darpan
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set default selection to Lok Sabha (ID 5)
                rblCoverStoryType.SelectedValue = "5";
                BindCoverStory();
            }
        }

        private void BindCoverStory()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;
            int newsCategoryId = int.Parse(rblCoverStoryType.SelectedValue);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Query to fetch the latest single cover story for the selected category
                string query = @"
                    SELECT TOP 1
                        Id, Title, Discription, ThumbPath, ImagePath, CreatedOn, author_editorid
                    FROM
                        dbo.News
                    WHERE
                        NewsCategoryId = @NewsCategoryId
                    ORDER BY
                        CreatedOn DESC;"; // Get the most recent story

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@NewsCategoryId", newsCategoryId);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        rptCoverStory.DataSource = reader;
                        rptCoverStory.DataBind();

                        // Show/hide "No Content Available Yet" panel
                        pnlNoContent.Visible = rptCoverStory.Items.Count == 0;
                        rptCoverStory.Visible = rptCoverStory.Items.Count > 0;

                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Handle database connection or query errors
                        // For debugging, you might display the error:
                        // Response.Write("<div class='alert alert-danger'>Database Error: " + ex.Message + "</div>");
                        pnlNoContent.Visible = true; // Show no content message on error
                        rptCoverStory.Visible = false;
                    }
                }
            }
        }

        protected void rblCoverStoryType_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Rebind the cover story when a different radio button is selected
            BindCoverStory();
        }

        // Helper method for image URL, similar to Editorial.aspx.cs
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