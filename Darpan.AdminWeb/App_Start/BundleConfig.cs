using System.Web.Optimization; // Requires Microsoft.AspNet.Web.Optimization NuGet package

namespace Darpan.AdminWeb // IMPORTANT: Match your project's namespace
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include(
                            "~/Scripts/WebForms/WebForms.js",
                            "~/Scripts/WebForms/WebUIValidation.js",
                            "~/Scripts/WebForms/MenuStandards.js",
                            "~/Scripts/WebForms/GridView.js",
                            "~/Scripts/WebForms/DetailsView.js",
                            "~/Scripts/WebForms/FormView.js",
                            "~/Scripts/WebForms/Focus.js",
                            "~/Scripts/WebForms/WebParts.js",
                            "~/Scripts/WebForms/Theme.js",
                            "~/Scripts/WebForms/Validation.js"));

            // Set EnableOptimizations to false for debugging. For more information,
            // visit https://go.microsoft.com/fwlink/?LinkId=301862
            BundleTable.EnableOptimizations = true; // Set to false during development
        }
    }
}