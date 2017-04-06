using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UPC.TP2.WEB.Models;
using UPC.TP2.WEB.ViewModels;

namespace UPC.TP2.WEB.Controllers
{
    public class EstrategiaComercialController : Controller
    {
        private BDCLINICAEntities db = new BDCLINICAEntities();

        //
        // GET: /EstrategiaComercial/

        public ActionResult Index()
        {
            //B:Get plan salud
            int id_plan_salud = 0; //Consider that if [id_plan_salud] does not exist, it is 0: Optionality change for -99 
            id_plan_salud = Int32.Parse(Request["estrategia_comercial_action_select_plan"] ?? (TempData["est_com.id_plan_salud"] != null ? TempData["est_com.id_plan_salud"].ToString() : "-1")); //-1: All record by default
            ViewData["id_plan_salud"] = id_plan_salud.ToString();
            //E:Get plan salud

            //Get messages from others actions : When redirect to here
            ViewBag.Message = TempData["est_com.Message"] != null ? TempData["est_com.Message"].ToString() : String.Empty;

            //==== BEGIN: Main process
            var t_estrategia_comercial = db.T_ESTRATEGIA_COMERCIAL.Include(t => t.T_PLAN_DE_SALUD);
            var tv_estrategia_comercial = from est_com in t_estrategia_comercial
                                          select new TV_ESTRATEGIA_COMERCIAL
                                          {
                                            id_estrategia_comercial = est_com.id_estrategia_comercial,
                                            nombre = est_com.nombre,
                                            descripcion = est_com.descripcion,
                                            objetivo = est_com.objetivo,
                                            fecha_registro = est_com.fecha_registro,
                                            fecha_fin = est_com.T_ESTRATEGIA_COMERCIAL_DETALLE.Max(x => x.fecha_fin),
                                            presupuesto = est_com.presupuesto,
                                            real = est_com.T_ESTRATEGIA_COMERCIAL_DETALLE.Sum(x => x.monto),
                                            desviacion = (est_com.presupuesto - est_com.T_ESTRATEGIA_COMERCIAL_DETALLE.Sum(x => x.monto)) / est_com.presupuesto,
                                            id_plan_salud = est_com.id_plan_salud
                                          };

            EstrategiaComercialViewModel evm = new EstrategiaComercialViewModel
            {
                ESTRATEGIAS_COMERCIALES = id_plan_salud > 0 ? tv_estrategia_comercial.Where(x => x.id_plan_salud == id_plan_salud).ToList() : tv_estrategia_comercial.ToList(),
                PLANES_DE_SALUD = db.T_PLAN_DE_SALUD.Where(x => x.estado == "1" && x.fecha_inicio <= DateTime.Now && x.fecha_fin >= DateTime.Now).ToList()
            };
            //==== END: Main process

            return View(evm);
        }

        //
        // GET: /EstrategiaComercial/Details/5

        public ActionResult Details(int id = 0)
        {
            T_ESTRATEGIA_COMERCIAL t_estrategia_comercial = db.T_ESTRATEGIA_COMERCIAL.Find(id);
            if (t_estrategia_comercial == null)
            {
                return HttpNotFound();
            }
            return View(t_estrategia_comercial);
        }

        //
        // GET: /EstrategiaComercial/Create

        public ActionResult Create()
        {
            T_ESTRATEGIA_COMERCIAL est_com = null;

            try
            {
                int est_com_plan = Int32.Parse(Request["estrategia_comercial_action_select_plan"]);
                TempData["est_com.id_plan_salud"] = est_com_plan.ToString();

                string est_com_nombre = Request["estrategia_comercial_nombre"];
                string est_com_objetivo = Request["estrategia_comercial_objetivo"];
                decimal est_com_presupuesto = Decimal.Parse(Request["estrategia_comercial_presupuesto"]);

                est_com = new T_ESTRATEGIA_COMERCIAL()
                {
                    nombre = est_com_nombre,
                    objetivo = est_com_objetivo,
                    fecha_registro = DateTime.Now,
                    presupuesto = est_com_presupuesto,
                    id_plan_salud = est_com_plan
                };
            }
            catch (Exception e)
            {
                TempData["est_com.Message"] = "No se pudo grabar la Estrategia Comercial";
                return RedirectToAction("Index");
            }

            try
            {
                db.T_ESTRATEGIA_COMERCIAL.Add(est_com);
                db.SaveChanges();

                TempData["est_com.Message"] = "La Estrategia Comercial a sido grabada correctamente";

            }
            catch (Exception e)
            {
                TempData["est_com.Message"] = "No se pudo grabar la Estrategia Comercial";
            }

            return RedirectToAction("Index");
        }

        //
        // GET: /EstrategiaComercial/Edit/5

        public ActionResult Edit(int id = 0)
        {
            ViewBag.Message = TempData["est_com.Message"] != null ? TempData["est_com.Message"].ToString() : String.Empty;

            T_ESTRATEGIA_COMERCIAL t_estrategia_comercial = db.T_ESTRATEGIA_COMERCIAL.Find(id);
            if (t_estrategia_comercial == null)
            {
                return HttpNotFound();
            }

            EstrategiaComercialViewModel evm = new EstrategiaComercialViewModel()
            {
                ESTRATEGIA_COMERCIAL = t_estrategia_comercial
            };

            return View(evm);
        }

