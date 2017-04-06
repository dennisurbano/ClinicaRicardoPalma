using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UPC.TP2.WEB.Models;
using Newtonsoft.Json.Linq;

namespace UPC.TP2.WEB.ViewModels
{
    public class BitacoraViewModel
    {
        public T_BITACORA_INCIDENCIA BITACORA { get; set; }
        public T_SEGUIMIENTO SEGUIMIENTO { get; set; }
        public T_PLAN_DE_SALUD PLAN_SALUD { get; set; }
        public T_EMPLEADO EMPLEADO { get; set; }
        public IEnumerable<T_BITACORA_INCIDENCIA> BITACORAS { get; set; }
        public IEnumerable<T_SEGUIMIENTO> SEGUIMIENTOS { get; set; }
        public IEnumerable<T_PLAN_DE_SALUD> PLANES_DE_SALUD { get; set; }
        public IEnumerable<T_EMPLEADO> EMPLEADOS { get; set; }
    }
}