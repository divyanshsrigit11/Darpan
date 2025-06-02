using System;
using System.Configuration; // For ConfigurationManager
using System.Data;          // For DataTable
using System.Data.SqlClient; // For SQL Server interaction
using System.Web.UI;
using System.Web.UI.WebControls; // For DropDownList, Repeater, Image controls

namespace Darpan
{
    public partial class District : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDistrictsIntoDropdown();
            }
        }

        private void LoadDistrictsIntoDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // CORRECTED LINE: Use 'Districtid' instead of 'Id'
                string query = "SELECT Districtid, DistrictName FROM dbo.tblDistrict ORDER BY DistrictName ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlDistricts.DataSource = reader;
                        ddlDistricts.DataTextField = "DistrictName"; // Column to display in dropdown

                        // CORRECTED LINE: Use 'Districtid' instead of 'Id'
                        ddlDistricts.DataValueField = "Districtid"; // Column to use as value (DistrictId)

                        ddlDistricts.DataBind();
                        reader.Close(); // Close the reader after binding

                        // Add the default "Select District" item back
                        ddlDistricts.Items.Insert(0, new ListItem("-- Select District --", "0"));

                        // Set initial state for news panel
                        litSelectedDistrict.Text = "No District Selected";
                        pnlNoNewsMessage.Visible = true; // Show initial message
                        rptDistrictNews.Visible = false; // Hide repeater initially
                    }
                    catch (Exception ex)
                    {
                        // Log the error (e.g., to a file)
                        Response.Write($"<div class='alert alert-danger mt-3'>Error loading districts: {ex.Message}</div>");
                    }
                }
            }
        }

        protected void ddlDistricts_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedDistrictId;
            if (int.TryParse(ddlDistricts.SelectedValue, out selectedDistrictId) && selectedDistrictId > 0)
            {
                // Update the displayed district name
                litSelectedDistrict.Text = ddlDistricts.SelectedItem.Text;

                // Hide initial message, show news area
                pnlNoNewsMessage.Visible = false;
                rptDistrictNews.Visible = true;

                // THIS IS WHERE YOU WILL EVENTUALLY LOAD THE NEWS
                LoadDistrictNews(selectedDistrictId);
            }
            else
            {
                // If "Select District" is chosen
                litSelectedDistrict.Text = "No District Selected";
                pnlNoNewsMessage.Visible = true; // Show initial message
                rptDistrictNews.Visible = false; // Hide repeater
                rptDistrictNews.DataSource = null; // Clear any old data
                rptDistrictNews.DataBind();
            }
        }

        private void LoadDistrictNews(int districtId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // IMPORTANT: In the future, this query will filter by DistrictId
                // For now, it will simply return no news, or all news if you remove WHERE clause for testing
                // Make sure your dbo.News table has news with DistrictId values corresponding to dbo.tblDistrict
                string query = @"
                    SELECT
                        Id, Title, Discription, ThumbPath, ImagePath, CreatedOn, author_editorid
                    FROM
                        dbo.News
                    WHERE
                        DistrictId = @DistrictId
                    ORDER BY
                        CreatedOn DESC;"; // Order by most recent news

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@DistrictId", districtId); // Pass the selected district ID

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        reader.Close();

                        rptDistrictNews.DataSource = dt;
                        rptDistrictNews.DataBind();

                        // The FooterTemplate of the Repeater will handle the "No news found" message
                        // if dt.Rows.Count is 0.
                    }
                    catch (Exception ex)
                    {
                        // Log the error
                        Response.Write($"<div class='alert alert-danger mt-3'>Error loading news for district {ddlDistricts.SelectedItem.Text}: {ex.Message}</div>");
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
            return ResolveUrl("~/img/default-news.jpg"); // Ensure this default image exists!
        }
    }
}