        public ActionResult EditDetalleSave()
        {
            int est_com_id = Int32.Parse(Request["estrategia_comercial_id"]??"-1");
            try
            {
                string[] est_com_det_id = Request["list_estrategia_comercial_detalle_id"].Split(',');
                string[] est_com_det_estado = Request["list_estrategia_comercial_detalle_estado"].Split(',');

                for (int i = 0; i < est_com_det_id.Length; i++ )
                {
                    int det_id = Int32.Parse(est_com_det_id[i]);
                    T_ESTRATEGIA_COMERCIAL_DETALLE ecd = db.T_ESTRATEGIA_COMERCIAL_DETALLE.Find(det_id);
                    ecd.estado = est_com_det_estado[i];
                    db.Entry(ecd).State = EntityState.Modified;
                    db.SaveChanges();
                }
                TempData["est_com.Message"] = "Los cambios se han guardado correctamente";
            }
            catch (Exception e)
            {
                TempData["est_com.Message"] = "Los cambios no han sido guardados";
            }

            return RedirectToAction("Edit", new { id = est_com_id });
        }

        public ActionResult CreateDetalleSave()
        {
            T_ESTRATEGIA_COMERCIAL_DETALLE est_com_det = null;
            int est_com_id = Int32.Parse(Request["estrategia_comercial_id"]);

            try
            {
                string est_com_det_medio = Request["estrategia_comercial_detalle_medio"];
                string est_com_det_canal = Request["estrategia_comercial_detalle_canal"];
                string est_com_det_fecha_inicio = Request["estrategia_comercial_detalle_fecha_inicio"];
                string est_com_det_fecha_fin = Request["estrategia_comercial_detalle_fecha_fin"];
                decimal est_com_det_monto = Decimal.Parse(Request["estrategia_comercial_detalle_monto"]);
                string est_com_det_estado = Request["estrategia_comercial_detalle_estado"];
                string est_com_det_objetivo = Request["estrategia_comercial_detalle_objetivo"];

                int cd = Utils.Util.compareDates(est_com_det_fecha_inicio, est_com_det_fecha_fin);
                if(cd != 1)
                {
                    TempData["est_com.Message"] = "Error: " + Utils.Util.compareDatesMessage(cd);
                    return RedirectToAction("Edit", new { id = est_com_id });
                }


                est_com_det = new T_ESTRATEGIA_COMERCIAL_DETALLE()
                {
                    medio_campana = est_com_det_medio,
                    canal = est_com_det_canal,
                    fecha_inicio = DateTime.Parse(est_com_det_fecha_inicio),
                    fecha_fin = DateTime.Parse(est_com_det_fecha_fin),
                    monto = est_com_det_monto,
                    estado = est_com_det_estado,
                    objetivo = est_com_det_objetivo,
                    usuario = "DENNIS URBANO",
                    id_estrategia_comercial = est_com_id
                };
            }
            catch (Exception e)
            {
                TempData["est_com.Message"] = "No se pudo grabar el detalle de estrategia comercial";
                return RedirectToAction("Edit", new { id = est_com_id });
            }

            try
            {
                db.T_ESTRATEGIA_COMERCIAL_DETALLE.Add(est_com_det);
                db.SaveChanges();

                TempData["est_com.Message"] = "El detalle de la estrategia a sigo guardada correctamente";

            }
            catch (Exception e)
            {
                TempData["est_com.Message"] = "No se pudo grabar el detalle de estrategia comercial";
            }

            return RedirectToAction("Edit", new { id = est_com_id });
        }

        //
        // GET: /EstrategiaComercialDetalle/Delete/5/1

        public ActionResult DeleteDetalle(int id = 0, int id_det = 0)
        {
            T_ESTRATEGIA_COMERCIAL_DETALLE t_estrategia_comercial_detalle = db.T_ESTRATEGIA_COMERCIAL_DETALLE.Find(id_det);

            if (t_estrategia_comercial_detalle != null)
            {
                TempData["est_com.Message"] = "El detalle a sido eliminado correctamente";
                db.T_ESTRATEGIA_COMERCIAL_DETALLE.Remove(t_estrategia_comercial_detalle);
                db.SaveChanges();
            } else
            {
                TempData["est_com.Message"] = "No se ha eliminado el detalle";
            }

            return RedirectToAction("Edit", new { id = id });
        }

        //
        // GET: /EstrategiaComercial/Delete/5

        public ActionResult Delete(int id = 0)
        {
            T_ESTRATEGIA_COMERCIAL t_estrategia_comercial = db.T_ESTRATEGIA_COMERCIAL.Find(id);
            if (t_estrategia_comercial == null)
            {
                return HttpNotFound();
            }
            return View(t_estrategia_comercial);
        }

        //
        // POST: /EstrategiaComercial/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            T_ESTRATEGIA_COMERCIAL t_estrategia_comercial = db.T_ESTRATEGIA_COMERCIAL.Find(id);
            db.T_ESTRATEGIA_COMERCIAL.Remove(t_estrategia_comercial);
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