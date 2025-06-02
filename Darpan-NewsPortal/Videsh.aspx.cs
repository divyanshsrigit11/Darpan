using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Darpan
{
    public partial class Videsh : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCountriesIntoDropdown();
                litSelectedCountry.Text = "No Country Selected";
                litSelectedCountryNews.Text = "No Country Selected"; // Initialize for news section
                pnlMessage.Visible = true;
                rptCountryInfo.Visible = false;

                // Ensure only explore section is visible initially
                pnlExploreCountries.Visible = true;
                pnlGetCountryNews.Visible = false;
                btnExploreCountries.CssClass = "btn-mode active";
                btnGetCountryNews.CssClass = "btn-mode";
            }
        }

        private void LoadCountriesIntoDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CountryId, CountryName FROM dbo.tblCountry WHERE IsActive = 1 ORDER BY CountryName ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlCountries.DataSource = reader;
                        ddlCountries.DataTextField = "CountryName";
                        ddlCountries.DataValueField = "CountryId";
                        ddlCountries.DataBind();
                        reader.Close();

                        // Add a default "Select Country" item if not already present
                        if (ddlCountries.Items.FindByValue("0") == null)
                        {
                            ddlCountries.Items.Insert(0, new ListItem("-- Select Country --", "0"));
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log the exception (e.g., using a logging framework)
                        // Display a user-friendly error message
                        Response.Write($"<script>alert('Error loading countries: {ex.Message}');</script>");
                    }
                }
            }
        }

        protected void ddlCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedCountryId;
            if (int.TryParse(ddlCountries.SelectedValue, out selectedCountryId) && selectedCountryId > 0)
            {
                litSelectedCountry.Text = ddlCountries.SelectedItem.Text;
                litSelectedCountryNews.Text = ddlCountries.SelectedItem.Text; // Update for news section as well
                pnlMessage.Visible = false;
                rptCountryInfo.Visible = true;

                LoadCountryInformation(selectedCountryId, ddlCountries.SelectedItem.Text);
            }
            else
            {
                litSelectedCountry.Text = "No Country Selected";
                litSelectedCountryNews.Text = "No Country Selected";
                pnlMessage.Visible = true;
                rptCountryInfo.Visible = false;
                rptCountryInfo.DataSource = null;
                rptCountryInfo.DataBind();
            }
        }

        protected void btnExploreCountries_Click(object sender, EventArgs e)
        {
            pnlExploreCountries.Visible = true;
            pnlGetCountryNews.Visible = false;
            btnExploreCountries.CssClass = "btn-mode active";
            btnGetCountryNews.CssClass = "btn-mode";
        }

        protected void btnGetCountryNews_Click(object sender, EventArgs e)
        {
            pnlExploreCountries.Visible = false;
            pnlGetCountryNews.Visible = true;
            btnExploreCountries.CssClass = "btn-mode";
            btnGetCountryNews.CssClass = "btn-mode active";
        }

        private void LoadCountryInformation(int countryId, string countryName)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CountryId", typeof(int));
            dt.Columns.Add("CountryName", typeof(string));
            dt.Columns.Add("Info", typeof(string));

            // Simulating "No specific information found" for CountryId 3 (Canada) and 8 (Brazil)
            if (countryId != 3 && countryId != 8)
            {
                DataRow dr = dt.NewRow();
                dr["CountryId"] = countryId;
                dr["CountryName"] = countryName;
                dr["Info"] = $"This is general information about **{countryName}**. Specific news updates are not yet available for this country. In a real system, news would be fetched here from a dedicated table.";
                dt.Rows.Add(dr);
            }

            rptCountryInfo.DataSource = dt;
            rptCountryInfo.DataBind();
        }
    }
}