using System.Web.Mvc;

namespace UPC.TP2.WEB.Areas.Mantenimiento
{
    public class MantenimientoAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Mantenimiento";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Mantenimiento_default",
                "Mantenimiento/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
