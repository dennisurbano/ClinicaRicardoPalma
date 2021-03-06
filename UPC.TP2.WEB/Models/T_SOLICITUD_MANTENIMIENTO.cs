//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace UPC.TP2.WEB.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class T_SOLICITUD_MANTENIMIENTO
    {
        public T_SOLICITUD_MANTENIMIENTO()
        {
            this.T_MANTENIMIENTO_EQUIPO = new HashSet<T_MANTENIMIENTO_EQUIPO>();
        }
    
        public int idSolicitud { get; set; }
        public Nullable<System.DateTime> fecSolicitud { get; set; }
        public string estSolicitud { get; set; }
        public Nullable<System.DateTime> fecAtencion { get; set; }
        public string dscObservacion { get; set; }
        public Nullable<int> idTecnicoMant { get; set; }
        public Nullable<int> idEmpleado { get; set; }
        public Nullable<int> idEquipoMedico { get; set; }
    
        public virtual T_EMPLEADO T_EMPLEADO { get; set; }
        public virtual T_EQUIPO_MEDICO T_EQUIPO_MEDICO { get; set; }
        public virtual ICollection<T_MANTENIMIENTO_EQUIPO> T_MANTENIMIENTO_EQUIPO { get; set; }
        public virtual T_TECNICO_MANTENIMIENTO T_TECNICO_MANTENIMIENTO { get; set; }
    }
}
