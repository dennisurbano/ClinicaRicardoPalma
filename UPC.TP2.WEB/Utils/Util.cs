using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace UPC.TP2.WEB.Utils
{
    public static class Util
    {
        public static Dictionary<int, string> BitacoraEstados(){
            Dictionary<int, string> estados = new Dictionary<int, string>();
            estados.Add(1, "ABIERTO");
            estados.Add(2, "CERRADO");
            estados.Add(3, "RECHAZADO");
            return estados;
        }

        public static Dictionary<int, string> BitacoraTipos()
        {
            Dictionary<int, string> tipos = new Dictionary<int, string>();
            tipos.Add(1, "APORTE");
            tipos.Add(2, "RECLAMO");
            return tipos;
        }

        public static Dictionary<int, string> EstrategiaComercialDetalleEstado()
        {
            Dictionary<int, string> estado = new Dictionary<int, string>();
            estado.Add(1, "ABIERTO");
            estado.Add(2, "EJECUCION");
            estado.Add(3, "COMPLETO");
            return estado;
        }

        public static Dictionary<int, string> PlanSaludEstado()
        {
            Dictionary<int, string> estado = new Dictionary<int, string>();
            estado.Add(0, "INACTIVO");
            estado.Add(1, "ACTIVO");
            return estado;
        }

        public static JsonSerializerSettings jsonNoLoopSettings()
        {
            return new JsonSerializerSettings {
                PreserveReferencesHandling = PreserveReferencesHandling.Objects,
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore
            };
        }
        public static JsonSerializer jsonNoLoop()
        {
            return new JsonSerializer() {
                PreserveReferencesHandling = PreserveReferencesHandling.Objects,
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore
            };
        }

        public static object getToday()
        {
            return DateTime.Now.ToString("dd/MM/yyyy") ;
        }

        public static string DateTimeToShort(DateTime? dt)
        {
            if (dt == null) return String.Empty;
            DateTime _dt = dt ?? DateTime.Now; //Only for parse
            return dt != null ? _dt.ToString("dd/MM/yyyy") : String.Empty;
        }

        /**
         * 0: false[start date is later] | 1: true[start date is eairler] | -1: null or empty | -2: fail format 
         */
        public static int compareDates(string start_date = "", string end_date = "")
        {
            if (start_date == "" || end_date == "")
            {
                return -1;
            }
            else
            {
                try
                {
                    DateTime dtfi = DateTime.Parse(start_date);
                    DateTime dtff = DateTime.Parse(end_date);

                    long dif = dtff.CompareTo(dtfi);

                    if (dif < 0)
                    {
                        return 0;
                    }
                }
                catch (FormatException)
                {
                    return -2;
                }
            }
            return 1;
        }

        public static string compareDatesMessage(int id_return)
        {
            switch (id_return)
            {
                case 0: return "La fecha inicial es mayor que la final";
                case 1: return "La fecha inicial es menor que la final";
                case -1: return "La o las fechas son nulas";
                case -2: return "La o las fechas no tienen el formato correcto";
            }
            return "La fecha inicial es menor que la final";
        }
    }
}