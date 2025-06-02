using System;
using System.Web.Security; // For FormsAuthentication

namespace Darpan.AdminWeb
{
    public partial class AdminMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Dynamic content or checks based on user role
        }

        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx"); // Redirect to the login page
        }
    }
}