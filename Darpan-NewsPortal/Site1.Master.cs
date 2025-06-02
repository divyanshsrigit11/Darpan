// Site1.master.cs
using System;
using System.Web.UI;

namespace Darpan
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // You can add server-side logic here if needed.
            // For example, if you wanted to set an initial time from the server:
            // liveTime.InnerText = DateTime.Now.ToLongTimeString();
            // currentDate.InnerText = DateTime.Now.ToLongDateString();
        }
    }
}

