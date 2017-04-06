using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UPC.TP2.WEB.Models;

namespace UPC.TP2.WEB.ViewModels
{
    public class EstrategiaComercialViewModel
    {
        public TV_ESTRATEGIA_COMERCIAL V_ESTRATEGIA_COMERCIAL { get; set; }
        public T_ESTRATEGIA_COMERCIAL ESTRATEGIA_COMERCIAL { get; set; }
        public T_ESTRATEGIA_COMERCIAL_DETALLE ESTRATEGIA_COMERCIAL_DETALLE { get; set; }
        public T_PLAN_DE_SALUD PLAN_SALUD { get; set; }
        public T_EMPLEADO EMPLEADO { get; set; }
        public IEnumerable<TV_ESTRATEGIA_COMERCIAL> ESTRATEGIAS_COMERCIALES { get; set; }
        public IEnumerable<T_ESTRATEGIA_COMERCIAL_DETALLE> ESTRATEGIA_COMERCIAL_DETALLES { get; set; }
        public IEnumerable<T_PLAN_DE_SALUD> PLANES_DE_SALUD { get; set; }
    }

    public class TV_ESTRATEGIA_COMERCIAL : T_ESTRATEGIA_COMERCIAL
    {
        public DateTime? fecha_fin { get; set; }
        public decimal? real { get; set; }
        public decimal? desviacion { get; set; }
    }
}