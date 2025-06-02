using System;
using System.Web; // Needed for Response.Redirect

namespace Darpan.AdminWeb // CHANGED from Darpan.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // With authentication disabled, no need to sign out or clear session on load
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // FOR TESTING ONLY: Directly redirect to AdminDashboard without any authentication
            Response.Redirect("AdminDashboard.aspx"); // CHANGED path for consistency
        }
    }
}