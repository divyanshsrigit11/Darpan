using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Darpan
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to Home.aspx if not a postback
            if (!IsPostBack)
            {
                Response.Redirect("~/Home.aspx", true); // The 'true' ensures the current response ends, preventing further processing
            }
        }
    }
}
