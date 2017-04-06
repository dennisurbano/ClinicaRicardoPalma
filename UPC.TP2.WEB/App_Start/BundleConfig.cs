using System.Web;
using System.Web.Optimization;

namespace UPC.TP2.WEB
{
    public class BundleConfig
    {
        // Para obtener más información acerca de Bundling, consulte http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                "~/Script/jquery.unobtrusive*",
                "~/Script/jquery.validate*"));

        }
    }
}