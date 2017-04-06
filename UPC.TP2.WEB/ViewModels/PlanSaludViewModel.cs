using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UPC.TP2.WEB.Models;

namespace UPC.TP2.WEB.ViewModels
{
    public class PlanSaludViewModel
    {
        public IEnumerable<T_PLAN_DE_SALUD> PLANES_DE_SALUD { get; set; }
        public T_PLAN_DE_SALUD PLAN_DE_SALUD { get; set; }
    }
}