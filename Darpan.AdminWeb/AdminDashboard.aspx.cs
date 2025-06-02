using Darpan.Core; // This is the correct using statement for Util now
using System;
using System.Data;
using System.Web;

namespace Darpan.AdminWeb
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // With authentication disabled, no need for session checks here
                // Page.Title = "दर्पण द मिरर | Admin - Dashboard";
                SetDashboard();
            }
        }

        void SetDashboard()
        {
            Util u = new Util();
            DataSet ds = u.GetUserDashboard(); // This method should fetch all required counts

            // Populate labels from the DataSet tables
            // Ensure the columns "TotalNews", "TotalGalleryImages", etc., exist in the respective DataTables
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                lblTotalNews.InnerText = ds.Tables[0].Rows[0]["TotalNews"].ToString();
            }
            if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
            {
                lblTotalGallery.InnerText = ds.Tables[1].Rows[0]["TotalGalleryImages"].ToString();
            }
            if (ds.Tables.Count > 2 && ds.Tables[2].Rows.Count > 0)
            {
                lblTotalCategries.InnerText = ds.Tables[2].Rows[0]["TotalCategories"].ToString();
            }
            if (ds.Tables.Count > 3 && ds.Tables[3].Rows.Count > 0)
            {
                lblTotalBrking.InnerText = ds.Tables[3].Rows[0]["TotalBreakingNews"].ToString();
            }
            if (ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0)
            {
                lblTotalAds.InnerText = ds.Tables[4].Rows[0]["TotalAdvertisements"].ToString();
            }
            if (ds.Tables.Count > 5 && ds.Tables[5].Rows.Count > 0)
            {
                lblTotalUsers.InnerText = ds.Tables[5].Rows[0]["TotalUsers"].ToString();
            }
        }
    }
}