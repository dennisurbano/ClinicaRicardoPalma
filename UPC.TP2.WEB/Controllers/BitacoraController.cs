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
    public class BitacoraController : Controller
    {
        private BDCLINICAEntities db = new BDCLINICAEntities();

        //
        // GET: /Bitacora/

        public ActionResult Index()
        {
            var t_bitacora_incidencia = db.T_BITACORA_INCIDENCIA.Include(t => t.T_EMPLEADO).Include(t => t.T_PLAN_DE_SALUD);
            BitacoraViewModel bvm = new BitacoraViewModel {
                BITACORAS = t_bitacora_incidencia.ToList(),
                PLANES_DE_SALUD = db.T_PLAN_DE_SALUD.Where(x => x.estado == "1" && x.fecha_inicio <= DateTime.Now && x.fecha_fin >= DateTime.Now).ToList()
            };
            return View(bvm);
        }

        public ActionResult ChangePlanSalud()
        {
            int id_plan_salud = 0;
            try {

                id_plan_salud = Int32.Parse(Request["bitacora_action_select_plan"]);
                ViewData["id_plan_salud"] = id_plan_salud.ToString();

            } catch (Exception e) {

                ViewBag.Message = "Su parámetros son incorrectos";
                return View("Index");
            }


            var t_bitacora_incidencia = db.T_BITACORA_INCIDENCIA.Include(t => t.T_EMPLEADO).Include(t => t.T_PLAN_DE_SALUD);
            BitacoraViewModel bvm = new BitacoraViewModel
            {
                BITACORAS = (id_plan_salud == -1) ? t_bitacora_incidencia.ToList() : t_bitacora_incidencia.Where(x => x.id_plan_salud == id_plan_salud).ToList(),
                PLANES_DE_SALUD = db.T_PLAN_DE_SALUD.Where(x => x.estado == "1" && x.fecha_inicio <= DateTime.Now && x.fecha_fin >= DateTime.Now).ToList(),
                EMPLEADOS = db.T_EMPLEADO.ToList()               
            };
            return View("Index", bvm);
        }

        //
        // GET: /Bitacora/Details/5

        public ActionResult Details(int id = 0)
        {
            T_BITACORA_INCIDENCIA t_bitacora_incidencia = db.T_BITACORA_INCIDENCIA.Find(id);
            if (t_bitacora_incidencia == null)
            {
                return HttpNotFound();
            }
            return View(t_bitacora_incidencia);
        }

        //
        // GET: /Bitacora/Create

        public ActionResult Create()
        {
            int bit_plan = Int32.Parse(Request["bitacora_action_select_plan"]);
            ViewData["id_plan_salud"] = bit_plan.ToString();

            string bit_tipo = Request["bitacora_tipo"];
            string bit_incidencia = Request["bitacora_incidencia"];
            string bit_seguimiento = Request["bitacora_seguimiento"];

            T_BITACORA_INCIDENCIA bit = new T_BITACORA_INCIDENCIA()
            {
                fecha_registro = DateTime.Now,
                descripcion = bit_incidencia,
                tipo_incidencia = bit_tipo,
                id_plan_salud  = bit_plan,
                estado = "ABIERTO"
            };


            try
            {
                db.T_BITACORA_INCIDENCIA.Add(bit);
                db.SaveChanges();

                T_SEGUIMIENTO bit_seg = new T_SEGUIMIENTO()
                {
                    id_bitacora = bit.id_bitacora,
                    id_plan_salud = bit_plan,
                    seguimiento = bit_seguimiento,
                    fecha_registro = DateTime.Now,
                    usuario = "DURBANO"
                    
                };

                db.T_SEGUIMIENTO.Add(bit_seg);
                db.SaveChanges();

                ViewBag.Message = "La incidencia a sido grabada correctamente";

                return RedirectToAction("Index");

            } catch (Exception e)
            {
                ViewBag.Message = "No se pudo grabar la incidencia";
                return View("Index");
            }
        }

        //
        // GET: /Bitacora/Edit/5

        public ActionResult Edit(int id = 0)
        {
            T_BITACORA_INCIDENCIA t_bitacora_incidencia = db.T_BITACORA_INCIDENCIA.Find(id);
            if (t_bitacora_incidencia == null)
            {
                return HttpNotFound();
            }

            BitacoraViewModel bvm = new BitacoraViewModel()
            {
                BITACORA = t_bitacora_incidencia
            };

            ViewBag.Message = TempData["Message"];
            return View("Edit", bvm);
        }

        public ActionResult EditSave()
        {
            int bit_id = Int32.Parse(Request["bitacora_edit_id"] ?? "-1");

            string bit_estado = Request["bitacora_edit_estado"] ?? String.Empty;
            string bit_seguimiento = Request["bitacora_edit_seguimiento"] ?? String.Empty;

            T_BITACORA_INCIDENCIA bit = db.T_BITACORA_INCIDENCIA.Find(bit_id);
            bit.estado = bit_estado;

            try
            {
                db.Entry(bit).State = EntityState.Modified;
                db.SaveChanges();

                if(bit_estado != String.Empty && bit_estado.ToLower() != "cerrado" && bit_estado.ToLower() != "rechazado")
                {
                    T_SEGUIMIENTO bit_seg = new T_SEGUIMIENTO()
                    {
                        id_bitacora = bit.id_bitacora,
                        id_plan_salud = bit.id_plan_salud,
                        seguimiento = bit_seguimiento,
                        fecha_registro = DateTime.Now,
                        usuario = "Dennis Urbano"
                    };

                    db.T_SEGUIMIENTO.Add(bit_seg);
                    db.SaveChanges();
                }

                ViewBag.Message = "La incidencia a sido grabada correctamente";
                TempData["Message"] = ViewBag.Message;
                return RedirectToAction("Edit", new { id = bit_id });

            }
            catch (Exception e)
            {
                ViewBag.Message = "No se pudo grabar la incidencia";
                TempData["Message"] = ViewBag.Message;
                return View("Edit");
            }
        }

        //
        // GET: /Bitacora/Delete/5

        public ActionResult Delete(int id = 0)
        {
            T_BITACORA_INCIDENCIA t_bitacora_incidencia = db.T_BITACORA_INCIDENCIA.Find(id);
            if (t_bitacora_incidencia == null)
            {
                return HttpNotFound();
            }
            return View(t_bitacora_incidencia);
        }

        //
        // POST: /Bitacora/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            T_BITACORA_INCIDENCIA t_bitacora_incidencia = db.T_BITACORA_INCIDENCIA.Find(id);
            db.T_BITACORA_INCIDENCIA.Remove(t_bitacora_incidencia);
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