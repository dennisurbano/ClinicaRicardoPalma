using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace UPC.TP2.WEB.Areas.Mantenimiento.Models
{
    public class PlanMantenimientoModel
    {
        [Display(Name = "Código Plan")]
        //[StringLength(5, ErrorMessage = "El {0} debe tener una longitud de {1}")]
        //[Required(ErrorMessage = "Debe ingresar el código del personal")]
        public string CodPlan { get; set; }



        [Display(Name = "Código de Responsable")]
        public string CodResponsable { get; set; }

        [Display(Name = "Responsable del control de mantenimiento")]
        [Required(ErrorMessage = "Debe ingresar el nombre del responsable")]
        public string NombreResponsableMnt { get; set; }



        [Display(Name = "Estado de Plan")]
        public SelectList EstadoPlan { get; set; }



        [Display(Name = "Fecha Plan")]
        public string FechaPlan { get; set; }
    }
}