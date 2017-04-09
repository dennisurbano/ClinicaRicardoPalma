using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UPC.TP2.WEB.Models;
using UPC.TP2.WEB.ViewModels;
using UPC.TP2.WEB.Utils;

namespace UPC.TP2.WEB.PlanSalud.Controllers
{
    public class GenerarServiciosPlanController : Controller
    {
        private BDCLINICAEntities db = new BDCLINICAEntities();
        // GET: /GenerarServiciosPlan/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Generar()
        {
            //Validation dates

            HttpRequestBase request = Request.Form.AllKeys.Length == 0 ? (HttpRequestBase)TempData["request"] : Request;
            ViewBag.Message = TempData["Message"];

            string fi = request != null ? request["fecha_inicio"] ?? String.Empty : String.Empty;
            string ff = request != null ? request["fecha_fin"] ?? String.Empty : String.Empty;

            ViewBag.FechaInicio = fi;
            ViewBag.FechaFin = ff;

            if (fi == String.Empty || ff == String.Empty)
            {
                return View("Index");
            }
            else
            {
                try
                {

                    DateTime dtfi = DateTime.Parse(fi);
                    DateTime dtff = DateTime.Parse(ff);

                    long dif = dtff.CompareTo(dtfi);

                    if (dif < 0)
                    {
                        ViewBag.Message = "La fecha final no debe ser menor que la inicial";
                        return View("Index");
                    }

                }
                catch (FormatException)
                {
                    ViewBag.Message = "Verifique que las fechas sean correctas";
                    return View("Index");
                }
            }

            //-- BEGIN: Full logic 

            DateTime FechaInicio = DateTime.Parse(fi);
            DateTime FechaFin = DateTime.Parse(ff);

            List<T_PROGRAMACION_MEDICA> ret_serv = db.T_PROGRAMACION_MEDICA
                .Where(x => x.fecha >= FechaInicio && x.fecha <= FechaFin)
                .ToList();

            List<T_PROGRAMACION_MEDICA> asi_plan = db.T_PROGRAMACION_MEDICA
                .Where(x => x.fecha >= FechaInicio && x.fecha <= FechaFin)
                .ToList();

            List<T_ESPECIALIDAD_MEDICA> esp = db.T_ESPECIALIDAD_MEDICA.ToList();
            List<T_ESPECIALIDAD_SERVICIO> esp_serv = db.T_ESPECIALIDAD_SERVICIO.ToList();
            List<T_PLAN_DE_SALUD> pla_salu = db.T_PLAN_DE_SALUD.ToList();
            List<T_PERSONA_PLANSALUD> per_pla_salu = db.T_PERSONA_PLANSALUD.ToList();

            T_CONFIGURACION config_asignar = db.T_CONFIGURACION.Where(x => x.indicador == "asignar_servicio").FirstOrDefault();
            T_CONFIGURACION config_retirar = db.T_CONFIGURACION.Where(x => x.indicador == "retirar_servicio").FirstOrDefault();

            //## JOINS FOR RETIRO/ASIGNACION

            //-- Programaciones 
            var obj_pro = (from pro in ret_serv.Where(x => x.estado == "1")
                           select new
                           {
                               pro.codPersona,
                               pro.id_programacion,                              
                               pro.idEspecialidad,
                               pro.id_servicio,
                               pro.fecha
                           }).ToList();

            //-- Programaciones para personas con plan
            var obj_pro_perpla =   (from pro in ret_serv.Where(x => x.estado == "1")
                                       join per_pla in db.T_PERSONA_PLANSALUD on pro.codPersona equals per_pla.codPersona
                                       where pro.fecha >= per_pla.fecha_inicio && pro.fecha <= per_pla.fecha_fin
                                       orderby per_pla.id_plan_salud, pro.idEspecialidad, pro.id_servicio
                                       select new
                                       {
                                           pro.codPersona,
                                           pro.id_programacion,
                                           per_pla.id_plan_salud,
                                           pro.idEspecialidad,
                                           pro.id_servicio,
                                           pro.fecha
                                       }).ToList();

            //-- Servicios con planes
            var obj_plaser_espser =  (from pla_ser in db.T_PLAN_SERVICIO.Where(x => x.estado == "1").ToList()
                                        join esp_ser in db.T_ESPECIALIDAD_SERVICIO on 
                                            new { pla_ser.idEspecialidad, pla_ser.id_servicio } equals 
                                            new { esp_ser.idEspecialidad, esp_ser.id_servicio }
                                        orderby pla_ser.id_plan_salud, pla_ser.idEspecialidad, pla_ser.id_servicio
                                        select new
                                        {
                                            pla_ser.id_plan_salud,
                                            esp_ser.idEspecialidad,
                                            esp_ser.id_servicio
                                        }).ToList();

            //-- Servicios sin planes
            var obj_plaser_espser_not = (from esp_ser in db.T_ESPECIALIDAD_SERVICIO
                                         join pla_ser in db.T_PLAN_SERVICIO on 
                                            new { esp_ser.idEspecialidad, esp_ser.id_servicio } equals
                                            new { pla_ser.idEspecialidad, pla_ser.id_servicio } into jg
                                         from pla_ser in jg.DefaultIfEmpty()
                                         orderby esp_ser.idEspecialidad, esp_ser.id_servicio
                                         where pla_ser == null
                                         select new
                                         {
                                             esp_ser.idEspecialidad,
                                             esp_ser.id_servicio
                                         }).ToList();


            //## TABLA DE RETIRO

            var obj_ret_serv = new List<object>();

            foreach (var plaser in obj_plaser_espser)
            {
                int cant = 0;
                foreach (var pro in obj_pro_perpla)
                {
                    if(pro.id_plan_salud == plaser.id_plan_salud && pro.idEspecialidad == plaser.idEspecialidad && pro.id_servicio == plaser.id_servicio)
                    {
                        cant++;
                    }
                }

                object ret_ser = new
                {
                    id_plan_salud = plaser.id_plan_salud,
                    id_especialidad = plaser.idEspecialidad,
                    id_servicio = plaser.id_servicio,
                    nombre_plan_salud = db.T_PLAN_DE_SALUD.Find(plaser.id_plan_salud).nombre_plan,
                    nombre_especialidad = db.T_ESPECIALIDAD_MEDICA.Find(plaser.idEspecialidad).nomEspecialidad,
                    nombre_servicio = db.T_SERVICIO_SALUD.Find(plaser.id_servicio).nombre_servicio,
                    cantidad = cant,
                    color = (cant >= Int32.Parse(config_retirar.valor_minimo) && cant <= Int32.Parse(config_retirar.valor_maximo)) ? "orange" : String.Empty
                };

                obj_ret_serv.Add(ret_ser);
            }

            //## TABLA DE ASIGNACION

            var obj_asi_plan = new List<object>();

            foreach (var plaser in obj_plaser_espser_not)
            {
                int cant = 0;
                foreach (var pro in obj_pro)
                {
                    if (pro.idEspecialidad == plaser.idEspecialidad && pro.id_servicio == plaser.id_servicio)
                    {
                        cant++;
                    }
                }

                object ret_asi = new
                {
                    id_especialidad = plaser.idEspecialidad,
                    id_servicio = plaser.id_servicio,
                    nombre_especialidad = db.T_ESPECIALIDAD_MEDICA.Find(plaser.idEspecialidad).nomEspecialidad,
                    nombre_servicio = db.T_SERVICIO_SALUD.Find(plaser.id_servicio).nombre_servicio,
                    cantidad = cant,
                    color = (cant >= Int32.Parse(config_asignar.valor_minimo) && cant <= Int32.Parse(config_asignar.valor_maximo)) ? "orange" : String.Empty
                };

                obj_asi_plan.Add(ret_asi);
            }

            /*
            object obj_asi_plan = from pro in asi_plan
                                  join per in db.T_PERSONA on pro.codPersona equals per.codPersona
                                  join pla_ser in db.T_PLAN_SERVICIO on 
                                    new { pro.idEspecialidad, pro.id_servicio } equals
                                    new { pla_ser.idEspecialidad, pla_ser.id_servicio } into gj_ppp                                
                                  from pla_ser in gj_ppp.DefaultIfEmpty() //This is LEFT JOIN
                                  join per_pla in db.T_PERSONA_PLANSALUD on per.codPersona equals per_pla.codPersona into gj_per_pla
                                  from per_pla in gj_per_pla.DefaultIfEmpty() //This is LEFT JOIN                                 
                                  where per_pla == null ||
                                        ((pla_ser != null && pla_ser.estado == "0") &&
                                        (pro.fecha < per_pla.fecha_inicio && pro.fecha > per_pla.fecha_fin))
                                  group
                                    new { pro, per, per_pla, pla_ser }
                                    by new { pro.idEspecialidad, pro.id_servicio } into gb
                                  select new
                                  {
                                      id_especialidad = gb.Key.idEspecialidad,
                                      id_servicio = gb.Key.id_servicio,
                                      nombre_especialidad = gb.ToList().FirstOrDefault().pro.T_ESPECIALIDAD_SERVICIO.T_ESPECIALIDAD_MEDICA.nomEspecialidad,
                                      nombre_servicio = gb.ToList().FirstOrDefault().pro.T_ESPECIALIDAD_SERVICIO.T_SERVICIO_SALUD.nombre_servicio,
                                      cantidad = gb.Count(),
                                      color = (gb.Count() <= Int32.Parse(config_retirar.valor_maximo) && gb.Count() >= Int32.Parse(config_retirar.valor_minimo)) ? "orange" : ""
                                  };
                                  */


            GenerateServiceModel GSM = new GenerateServiceModel()
            {
                LIST_RETIRO_SERVICIO = ret_serv,
                LIST_ASIGNA_PLAN = asi_plan,
                LIST_PLAN_DE_SALUD = pla_salu,
                T_CONFIGURACION_ASIGNAR = config_asignar,
                T_CONFIGURACION_RETIRAR = config_retirar,
                JSON_LIST_RETIRO_SERVICIO = JArray.FromObject(obj_ret_serv, Util.jsonNoLoop()),
                JSON_LIST_ASIGNA_PLAN = JArray.FromObject(obj_asi_plan, Util.jsonNoLoop()),
                PLANES_SERVICIOS = db.T_PLAN_SERVICIO.ToList()
            };

            //-- END: Full logic

            return View("GenerateServices", GSM);
        }

