using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls; // For TextBox, Button, Repeater, Panel, etc.

namespace Darpan
{
    public partial class Panchayat : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set initial visibility for message and repeater
                pnlMessage.Visible = true;
                rptPanchayats.Visible = false;
            }
        }

        protected void btnSearchBlock_Click(object sender, EventArgs e)
        {
            int blockId;
            if (int.TryParse(txtBlockId.Text.Trim(), out blockId))
            {
                // Hide initial message, show results area
                pnlMessage.Visible = false;
                rptPanchayats.Visible = true;
                LoadPanchayatsByBlockId(blockId);
            }
            else
            {
                ShowMessage("Please enter a valid Block ID (e.g., 380-396).", "warning");
                rptPanchayats.Visible = false; // Hide results
            }
        }

        protected void btnSearchGramPanchayat_Click(object sender, EventArgs e)
        {
            int gramPanchayatId;
            if (int.TryParse(txtGramPanchayatId.Text.Trim(), out gramPanchayatId))
            {
                // Hide initial message, show results area
                pnlMessage.Visible = false;
                rptPanchayats.Visible = true;
                LoadPanchayatByGramPanchayatId(gramPanchayatId);
            }
            else
            {
                ShowMessage("Please enter a valid Gram Panchayat ID (e.g., 1-1000).", "warning");
                rptPanchayats.Visible = false; // Hide results
            }
        }

        private void LoadPanchayatsByBlockId(int blockId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Query dbo.tblGramPanchayat filtered by BlockID
                string query = "SELECT GramPanchayatID, GramPanchayatName, BlockID FROM dbo.tblGramPanchayat WHERE BlockID = @BlockID ORDER BY GramPanchayatName ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BlockID", blockId);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        dt.Load(reader); // Load all results for the block
                        reader.Close();

                        rptPanchayats.DataSource = dt;
                        rptPanchayats.DataBind();

                        // The Repeater's FooterTemplate will handle the "No results found" message
                        if (dt.Rows.Count == 0)
                        {
                            ShowMessage($"No Gram Panchayats found for Block ID: <strong>{blockId}</strong>.", "info");
                        }
                        else
                        {
                            // Clear any previous message if results are found
                            pnlMessage.Visible = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowMessage($"Error loading Gram Panchayats for Block ID {blockId}: {ex.Message}", "danger");
                        // Log this error properly
                    }
                }
            }
        }

        private void LoadPanchayatByGramPanchayatId(int gramPanchayatId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Query dbo.tblGramPanchayat for a single Gram Panchayat ID
                string query = "SELECT GramPanchayatID, GramPanchayatName, BlockID FROM dbo.tblGramPanchayat WHERE GramPanchayatID = @GramPanchayatID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@GramPanchayatID", gramPanchayatId);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        dt.Load(reader); // Load the single result (if found)
                        reader.Close();

                        rptPanchayats.DataSource = dt;
                        rptPanchayats.DataBind();

                        if (dt.Rows.Count == 0)
                        {
                            ShowMessage($"No Gram Panchayat found with ID: <strong>{gramPanchayatId}</strong>.", "info");
                        }
                        else
                        {
                            pnlMessage.Visible = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowMessage($"Error loading Gram Panchayat with ID {gramPanchayatId}: {ex.Message}", "danger");
                        // Log this error properly
                    }
                }
            }
        }

        // Helper method to display messages in the pnlMessage panel
        private void ShowMessage(string message, string type) // type can be 'info', 'warning', 'danger'
        {
            pnlMessage.CssClass = $"alert alert-{type} text-center mt-3";
            pnlMessage.Controls.Clear(); // Clear existing content
            pnlMessage.Controls.Add(new LiteralControl(message));
            pnlMessage.Visible = true;
            rptPanchayats.Visible = false; // Hide repeater when a message is displayed
        }
    }
}