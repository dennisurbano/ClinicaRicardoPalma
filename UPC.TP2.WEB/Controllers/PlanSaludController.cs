using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UPC.TP2.WEB.Models;
using System.Web.Helpers;
using UPC.TP2.WEB.ViewModels;
using UPC.TP2.WEB.Utils;

namespace UPC.TP2.WEB.Controllers
{
    public class PlanSaludController : Controller
    {
        private BDCLINICAEntities db = new BDCLINICAEntities();

        //
        // GET: /PlanSalud/

        public ActionResult Index()
        {
            //B:Get plan salud
            int id_plan_salud = 0; //Consider that if [id_plan_salud] does not exist, it is 0: Optionality change for -99 
            id_plan_salud = Int32.Parse(Request["plan_salud_action_select_plan"] ?? (TempData["pla_sal.id_plan_salud"] != null ? TempData["pla_sal.id_plan_salud"].ToString() : "-1")); //-1: All record by default
            ViewData["id_plan_salud"] = id_plan_salud.ToString();
            //E:Get plan salud

            //Get messages from others actions : When redirect to here
            ViewBag.Message = TempData["pla_sal.Message"] != null ? TempData["pla_sal.Message"].ToString() : String.Empty;

            PlanSaludViewModel pvm = new PlanSaludViewModel()
            {
                PLANES_DE_SALUD = db.T_PLAN_DE_SALUD.ToList(),
                PLAN_DE_SALUD = db.T_PLAN_DE_SALUD.Find(id_plan_salud) ?? new T_PLAN_DE_SALUD()
            };
            return View(pvm);
        }

        public ActionResult IndexSave()
        {
            try
            {
                int plan_salud_id = Int32.Parse(Request["plan_salud_id"]);
                T_PLAN_DE_SALUD ps = db.T_PLAN_DE_SALUD.Find(plan_salud_id);

                if (ps != null)
                {
                    TempData["pla_sal.id_plan_salud"] = plan_salud_id;

                    List<string> seguimiento = new List<string>(); //Cambios realizados para auditoria

                    if(ps.nombre_plan != Request["plan_salud_nombre"])
                    {
                        seguimiento.Add("Se ha modificado el campo NOMBRE_PLAN de <<" + ps.nombre_plan + ">> a " + "<<" + Request["plan_salud_nombre"] + ">>");
                        ps.nombre_plan = Request["plan_salud_nombre"];
                    }

                    if (ps.descripcion != Request["plan_salud_descripcion"])
                    {
                        seguimiento.Add("Se ha modificado el campo DESCRIPCION de <<" + ps.descripcion + ">> a " + "<<" + Request["plan_salud_descripcion"] + ">>");
                        ps.descripcion = Request["plan_salud_descripcion"];
                    }

                    // -- El campo fecha_inicio NO es modificable --

                    if (Util.DateTimeToShort(ps.fecha_fin) != Request["plan_salud_fecha_fin"])
                    {
                        seguimiento.Add("Se ha modificado el campo FECHA_FIN de <<" + ps.fecha_fin + ">> a " + "<<" + Request["plan_salud_fecha_fin"] + ">>");
                        ps.fecha_fin = DateTime.Parse(Request["plan_salud_fecha_fin"]);
                    }

                    if (ps.objetivo != Request["plan_salud_objetivo"])
                    {
                        seguimiento.Add("Se ha modificado el campo OBJETIVO de <<" + ps.objetivo + ">> a " + "<<" + Request["plan_salud_objetivo"] + ">>");
                        ps.objetivo = Request["plan_salud_objetivo"];
                    }

                    if (ps.estado != Request["plan_salud_estado"])
                    {
                        seguimiento.Add("Se ha modificado el campo ESTADO de <<" + ps.estado + ">> a " + "<<" + Request["plan_salud_estado"] + ">>");
                        ps.estado = Request["plan_salud_estado"];
                    }

                    db.Entry(ps).State = EntityState.Modified;
                    db.SaveChanges();

                    //B:Auditoria
                    if(seguimiento.Count > 0)
                    {
                        T_BITACORA_INCIDENCIA bt = new T_BITACORA_INCIDENCIA()
                        {
                            id_plan_salud = plan_salud_id,
                            tipo_incidencia = "APORTE",
                            fecha_registro = DateTime.Now,
                            descripcion = "MODIF.PLANSALUD",
                            estado = "COMPLETO"
                        };
                        db.T_BITACORA_INCIDENCIA.Add(bt);
                        db.SaveChanges();

                        foreach (var s in seguimiento)
                        {
                            T_SEGUIMIENTO sg = new T_SEGUIMIENTO()
                            {
                                id_bitacora = bt.id_bitacora,
                                seguimiento = s,
                                fecha_registro = DateTime.Now,
                                usuario = "DURBANO"
                            };
                            db.T_SEGUIMIENTO.Add(sg);
                            db.SaveChanges();
                        }
                    }                   
                    //E:Auditoria

                    TempData["pla_sal.Message"] = "El plan de salud ha sido modificado correctamente";

                } else
                {
                    TempData["pla_sal.Message"] = "El plan de salud que inteta modificar o existe";
                }               
            }
            catch (Exception e)
            {
                TempData["pla_sal.Message"] = "El plan de salud NO se ha modificado";
            }
            return RedirectToAction("Index");
        }

