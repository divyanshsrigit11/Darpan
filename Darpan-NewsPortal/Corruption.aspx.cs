using System;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Darpan
{
    public partial class Corruption : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCorruptionNews();
            }
        }

        private void LoadCorruptionNews()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    // Select news where NewsCategory is 'Corruption'
                    string query = @"
                        SELECT N.Id, N.Title, N.Discription, N.ThumbPath, N.ImagePath, N.CreatedOn, N.IsActive
                        FROM dbo.News N
                        INNER JOIN dbo.NewsCategory NC ON N.NewsCategoryId = NC.Id
                        WHERE N.IsActive = 1 AND NC.NewsCategory = 'Corruption'
                        ORDER BY N.CreatedOn DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptCorruptionNews.DataSource = dt;
                            rptCorruptionNews.DataBind();
                            pnlNoContent.Visible = false; // Hide "No Content" message
                        }
                        else
                        {
                            rptCorruptionNews.DataSource = null;
                            rptCorruptionNews.DataBind();
                            pnlNoContent.Visible = true; // Show "No Content" message
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // In case of an error, hide the repeater and show the "No Content" message
                rptCorruptionNews.DataSource = null;
                rptCorruptionNews.DataBind();
                pnlNoContent.Visible = true;
            }
        }

        // Helper method to determine the correct image URL
        protected string GetImageUrl(object imagePath, object thumbPath)
        {
            string imgPath = imagePath as string;
            string tPath = thumbPath as string;

            if (!string.IsNullOrEmpty(imgPath))
            {
                return imgPath;
            }
            else if (!!string.IsNullOrEmpty(tPath))
            {
                return tPath;
            }
            else
            {
                // Return a placeholder image if neither path is available
                return "https://via.placeholder.com/600x400?text=No+Image";
            }
        }
    }
}