using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Darpan
{
    public partial class Desh : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatesIntoDropdown();
                litSelectedState.Text = "No State Selected";
                litSelectedStateNews.Text = "No State Selected"; // Initialize for news section
                pnlMessage.Visible = true;
                rptStateInfo.Visible = false;

                // Ensure only explore section is visible initially
                pnlExploreStates.Visible = true;
                pnlGetStateNews.Visible = false;
                btnExploreStates.CssClass = "btn-mode active";
                btnGetStateNews.CssClass = "btn-mode";
            }
        }

        private void LoadStatesIntoDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT StateId, StateName FROM dbo.tblState WHERE IsActive = 1 ORDER BY StateName ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlStates.DataSource = reader;
                        ddlStates.DataTextField = "StateName";
                        ddlStates.DataValueField = "StateId";
                        ddlStates.DataBind();
                        reader.Close();

                        // Add a default "Select State" item if not already present
                        if (ddlStates.Items.FindByValue("0") == null)
                        {
                            ddlStates.Items.Insert(0, new ListItem("-- Select State --", "0"));
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log the exception (e.g., using a logging framework)
                        // Display a user-friendly error message
                        Response.Write($"<script>alert('Error loading states: {ex.Message}');</script>");
                    }
                }
            }
        }

        protected void ddlStates_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedStateId;
            if (int.TryParse(ddlStates.SelectedValue, out selectedStateId) && selectedStateId > 0)
            {
                litSelectedState.Text = ddlStates.SelectedItem.Text;
                litSelectedStateNews.Text = ddlStates.SelectedItem.Text; // Update for news section as well
                pnlMessage.Visible = false;
                rptStateInfo.Visible = true;

                LoadStateInformation(selectedStateId, ddlStates.SelectedItem.Text);
            }
            else
            {
                litSelectedState.Text = "No State Selected";
                litSelectedStateNews.Text = "No State Selected";
                pnlMessage.Visible = true;
                rptStateInfo.Visible = false;
                rptStateInfo.DataSource = null;
                rptStateInfo.DataBind();
            }
        }

        protected void btnExploreStates_Click(object sender, EventArgs e)
        {
            pnlExploreStates.Visible = true;
            pnlGetStateNews.Visible = false;
            btnExploreStates.CssClass = "btn-mode active";
            btnGetStateNews.CssClass = "btn-mode";
        }

        protected void btnGetStateNews_Click(object sender, EventArgs e)
        {
            pnlExploreStates.Visible = false;
            pnlGetStateNews.Visible = true;
            btnExploreStates.CssClass = "btn-mode";
            btnGetStateNews.CssClass = "btn-mode active";
        }

        private void LoadStateInformation(int stateId, string stateName)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("StateId", typeof(int));
            dt.Columns.Add("StateName", typeof(string));
            dt.Columns.Add("Info", typeof(string));

            // Simulating "No specific information found" for StateId 5 (Madhya Pradesh) and 10 (Tamil Nadu)
            if (stateId != 5 && stateId != 10)
            {
                DataRow dr = dt.NewRow();
                dr["StateId"] = stateId;
                dr["StateName"] = stateName;
                dr["Info"] = $"This is general information about **{stateName}**. Specific news updates are not yet available for this state. In a real system, news would be fetched here from a dedicated table.";
                dt.Rows.Add(dr);
            }

            rptStateInfo.DataSource = dt;
            rptStateInfo.DataBind();
        }
    }
}