        [HttpPost]
        public ActionResult GenerarAction()
        {
            
            TempData["request"] = Request;
            string accion = Request["accion"] ?? "";

            if(accion == "retirar")
            {
                List<string> keys_retirar = Request.Form.AllKeys.Select(x => x).Where(x => x.StartsWith("checkbox_retirar_")).ToList();
                foreach (string item in keys_retirar)
                {
                    string[] splits = item.Split('_');
                    int key_plan = Int32.Parse(splits[2]);
                    int key_espe = Int32.Parse(splits[3]);
                    int key_serv = Int32.Parse(splits[4]);

                    List<T_PLAN_SERVICIO> list_ps_m = null; //PLAN SERVICIOS MODIFICAR
                    T_PLAN_SERVICIO ps_n = null; //PLAN SERVICIO NUEVO

                    try
                    {
                        list_ps_m = db.T_PLAN_SERVICIO.Where(x => x.id_plan_salud == key_plan && x.idEspecialidad == key_espe && x.id_servicio == key_serv).ToList();

                        foreach (var ps_m in list_ps_m)
                        {
                            //MODIFY VALUES FOR RECORD
                            ps_m.estado = "0";
                            ps_m.fecha_fin = DateTime.Now;
                            db.Entry(ps_m).State = EntityState.Modified;

                            db.SaveChanges(); //MODIFY RECORD
                        }

                    }
                    catch (Exception e)
                    {

                    }                   

                    if (list_ps_m != null)
                    {
                        DateTime? fecha_fin = db.T_PLAN_DE_SALUD.Find(key_plan).fecha_fin;
                       
                        //SET VALUES FOR NEW RECORD
                        ps_n = new T_PLAN_SERVICIO()
                        {
                            fecha_inicio = DateTime.Now,
                            fecha_fin = fecha_fin,
                            id_plan_salud = key_plan,
                            id_servicio = key_serv,
                            idEspecialidad = key_espe,
                            estado = "1"
                        };

                        try
                        {
                            db.T_PLAN_SERVICIO.Add(ps_n);
                            db.SaveChanges(); //ADD RECORD
                            ViewBag.Message = "El retiro de servicio se a realizado corectamente";
                        }
                        catch (Exception e)
                        {
                            ViewBag.Message = e.Message;
                        }
                    } else
                    {
                        ViewBag.Message = "No existe esta asignacion actualmente";
                    }
                                       
                }
                
            }
            else if ( accion == "asignar")
            {
                List<string> keys_retirar = Request.Form.AllKeys.Select(x => x).Where(x => x.StartsWith("checkbox_asignar_")).ToList();
                foreach (string item in keys_retirar)
                {
                    string[] splits = item.Split('_');
                    int key_espe = Int32.Parse(splits[2]);
                    int key_serv = Int32.Parse(splits[3]);
                    int key_plan = Int32.Parse(Request["select_plan_salud_" + key_espe + "_" + key_serv]);

                    T_PLAN_SERVICIO ps = new T_PLAN_SERVICIO()
                    {
                        estado = "1",
                        fecha_inicio = DateTime.Today,
                        id_plan_salud = key_plan,
                        idEspecialidad = key_espe,
                        id_servicio = key_serv
                    };

                    db.T_PLAN_SERVICIO.Add(ps);
                    db.SaveChanges();

                }
                ViewBag.Message = "La asignación se a realizado correctamente";
            }
            else
            {

            }           

            TempData["Message"] = ViewBag.Message;

            return RedirectToAction("Generar", "GenerarServiciosPlan");
        }

    }
}
