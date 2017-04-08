using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UPC.TP2.WEB.Models;
using UPC.TP2.WEB.Utils;
using UPC.TP2.WEB.ViewModels;
using Newtonsoft.Json.Linq;

namespace UPC.TP2.WEB.Controllers
{
    public class InformePlanSaludController : Controller
    {
        private BDCLINICAEntities db = new BDCLINICAEntities();
        // GET: /InformePlanSalud/

        public ActionResult Index()
        {
            ViewBag.Message = TempData["inf_pla_sal.Message"] ?? String.Empty;
            ViewData["fecha_inicio"] = TempData["inf_pla_sal.fecha_inicio"] ?? String.Empty;
            ViewData["fecha_fin"] = TempData["inf_pla_sal.fecha_fin"] ?? String.Empty;
            ViewData["planes_salud_activos"] = TempData["inf_pla_sal.planes_salud_activos"] ?? false;
            ViewData["planes_salud_inactivos"] = TempData["inf_pla_sal.planes_salud_inactivos"] ?? false;

            return View();
        }

        public ActionResult IndexProcess()
        {
            try
            {
                //Catch data
                DateTime fi = DateTime.Parse(Request["informe_plan_salud_fecha_inicio"]);
                DateTime ff = DateTime.Parse(Request["informe_plan_salud_fecha_fin"]);
                string planes_salud_activos = Request["informe_planes_salud_estado_activos"] ?? String.Empty;
                string planes_salud_inactivos = Request["informe_planes_salud_estado_inactivos"] ?? String.Empty;
                //Binding data
                TempData["inf_pla_sal.fecha_inicio"] = Util.DateTimeToShort(fi);
                TempData["inf_pla_sal.fecha_fin"] = Util.DateTimeToShort(ff);
                TempData["inf_pla_sal.planes_salud_activos"] = planes_salud_activos;
                TempData["inf_pla_sal.planes_salud_inactivos"] = planes_salud_inactivos;

                ViewData["fecha_inicio"] = Util.DateTimeToShort(fi);
                ViewData["fecha_fin"] = Util.DateTimeToShort(ff);
                ViewData["planes_salud_activos"] = planes_salud_activos;
                ViewData["planes_salud_inactivos"] = planes_salud_inactivos;

                //Process

                //-- Informe persona plan
                object json_informe = from per_pla in db.T_PERSONA_PLANSALUD.ToList()
                                      join pla in db.T_PLAN_DE_SALUD on per_pla.id_plan_salud equals pla.id_plan_salud
                                      group new { per_pla, pla }
                                      by new { per_pla.id_plan_salud } into gb
                                      select new
                                      {

                                      };

                InformePlanSaludViewModel ivm = new InformePlanSaludViewModel(){
                    JSON_INFORME_INGRESO_PLAN_SALUD = JArray.FromObject(json_informe, Util.jsonNoLoop()),
                    JSON_INFORME_PERSONA_PLAN_SALUD_PERIODO = null,
                    JSON_INFORME_CITAS_PLAN_SALUD = null
                };

                //Return view
                return View("Index");

            }
            catch (Exception e)
            {
                TempData["inf_pla_sal.Message"] = "No se pudo generar el informe";
                return RedirectToAction("Index");
            }
        }

        //
        // GET: /InformePlanSalud/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /InformePlanSalud/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /InformePlanSalud/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /InformePlanSalud/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /InformePlanSalud/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /InformePlanSalud/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /InformePlanSalud/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