            //
            // GET: /PlanSalud/Details/5

            public ActionResult Details(int id = 0)
        {
            T_PLAN_DE_SALUD t_plan_de_salud = db.T_PLAN_DE_SALUD.Find(id);
            if (t_plan_de_salud == null)
            {
                return HttpNotFound();
            }
            return View(t_plan_de_salud);
        }

        //
        // GET: /PlanSalud/Create

        public ActionResult Create()
        {
            ViewBag.id_estrategia_comercial = new SelectList(db.T_ESTRATEGIA_COMERCIAL, "id_estrategia_comercial", "nombre");
            ViewBag.id_base_legal = new SelectList(db.T_BASE_LEGAL, "id_base_legal", "nombre_normativa");
            ViewBag.id_base_financiera = new SelectList(db.T_BASE_FINANCIERA, "id_base_financiera", "descripcion");
            ViewBag.id_investigacion_comercial = new SelectList(db.T_INVESTIGACION_COMERCIAL, "id_investigacion_comercial", "nombre");
            return View();
        }

        //
        // POST: /PlanSalud/Create

        [HttpPost]
        public ActionResult Create(T_PLAN_DE_SALUD planSalud)
        {

            if (ModelState.IsValid)
            {
                db.T_PLAN_DE_SALUD.Add(planSalud);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_investigacion_comercial = new SelectList(db.T_INVESTIGACION_COMERCIAL, "id_investigacion_comercial", "nombre", planSalud.id_investigacion_comercial);
            return View(planSalud);
        }

        //
        // GET: /PlanSalud/Edit/5

        public ActionResult Edit(int id = 0)
        {
            T_PLAN_DE_SALUD t_plan_de_salud = db.T_PLAN_DE_SALUD.Find(id);
            if (t_plan_de_salud == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_estrategia_comercial = new SelectList(db.T_ESTRATEGIA_COMERCIAL, "id_estrategia_comercial", "nombre");
            ViewBag.id_investigacion_comercial = new SelectList(db.T_INVESTIGACION_COMERCIAL, "id_investigacion_comercial", "nombre", t_plan_de_salud.id_investigacion_comercial);
            return View(t_plan_de_salud);
        }

        //
        // POST: /PlanSalud/Edit/5

        [HttpPost]
        public ActionResult Edit(T_PLAN_DE_SALUD t_plan_de_salud)
        {
            if (ModelState.IsValid)
            {
                db.Entry(t_plan_de_salud).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_investigacion_comercial = new SelectList(db.T_INVESTIGACION_COMERCIAL, "id_investigacion_comercial", "nombre", t_plan_de_salud.id_investigacion_comercial);
            return View(t_plan_de_salud);
        }

        //
        // GET: /PlanSalud/Delete/5

        public ActionResult Delete(int id = 0)
        {
            T_PLAN_DE_SALUD t_plan_de_salud;

                t_plan_de_salud = db.T_PLAN_DE_SALUD.Find(id);

                if (t_plan_de_salud == null)
                {
                    return HttpNotFound();
                }

            return View(t_plan_de_salud);
        }

        //
        // POST: /PlanSalud/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            T_PLAN_DE_SALUD t_plan_de_salud = db.T_PLAN_DE_SALUD.Find(id);
            db.T_PLAN_DE_SALUD.Remove(t_plan_de_salud);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}