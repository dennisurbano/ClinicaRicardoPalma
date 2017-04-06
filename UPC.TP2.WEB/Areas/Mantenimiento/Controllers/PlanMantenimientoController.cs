using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UPC.TP2.WEB.Areas.Mantenimiento.Models;
using UPC.TP2.WEB.Models;

namespace UPC.TP2.WEB.Areas.Mantenimiento.Controllers
{
    public class PlanMantenimientoController : Controller
    {
        //
        // GET: /Mantenimiento/PlanMantenimiento/

        public ActionResult Index()
        {
            @ViewBag.Modulo_Titulo = "Planes de Mantenimiento";

            List<SelectListItem> Provinces = new List<SelectListItem>();
            Provinces.Add(new SelectListItem() { Text = "APROBADO", Value = "001" });
            Provinces.Add(new SelectListItem() { Text = "REGISTRADO", Value = "002" });
            Provinces.Add(new SelectListItem() { Text = "RECHAZADO", Value = "003" });

            PlanMantenimientoModel planMnt=new PlanMantenimientoModel();
            planMnt.EstadoPlan = new SelectList(Provinces, "Value", "Text"); ;

            return View(planMnt);
        }



        public ActionResult PendienteMantenimiento()
        {
            return View();
        }
     
    }
}
