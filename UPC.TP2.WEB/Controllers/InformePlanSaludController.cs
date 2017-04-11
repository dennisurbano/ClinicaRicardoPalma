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
                string estado_i = "0";
                string estado_a = "1";
                if (planes_salud_activos == "on" && planes_salud_inactivos == String.Empty)
                    estado_i = "1";
                if (planes_salud_activos == String.Empty && planes_salud_inactivos == "on")
                    estado_a = "0";

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

                //-- Personas con planes de salud -- > FILTRO
                var t_per_pla = (from per_pla in db.T_PERSONA_PLANSALUD.Where(x => x.fecha_inicio >= fi && x.fecha_fin <= ff).ToList()
                                join pla in db.T_PLAN_DE_SALUD on per_pla.id_plan_salud equals pla.id_plan_salud
                                where pla.estado == estado_i || pla.estado == estado_a
                                select new
                                {
                                    id_persona_plan = per_pla.id_persona_plansalud,
                                    fecha_inicio = per_pla.fecha_inicio,
                                    fecha_fin = per_pla.fecha_fin,
                                    codPersona = per_pla.codPersona,
                                    id_plan_salud = per_pla.id_plan_salud
                                }).ToList();

                //-- Comprobantes de personas con plan
                var com_perpla = (from per_pla in t_per_pla
                                  join com in db.T_COMPROBANTE on per_pla.codPersona equals com.codPersona
                                      orderby per_pla.id_plan_salud, per_pla.codPersona
                                      select new
                                      {
                                        id_comprobante = com.id_comprobante,
                                        fecha_pago = com.fecha_pago,
                                        codPersona = per_pla.codPersona,
                                        id_plan_salud = per_pla.id_plan_salud,
                                        total = com.total
                                      }).ToList();


                //[INFORME] Informe ingreso plan salud
                var informe_plan_salud = (from inf in com_perpla
                                         group inf by new { inf.id_plan_salud } into gb
                                         select new
                                         {
                                             id_plan_salud = gb.Key.id_plan_salud,
                                             nombre_plan_salud = db.T_PLAN_DE_SALUD.Find(gb.Key.id_plan_salud).nombre_plan,
                                             ingreso_neto = gb.Sum(x => x.total),
                                             periodo_inicio = Util.DateTimeYear(gb.Min(x => x.fecha_pago)),
                                             periodo_fin = Util.DateTimeYear(gb.Max(x => x.fecha_pago))
                                         }).ToList();

                //[INFORME] Cantidad de personas por plan de salud
                var informe_cantidad_personas = (from per_pla in t_per_pla
                                                 group per_pla by new { per_pla.id_plan_salud } into gb
                                                select new
                                                {
                                                    id_plan_salud = gb.Key.id_plan_salud,
                                                    nombre_plan_salud = db.T_PLAN_DE_SALUD.Find(gb.Key.id_plan_salud).nombre_plan,
                                                    estado = (db.T_PLAN_DE_SALUD.Find(gb.Key.id_plan_salud).estado == "0" ? "Inactivo" : "Activo"),
                                                    cantidad_personas = gb.Count(),
                                                    periodo_inicio = Util.DateTimeYear(gb.Min(x => x.fecha_inicio)),
                                                    periodo_fin = Util.DateTimeYear(gb.Max(x => x.fecha_fin))
                                                }).ToList();

                //[INFORME] Cantidad de citas por plan de salud
                var informe_cantidad_citas = (from per_pla in t_per_pla
                                              join pro in db.T_PROGRAMACION_MEDICA on per_pla.codPersona equals pro.codPersona
                                             group pro by new { per_pla.id_plan_salud } into gb
                                             select new
                                             {
                                                 id_plan_salud = gb.Key.id_plan_salud,
                                                 nombre_plan_salud = db.T_PLAN_DE_SALUD.Find(gb.Key.id_plan_salud).nombre_plan,
                                                 cantidad_citas = gb.Count(),
                                                 periodo_inicio = Util.DateTimeYear(gb.Min(x => x.fecha)),
                                                 periodo_fin = Util.DateTimeYear(gb.Max(x => x.fecha))
                                             }).ToList();




                InformePlanSaludViewModel ivm = new InformePlanSaludViewModel(){
                    JSON_INFORME_INGRESO_PLAN_SALUD = JArray.FromObject(informe_plan_salud, Util.jsonNoLoop()),
                    JSON_INFORME_PERSONA_PLAN_SALUD_PERIODO = JArray.FromObject(informe_cantidad_personas, Util.jsonNoLoop()),
                    JSON_INFORME_CITAS_PLAN_SALUD = JArray.FromObject(informe_cantidad_citas, Util.jsonNoLoop())
                };

                //Return view
                return View("Index", ivm);

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
