using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UPC.TP2.WEB.Models;

namespace UPC.TP2.WEB.ViewModels
{
    public class InformePlanSaludViewModel
    {
        public T_PLAN_DE_SALUD PLAN_DE_SALUD { get; set; }
        public T_PERSONA_PLANSALUD PERSONA_PLANSALUD { get; set; }
        public IEnumerable<T_PLAN_DE_SALUD> PLANES_DE_SALUD { get; set; }
        public IEnumerable<T_PERSONA_PLANSALUD> PERSONAS_PLANESSALUD { get; set; }
        public JArray JSON_INFORME_INGRESO_PLAN_SALUD { get; set; }
        public JArray JSON_INFORME_PERSONA_PLAN_SALUD_PERIODO { get; set; }
        public JArray JSON_INFORME_CITAS_PLAN_SALUD { get; set; }
    }
}