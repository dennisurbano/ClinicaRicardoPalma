var blnSubmodalCGR = false;
var objParentSubmodalCGR;
var dlgSubmodalCGR = ""; // Variable Temporal Nombre Form Submodal CGR
var intTest = 0;

// Variables Result AJAX
var lCargarDatosVarios = null;

function toDatePicker(str) {
    var dia = str.substr(0, 2);
    var mes = str.substr(3, 2) - 1;
    var anho = str.substr(6, 4);
    return new Date(anho, mes, dia);
}

function toStringPicker(fecha, formato) {
    var dia = fecha.getDate();
    var mes = fecha.getMonth() + 1;
    var anho = fecha.getFullYear();
    if (formato == null)
        return strPad(dia, 2, 0) + "/" + strPad(mes, 2, 0) + "/" + anho;
    else
        if (formato == 'AAAAMMDD')
            return strPad(anho + strPad(mes, 2, 0) + strPad(dia, 2, 0));
}

function toAddStringPicker(fecha, addDays) {
    if (isDate(fecha)) {
        var dateFechaAdd = toDatePicker(fecha);
        if (addDays == 0) addDays++;
        dateFechaAdd.setDate(dateFechaAdd.getDate() + parseInt(addDays - 1));
        return toStringPicker(dateFechaAdd, null);
    } else
        return null;
}

function isDate(txtDate) {  //Validates a date input -- http://jquerybyexample.blogspot.com/2011/12/validate-date-    using-jquery.html
    var currVal = txtDate;
    if (currVal == '')
        return false;

    //Declare Regex  
    var rxDatePattern = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
    var dtArray = currVal.match(rxDatePattern); // is format OK?

    if (dtArray == null)
        return false;

    //Checks for dd/mm/yyyy format.
    var dtDay = dtArray[1];
    var dtMonth = dtArray[3];
    var dtYear = dtArray[5];

    if (dtMonth < 1 || dtMonth > 12)
        return false;
    else if (dtDay < 1 || dtDay > 31)
        return false;
    else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
        return false;
    else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap))
            return false;
    }
    if (dtYear < 1900 || dtYear > 2500)
        return false;
    return true;
}


var validarDateTime = {
    Horas: function (str) {
        var num = parseFloat(str);
        return /^\d{1,2}$/.test(str) && num > -1 && num < 24;
    },
    Minutos: function (str) {
        var num = parseFloat(str);
        return /^\d{1,2}$/.test(str) && num > -1 && num < 60;
    },
    HorasMinutos: function (str) {
        var arr = str.split(':');
        return arr.length > 1 && validarDateTime.Horas(arr[0]) && validarDateTime.Minutos(arr[1]);
    }
};

function strPad(i, l, s) {
    var o = i.toString();
    if (!s) { s = '0'; }
    while (o.length < l) {
        o = s + o;
    }
    return o;
};
function parseJsonDate(jsonDate) {
    var value = new Date(parseInt(jsonDate.substr(6)));
    var ret = strPad(value.getDate(), 2) + "/" + strPad(value.getMonth() + 1, 2) + "/" + value.getFullYear();
    return ret;
}

function GetCGRModal() {
    var _intModal = $(".in").length;
    if (_intModal > 0) {
        for (var i = _intModal - 1; i < _intModal > 0; i--) {
            if ($(".in")[i].id != 'dlgBase' && $(".in")[i].id != '') {
                return $(".in")[i].id;
            }
        }
    }
    return null;
}

//Roles
var CGR_Rol_Usuario = new Object();
CGR_Rol_Usuario.Colaborador = 3;
CGR_Rol_Usuario.Analista = 4;
CGR_Rol_Usuario.Gerente = 2;
CGR_Rol_Usuario.Bienestar = 5;
CGR_Rol_Usuario.AsistenteGerencia = 1;
CGR_Rol_Usuario.Supervisor = 6;

//Inicializar
$(function () {
    $("form,input").bind("keypress", function (e) {
        if (e.keyCode == 13) { return false; }
    });

    $.ajaxSetup({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: {}
    });

    $(document).ajaxError(function (e, xhr, settings, exception) {
        //
        PROYECTOCGR.HideProgress();
        //
        var _dlgModalCGR = GetCGRModal();
        //
        var msg = "";
        switch (xhr.status) {
            case 403:
                window.location = "/SARI/Login";
                break;
            case 0: // abort
                if (exception == 'abort')
                    break; // Nothing
                alert('error in: ' + settings.url + ' \\n' + 'error:\\n' + exception);
                break;
            case 500://"Internal Server Error": ERROR PERSONALIZADO
                data = JSON.parse(xhr.responseText);
                if (_dlgModalCGR) {
                    switch (_dlgModalCGR) {
                        case "dialogVCPItem": PROYECTOCGR.HideProgress('dialogVCPItem', 'dialogVacacionesProgramacion'); break;
                        case "dialogVCRItem": PROYECTOCGR.HideProgress('dialogVCRItem', 'dialogVacacionesReprogramacion'); break;
                    }
                    PROYECTOCGR.MostrarPopup("Error de datos", data.Message, "Aceptar", null, null, _dlgModalCGR);
                }
                else {
                    PROYECTOCGR.MostrarPopup("Error de datos", data.Message, "Aceptar");
                }
                $.sticky(data.Message, { autoclose: 5000, position: "top-right", type: "st-error" });
                //window.location = "/SARI/Login"; 
                break;
            default:
                alert('error in: ' + settings.url + ' \\n' + 'error:\\n' + exception);
        }
    });
});

//$(document).ready(function () {
//    PROYECTOCGR.CheckSession();
//});

//Validation
$.fn.validByElement = function (elemento) {
    /// <summary>
    /// Valida un elemento de la vista
    /// </summary>
    /// <param name="elemento" type="String">Nombre del elemento dentro de la vista</param>
    var valido = true;
    var form = this;
    if (!$(form).validate().element("#" + elemento))
        valido = false;
    return valido;
}

$.fn.validByGroup = function (grupo) {
    /// <summary>
    /// Valida una vista en base a un grupo de controles
    /// </summary>
    /// <param name="grupo" type="String">Nombre del grupo de controles dentro de la vista</param>
    var valido = true;
    var form = this;
    $(form).find("[name^='" + grupo + "']").each(function (index) {
        if (!$(form).validate().element("#" + this.name))
            valido = false;
    });
    return valido;
}

$.fn.updateValidation = function () {
    /// <summary>
    /// Reinicia la validacion dentro de la vista
    /// </summary>
    var form = this.closest("form").removeData("validator").removeData("unobtrusiveValidation");
    $.validator.unobtrusive.parse(form);
    return this;
};

$.fn.cleanValidation = function () {
    var form = this;
    var container;

    if (blnSubmodalCGR)
        $(form).updateSubmodal();

    container = $(form).find(".field-validation-error").each(function () {
        $(this).removeClass("field-validation-error").addClass("field-validation-valid");
    });

    container = $(form).find(".input-validation-error").each(function () {
        $(this).removeClass("input-validation-error").addClass("valid");
    });

    container = $(form).find(".validation-summary-errors").each(function () {
        var list = $(this).find("ul");
        list.empty();
        $(this).removeClass("validation-summary-errors").addClass("validation-summary-valid");
    });

    $(form).updateValidation();
}

$.fn.cleanValidationByGroup = function (grupo, summary) {
    /// <summary>
    /// Limpia las etiquetas de validacion mostradas en la vista
    /// </summary>
    /// <param name="grupo" type="String">Nombre del grupo de controles dentro de la vista</param>
    /// <param name="summary" type="String">Nombre del summary asociado a los controles a limpiar</param>
    var form = this;
    if (grupo) {
        $(form).find("[name^='" + grupo + "']").val('');

        $(form).find("[name^='" + grupo + "']").each(function (index) {
            var container = $(form).find("[data-valmsg-for='" + this.name + "']");
            container.removeClass("field-validation-error").addClass("field-validation-valid");
            $("#" + this.name).removeClass("input-validation-error");
            container.empty();
        });
    }

    if (summary) {
        var container = $(form).find("#" + summary);
        var list = container.find("ul");
        list.empty();
        container.removeClass("validation-summary-errors").addClass("validation-summary-valid");
    }

    $(form).updateValidation();
}

$.fn.updateSubmodal = function () {
    /// <summary>
    /// Reinicia el formulario del dialogo SubModal
    /// </summary>
    $(dlgSubmodalCGR).appendTo("#" + this[0].id); // ReAjuste modal porque se mueve abajo
    return this;
};

$.fn.updateValidationSubmodal = function () {
    /// <summary>
    /// Reinicia la validacion dentro de la vista
    /// </summary>
    var form = this;
    $.validator.unobtrusive.parse(form);
    //$(this).appendTo(frmSubmodalCGR); // ReAjuste modal porque se mueve abajo
    return this;
};

$.fn.setmaxlength = function () {
    $('textarea[maxlength]').keyup(function () {
        //get the limit from maxlength attribute  
        var limit = parseInt($(this).attr('maxlength'));
        //get the current text inside the textarea  
        var text = $(this).val();
        //count the number of characters in the text  
        var chars = text.length;
        //check if there are more characters then allowed  
        if (chars > limit) {
            //and if there are use substr to get the text before the limit  
            var new_text = text.substr(0, limit);
            //and change the current text with the new text  
            $(this).val(new_text);
        }
    });
}


function SetSubModalCGR(dialog) {
    objParentSubmodalCGR = $('#' + dialog);
    GoSubModalCGR(true);
}

function OutSubModalCGR(dialog) {
    blnSubmodalCGR = true;
    objParentSubmodalCGR = $('#' + dialog);
    GoSubModalCGR(false);
}

function GoSubModalCGR(option) {
    if (option) {
        objParentSubmodalCGR.addClass('modalstatic');
        objParentSubmodalCGR.removeClass('modal').removeClass('fade');
    }
    else {
        if (blnSubmodalCGR) {
            objParentSubmodalCGR.removeClass('modalstatic');
            objParentSubmodalCGR.addClass('modal');
        }
    }
    blnSubmodalCGR = option;
    if (!blnSubmodalCGR) dlgSubmodalCGR = "";
}

//function WaitSubModalCGR(dialog, wait, parent) {
//    var _modalCGRParent = $("#" + dialog).attr("data-submodal");
//    if (_modalCGRParent) {
//        var _data = _modalCGRParent.split("|");
//        if (parent == true) {
//            $("#" + dialog).css({ 'top': '', 'left': '' });
//        }
//        else {
//            if (wait)
//                $("#" + dialog).css({ 'top': parseInt(_data[3]), 'left': parseInt(_data[4]) });
//            else
//                $("#" + dialog).css({ 'top': parseInt(_data[1]), 'left': parseInt(_data[2]) });
//        }
//    }
//}

//extensiones
$.jgrid.extend({
    addToolBar: function (idToolBar) {
        var idGrid = this.attr('id');
        $("#" + idToolBar).appendTo("#t_" + idGrid);
        $("#t_" + idGrid).css('height', '30px');
    }
});


var SetTimer = {
    timer: null,
    //var timer=null,
    //clearInterval(timer),
    settimer: function (idObj, minutos) {
        timer = setInterval(function () {
            minutos = minutos - (1 / 60);
            if (minutos.toFixed(4) <= 0.00) {
                clearInterval(timer);
                minutos = 0.0;
            }
            $('#' + idObj).html(sformatTime(minutos));
        }, 1000)
    }
    ,
    inicio: function () {
        alert('inicio');
    }
}

function sformatTime(time) {
    var hor = parseInt(time / 60);
    var min = parseInt(time % 60);
    var sec = parseInt((time - parseInt(time)) * 60);
    return (hor > 0 ? PROYECTOCGR.Rpad(hor, 2) : "00") + ":" + (min > 0 ? PROYECTOCGR.Rpad(min, 2) : "00") + ":" + PROYECTOCGR.Rpad(sec, 2);
};


var PROYECTOCGR = {
    //
    CheckSession: function () {
        $.ajax({
            url: PROYECTOCGR.UrlActionMethod("Login", "CheckSession"),
            async: false,
            success: function (result) {
                if (result.Dato == false) {
                    window.location = "/SARI/Login";
                }
            }
        });
    },
    //
    UrlActionMethod: function (Controller, Method) {
        /// <summary>
        /// Devuelve el Url de un WebMethod (con relación a la página donde se ejecuta el script)
        /// </summary>
        /// <param name="Controller" type="String">Nombre del Controller</param>
        /// <param name="Method" type="String">Nombre del Method</param>
        if (Controller) {
            return Controller + "/" + Method;
        } else {
            return Method;
        }
    },
    WaitWindow: function (Mensaje) {
        /// <summary>
        /// Muestra una ventana de informacion
        /// </summary>
        $.sticky(Mensaje, { autoclose: 8000, position: "top-right", type: "st-info" });
    },
    //    
    WaitWindowError: function (Mensaje) {
        /// <summary>
        /// Muestra una ventana de informacion
        /// </summary>
        $.sticky(Mensaje, { autoclose: 8000, position: "top-right", type: "st-error" });
    },
    //        
    WaitWindowExito: function (Mensaje) {
        /// <summary>
        /// Muestra una ventana de informacion
        /// </summary>
        $.sticky(Mensaje, { autoclose: 8000, position: "top-right", type: "st-success" });
    },
    //
    MostrarPopup: function (Titulo, Mensaje, Opcion, CallbackAccept, CallbackCancel, strModal, strAncho) {
        /// <summary>
        /// Muestra una ventana de dialogo
        /// </summary>
        /// <param name="Titulo" type="String">Titulo de la ventana de dialogo</param>
        /// <param name="Mensaje" type="String">Mensaje a mostrar</param>
        /// <param name="Opcion" type="String">(Opcional) indica el tipo de ventana a mostrar (Default = Aceptar)</param>
        /// <param name="CallbackAccept" type="function">(Opcional) Función a ejecutar luego de pulsar [Aceptar] ó [Si]</param>
        /// <param name="CallbackCancel" type="function">(Opcional) Función a ejecutar luego de pulsar [Cancelar], [No], ó al salir de la ventana</param>

        if (strModal) SetSubModalCGR(strModal); // Dialog permite SubModal

        var executeCallBack = false;
        //
        if (!Opcion) { Opcion = 'Aceptar'; }
        //
        var dlg = '';
        var dlgAncho = '';
        // header
        if (strAncho)
            dlgAncho = 'style = "width:' + strAncho + 'px; margin-left:' + -(strAncho) / 2 + 'px;"';

        //dlg = dlg + '<div id="dlgBase" class="modal hide fade" tabindex="-1" role="dialog" ' + dlgAncho + ' >';
        dlg = dlg + '<div id="dlgBase" class="modal hide" tabindex="-1" role="dialog" ' + dlgAncho + ' >';
        dlg = dlg + '<div class="modal-header">';
        //dlg = dlg + '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
        dlg = dlg + '<h3>' + Titulo + '</h3>';
        dlg = dlg + '</div>';
        // body
        dlg = dlg + '<div class="modal-body"><p>' + Mensaje + '</p></div>';
        // footer
        dlg = dlg + '<div class="modal-footer">'
        if (Opcion == 'Aceptar') {
            dlg = dlg + '<a id="btnCgrPopup_Aceptar" class="btn btn-primary">Aceptar</a>';
        }
        if (Opcion == 'SiNo') {
            dlg = dlg + '<a id="btnCgrPopup_Si" class="btn btn-primary">Si</a>';
            dlg = dlg + '<a id="btnCgrPopup_No" href="#" class="btn">No</a>'
        }
        if (Opcion == 'AceptarCancelar') {
            dlg = dlg + '<a id="btnCgrPopup_Aceptar" class="btn btn-primary">Aceptar</a>';
            dlg = dlg + '<a id="btnCgrPopup_Cancelar" href="#" class="btn">Cancelar</a>'
        }
        dlg = dlg + '</div>';

        $("form").append(dlg);

        var dialogo = $("#dlgBase");

        /*
            aceptar
        */
        $('#btnCgrPopup_Aceptar, #btnCgrPopup_Si').click(function () {
            if (typeof CallbackAccept == 'function') {
                executeCallBack = true;
                dialogo.modal('hide');
                CallbackAccept.call(dialogo);
            } else {
                dialogo.modal('hide');
            }
            return true;
        });
        /*
            cancelar
        */
        $("#btnCgrPopup_Cancelar, #btnCgrPopup_No").click(function () {
            if (typeof CallbackCancel == 'function') {
                executeCallBack = true;
                dialogo.modal("hide");
                CallbackCancel.call(dialogo);
            } else {
                dialogo.modal("hide");
            }
            return true;
        });
        // cerrar ventana
        dialogo.on('hide', function () {
            switch (Opcion) {
                case 'Aceptar':
                    if (typeof CallbackAccept == 'function') {
                        if (!executeCallBack) { CallbackAccept.call(dialogo); }
                    }
                    break;
                case 'SiNo', 'AceptarCancelar':
                    if (typeof CallbackCancel == 'function') {
                        if (!executeCallBack) { CallbackCancel.call(dialogo); }
                    }
                    break;
                default:
                    break;
            }
            dialogo.remove();
            if (strModal) OutSubModalCGR(strModal); // Reactivar SubModal
        });
        /*
            muestra dialogo
        */

        if ($.browser.msie) {
            $('#dlgBase').removeClass('fade');
        }

        dialogo.modal({
            keyboard: false, backdrop: 'static'
        });

    },        
    //
        MostrarPopupRechaza: function (Titulo, Mensaje, Opcion, CallbackAccept, CallbackCancel, strModal, strAncho) {
            /// <summary>
            /// Muestra una ventana de dialogo
            /// </summary>
            /// <param name="Titulo" type="String">Titulo de la ventana de dialogo</param>
            /// <param name="Mensaje" type="String">Mensaje a mostrar</param>
            /// <param name="Opcion" type="String">(Opcional) indica el tipo de ventana a mostrar (Default = Aceptar)</param>
            /// <param name="CallbackAccept" type="function">(Opcional) Función a ejecutar luego de pulsar [Aceptar] ó [Si]</param>
            /// <param name="CallbackCancel" type="function">(Opcional) Función a ejecutar luego de pulsar [Cancelar], [No], ó al salir de la ventana</param>

            if (strModal) SetSubModalCGR(strModal); // Dialog permite SubModal

            var executeCallBack = false;
            //
            if (!Opcion) { Opcion = 'Aceptar'; }
            //
            var dlg = '';
            var dlgAncho = '';
            // header
            if (strAncho)
                dlgAncho = 'style = "width:' + strAncho + 'px; margin-left:' + -(strAncho) / 2 + 'px;"';

            //dlg = dlg + '<div id="dlgBase" class="modal hide fade" tabindex="-1" role="dialog" ' + dlgAncho + ' >';
            dlg = dlg + '<div id="dlgBase" class="modal hide" tabindex="-1" role="dialog" ' + dlgAncho + ' >';
            dlg = dlg + '<div class="modal-header">';            
            dlg = dlg + '<h3>' + Titulo + '</h3>';
            dlg = dlg + '</div>';
            // body
            dlg = dlg + '<div class="modal-body"><p>' + Mensaje + '</p><p><textarea rows="4" cols="100" id="txtareaObservacion"></textarea></p></div>';
            // footer
            dlg = dlg + '<div class="modal-footer">'
            if (Opcion == 'Aceptar') {
                dlg = dlg + '<a id="btnCgrPopup_Aceptar" class="btn btn-primary">Aceptar</a>';
            }
            if (Opcion == 'SiNo') {
                dlg = dlg + '<a id="btnCgrPopup_Si" class="btn btn-primary">Si</a>';
                dlg = dlg + '<a id="btnCgrPopup_No" href="#" class="btn">No</a>'
            }
            if (Opcion == 'AceptarCancelar') {
                dlg = dlg + '<a id="btnCgrPopup_Aceptar" class="btn btn-primary">Aceptar</a>';
                dlg = dlg + '<a id="btnCgrPopup_Cancelar" href="#" class="btn">Cancelar</a>'
            }
            dlg = dlg + '</div>';

            $("form").append(dlg);

            var dialogo = $("#dlgBase");

            /*
                aceptar
            */
            $('#btnCgrPopup_Aceptar, #btnCgrPopup_Si').click(function () {
                if (typeof CallbackAccept == 'function') {
                    executeCallBack = true;
                    dialogo.modal('hide');
                    CallbackAccept.call(dialogo);
                } else {
                    dialogo.modal('hide');
                }
                return true;
            });
            /*
                cancelar
            */
            $("#btnCgrPopup_Cancelar, #btnCgrPopup_No").click(function () {
                if (typeof CallbackCancel == 'function') {
                    executeCallBack = true;
                    dialogo.modal("hide");
                    CallbackCancel.call(dialogo);
                } else {
                    dialogo.modal("hide");
                }
                return true;
            });
            // cerrar ventana
            dialogo.on('hide', function () {
                switch (Opcion) {
                    case 'Aceptar':
                        if (typeof CallbackAccept == 'function') {
                            if (!executeCallBack) { CallbackAccept.call(dialogo); }
                        }
                        break;
                    case 'SiNo', 'AceptarCancelar':
                        if (typeof CallbackCancel == 'function') {
                            if (!executeCallBack) { CallbackCancel.call(dialogo); }
                        }
                        break;
                    default:
                        break;
                }
                dialogo.remove();
                if (strModal) OutSubModalCGR(strModal); // Reactivar SubModal
            });
            /*
                muestra dialogo
            */

            if ($.browser.msie) {
                $('#dlgBase').removeClass('fade');
            }

            dialogo.modal({
                keyboard: false, backdrop: 'static'
            });

        },
    //
    CargarGridLoad: function (strActionMethod, strGridId, objJsonParams, callbackOK, strModal, NOShowProgress) {

        var _strModal = strModal;
        if (!NOShowProgress) {
            if (strModal)
                PROYECTOCGR.ShowProgressSubModal(strModal);
            else
                PROYECTOCGR.ShowProgress();
        }
        $.ajax({
            url: strActionMethod,
            data: JSON.stringify(objJsonParams),
            complete: function (jsondata, stat) {

                //intTest++;
                //if (intTest<=6)
                if (!NOShowProgress)
                    PROYECTOCGR.HideProgress();

                if (stat == "success") {
                    if (jsondata.responseText.split("ErrorJSON@").length > 1) {
                        var MsgErrorJSon = jsondata.responseText.split("ErrorJSON@")[1];
                        MsgErrorJSon = MsgErrorJSon.substr(0, MsgErrorJSon.length - 1);
                        PROYECTOCGR.MostrarPopup("Error", MsgErrorJSon, "Aceptar", null, null, _strModal);
                    }
                    else {
                        $("#" + strGridId)[0].addJSONData(JSON.parse(jsondata.responseText));
                        if (typeof callbackOK == 'function') { callbackOK.call(this); }
                    }
                }
                //else
                //    PROYECTOCGR.MostrarPopup("Error", "Error Cargar grilla.", "Aceptar");
            }
        });

    },
    //
    CargarGrid: function (WebMethod, IdGrid, JsonParams, CallbackOk) {
        /// <summary>
        /// Carga control Grid mediante método Ajax
        /// </summary>
        /// <param name="WebMethod" type="String">Nombre del WebMethod utilizado para cargar el Grid</param>
        /// <param name="IdGrid" type="String">Id del tag <Table> que se formatea como un Grid</param>
        /// <param name="JsonParams" type="Json">(Opcional) Parametros utilizados por el [WebMethod], serializados en notación Json</param>
        /// <param name="CallbackOk" type="function">(Opcional) Función a ejecutar después de realizar la carga del Grid</param>

        PROYECTOCGR.ShowProgress();

        $("#" + IdGrid).jqGrid('setGridParam', {
            datatype: function () {
                $.ajax({
                    url: PROYECTOCGR.UrlPageMethod(WebMethod),
                    data: JSON.stringify(JsonParams),
                    complete: function (jsondata, stat) {

                        PROYECTOCGR.HideProgress();

                        if (stat == "success") {
                            $("#" + IdGrid)[0].addJSONData(JSON.parse(jsondata.responseText).d);
                            if (typeof CallbackOk == 'function') { CallbackOk.call(this); }
                        }
                        //else
                        //    PROYECTOCGR.MostrarPopup("Error", "Error al cargar el Grid.", "Aceptar");
                    }
                });
            }
        }).trigger('reloadGrid');

    },
    CargarCombo: function (strActionMethod, IdCombo, JsonParams, PrimerItem, CallbackOk, ValorPredeterminado) {
        $.ajax({
            url: strActionMethod,
            data: JSON.stringify(JsonParams),
            success: function (result) {                
                if (result != null) {
                    $("#" + IdCombo).html("");
                    if (PrimerItem != null) {
                        $("#" + IdCombo).append($("<option></option>")
                                            .attr("value", "").text(PrimerItem));
                    }
                    $.each(result, function () {
                        $("#" + IdCombo).append($("<option></option>")
                            .attr("value", this.Id).text(this.Valor));
                    });
                    if (ValorPredeterminado) {
                        $("#" + IdCombo).val(ValorPredeterminado);
                    }
                    if (typeof CallbackOk == 'function') { CallbackOk.call(this); }
                }
            }
        });
    },    
    ToUpperCase: function (IdControl) {
        /// <summary>
        /// Convierte a Mayúsculas el texto ingresado en un control, y restringe a caracteres del alfabeto español
        /// </summary>
        /// <param name="IdControl" type="String">Id del control a aplicar</param>
        var objControl = $("#" + IdControl);
        objControl.addClass('uppercase');
        var blnPermitidoCGR = false;

        // Add event Keydown due to support Firefox
        objControl.keydown(function (e) {
            blnPermitidoCGR = false;
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;

            if (iKey == 9 || iKey == 37 || iKey == 39 || iKey == 46) {//Tab, Left, Right, Supr
                blnPermitidoCGR = true;
            }
        });

        objControl.keypress(function (e) {
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            //var modifiers = (e.altKey || e.ctrlKey || e.shiftKey);
            var permitidos = "0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚÄËÏÖÜ%&-.,;'"

            if (iKey == 8 || iKey == 32 || iKey == 16 || iKey == 37 || iKey == 39 || iKey == 45 || iKey == 46 || blnPermitidoCGR) {
                return true;
            }

            // Check Permitidos
            for (i = 0; i < permitidos.length; i++) {
                if (String.fromCharCode(iKey).toUpperCase() == permitidos.substr(i, 1)) return true;
            }
            return false;
        });

        objControl.blur(function (e) {
            blnPermitidoCGR = false;
            objControl.val(objControl.val().toUpperCase());
        });
    },
    //
    ToSoloAlfanumericos: function (IdControl) {
        /// <summary>
        /// Convierte a Mayúsculas el texto ingresado en un control, y restringe a caracteres del alfabeto español
        /// </summary>
        /// <param name="IdControl" type="String">Id del control a aplicar</param>
        var objControl = $("#" + IdControl);
        var blnAlfanumericoCGR = false;
        var permitidos = "0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚÄËÏÖÜ-.,%()" + '"';
        // Add event Keydown due to support Firefox
        objControl.keydown(function (e) {
            blnAlfanumericoCGR = false;
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;

            if (iKey == 9 || iKey == 37 || iKey == 39 || iKey == 46) {//Tab, Left, Right, Supr
                blnAlfanumericoCGR = true;
            }
        });

        objControl.keypress(function (e) {
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            //var modifiers = (e.altKey || e.ctrlKey || e.shiftKey);
            //if (iKey == 8 || iKey == 32 || iKey == 16 || iKey == 37 || iKey == 39 || iKey == 45 || iKey == 46 || blnAlfanumericoCGR) {
            if (iKey == 8 || iKey == 32 || iKey == 16 || iKey == 37 || blnAlfanumericoCGR) {
                return true;
            }

            // Check Permitidos
            for (i = 0; i < permitidos.length; i++) {
                if (String.fromCharCode(iKey).toUpperCase() == permitidos.substr(i, 1)) return true;
            }
            return false;
        });

        objControl.blur(function (e) {
            blnAlfanumericoCGR = false;
        });
    },
    //

    ToValoresEstablecidos: function (IdControl, ValoresTabla, EsMayusculas, ValAgregados) {
        /// <summary>
        /// Convierte a Mayúsculas el texto ingresado en un control, y restringe a caracteres del alfabeto español
        /// </summary>
        /// <param name="IdControl" type="String">Id del control a aplicar</param>
        var objControl = $("#" + IdControl);
        if (EsMayusculas == "S")
            objControl.addClass('uppercase');

        var blnAlfanumericoCGR = false;
        var permitidos = "";
        if (ValoresTabla == 0) {
            permitidos = ValAgregados;
        }
        else if (ValoresTabla == 1) {
            valpermitidos = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            permitidos = (ValAgregados == null) ? valpermitidos : valpermitidos + ValAgregados;
        }
        else if (ValoresTabla == 2) {
            valpermitidos = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/.";
            permitidos = (ValAgregados == null) ? valpermitidos : valpermitidos + ValAgregados;
        }
        else
            permitidos = "0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚÄËÏÖÜ%&-.,;:'_@|+%/()°" + '"';

        // Add event Keydown due to support Firefox
        objControl.keydown(function (e) {
            blnAlfanumericoCGR = false;
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;

            if (iKey == 9 || iKey == 37 || iKey == 39 || iKey == 46) {//Tab, Left, Right, Supr
                blnAlfanumericoCGR = true;
            }
        });

        objControl.keypress(function (e) {
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            //var modifiers = (e.altKey || e.ctrlKey || e.shiftKey);
            //if (iKey == 8 || iKey == 32 || iKey == 16 || iKey == 37 || iKey == 39 || iKey == 45 || iKey == 46 || blnAlfanumericoCGR) {
            if (iKey == 8 || iKey == 32 || iKey == 16 || iKey == 37 || blnAlfanumericoCGR) {
                return true;
            }

            // Check Permitidos
            for (i = 0; i < permitidos.length; i++) {
                if (String.fromCharCode(iKey).toUpperCase() == permitidos.substr(i, 1)) return true;
            }
            return false;
        });

        objControl.blur(function (e) {
            blnAlfanumericoCGR = false;
        });
    },
    //
    ToNumber: function (IdControl) {
        /// <summary>
        /// Convierte a Mayúsculas el texto ingresado en un control, y restringe a caracteres del alfabeto español
        /// </summary>
        /// <param name="IdControl" type="String">Id del control a aplicar</param>
        var objControl = $("#" + IdControl);
        var blnPermitidoCGR = false;

        // Add event Keydown due to support Firefox
        objControl.keydown(function (e) {
            blnPermitidoCGR = false;
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            if (iKey == 9 || iKey == 37 || iKey == 39 || iKey == 46) {//Tab, Left, Right, Supr
                blnPermitidoCGR = true;
            }
        });

        objControl.keypress(function (e) {
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            //var modifiers = (e.altKey || e.ctrlKey || e.shiftKey);
            var permitidos = "0123456789.,'"

            if (iKey == 8 || iKey == 32 || iKey == 16 || iKey == 37 || iKey == 39 || iKey == 45 || iKey == 46 || blnPermitidoCGR) {
                return true;
            }

            // Check Permitidos
            for (i = 0; i < permitidos.length; i++) {
                if (String.fromCharCode(iKey).toUpperCase() == permitidos.substr(i, 1)) return true;
            }
            return false;
        });

    },
    ToSoloNumber: function (IdControl) {
        /// <summary>
        /// Convierte a Mayúsculas el texto ingresado en un control, y restringe a caracteres del alfabeto español
        /// </summary>
        /// <param name="IdControl" type="String">Id del control a aplicar</param>
        var objControl = $("#" + IdControl);
        var blnPermitidoCGR = false;

        // Add event Keydown due to support Firefox
        objControl.keydown(function (e) {
            blnPermitidoCGR = false;
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            if (iKey == 9 || iKey == 37 || iKey == 39 || iKey == 46) {//Tab, Left, Right, Supr
                blnPermitidoCGR = true;
            }
        });

        objControl.keypress(function (e) {
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            var permitidos = "0123456789"

            if (iKey == 8 || iKey == 32 || iKey == 16 || blnPermitidoCGR) {
                return true;
            }

            // Check Permitidos
            for (i = 0; i < permitidos.length; i++) {
                if (String.fromCharCode(iKey).toUpperCase() == permitidos.substr(i, 1)) return true;
            }
            return false;
        });

    },
    //
    CheckLength: function (IdControl, Mensaje, Min, Max, OcultarMensaje) {
        /// <summary>
        /// Valida la longitud de un control
        /// </summary>
        /// <param name="IdControl" type="String">Id del control a validar</param>
        /// <param name="Mensaje" type="String">Mensaje mostrado en caso se validación sea incorrecta</param>
        /// <param name="Min" type="Number">Longitud mínima requerida para el control</param>
        /// <param name="Max" type="Number">Longitud máxima requerida para el control</param>
        /// <param name="OcultarMensaje" type="Boolean">(Opcional) Oculta mensaje de validación</param>

        var valControl;
        var objControl = $("#" + IdControl);
        if (!objControl)
            return false;

        valControl = objControl.val().length;

        if (valControl > Max || valControl < Min) {
            objControl.addClass("ui-state-error");
            if (!OcultarMensaje) {
                PROYECTOCGR.MostrarPopup('Error', Mensaje, 'Aceptar', function () { objControl.focus(); });
            }
            return false;
        } else {
            objControl.removeClass("ui-state-error");
            return true;
        }
    },
    //
    CheckVal: function (IdControl, Mensaje, Min, Max, OcultarMensaje) {
        /// <summary>
        /// Valida el rango de valores permitidos en un control
        /// </summary>
        /// <param name="IdControl" type="String">Id del control a validar</param>
        /// <param name="Mensaje" type="String">Mensaje mostrado en caso se validación sea incorrecta</param>
        /// <param name="Min" type="Number">Valor mínimo permitido para el control</param>
        /// <param name="Max" type="Number">Valor máximo permitido para el control</param>
        /// <param name="OcultarMensaje" type="Boolean">(Opcional) Oculta mensaje de validación</param>

        var valControl;
        var objControl = $("#" + IdControl);
        if (!objControl)
            return false;

        valControl = objControl.val();

        if (valControl > Max || valControl < Min) {
            objControl.addClass("ui-state-error");
            if (!OcultarMensaje) {
                PROYECTOCGR.MostrarPopup('Error', Mensaje, 'Aceptar', function () { objControl.focus(); });
            }
            return false;
        } else {
            objControl.removeClass("ui-state-error");
            return true;
        }
    },
    //
    ShowProgress: function () {
        //$("#CGR_PleaseWaitDialog").css({ 'top': 500, 'left': 730 });
        //$("#CGR_PleaseWaitDialog").css({
        //    'margin-top': function () {
        //        return -($(this).height() / 2);
        //    },
        //    'margin-left': function () {
        //        return -($(this).width() / 2);
        //    }
        //});
        $("#CGR_PleaseWaitDialog").modal("show");
    },
    //
    ShowProgressSubModal: function (modal, modalparent) {
        if (modalparent) {
            //        WaitSubModalCGR(modal, true);
            //        WaitSubModalCGR(modalparent, true);
            $("#" + modal).css({ 'overflow': 'auto' });
            $("#" + modalparent).css({ 'overflow': 'auto' });
        }
        SetSubModalCGR(modal); // Dialog permite SubModal
        if (modalparent) {
            $("#" + modal).css({ 'overflow': 'auto' });
            $("#" + modalparent).css({ 'overflow': 'auto' });
        }
        $("#CGR_PleaseWaitDialog").css({ 'top': 500, 'left': 730 });
        $("#CGR_PleaseWaitDialog").submodal(modal, "show");
        //$("#CGR_PleaseWaitDialog").modal("show");
    },
    //
    HideProgress: function (modal, modalparent) {
        //if (modal) {
        //    WaitSubModalCGR(modal, false);
        //    WaitSubModalCGR(modalparent, false, true);
        //}
        $("#CGR_PleaseWaitDialog").modal("hide", true);
    },
    //
    GetToken: function (IdToken) {
        /// <summary>
        /// Obtiene Token de Pagina
        /// </summary>
        /// <param name="IdToken" type="String">(Opcional) Id tag token</param>
        if (IdToken) {
            return $('input[name=' + IdToken + ']').val();
        } else {
            return $('input[name=__RequestVerificationToken]').val();
        }
    }
    ,
    SetFormatPicker: function (IdControl, IddpControl, CallbackOk) {
        $('#' + IdControl).datepicker({
            format: 'dd/mm/yyyy', autoclose: true
        }).on("focusout", function (ev) {
            if (ev.currentTarget.value == '__/__/____' /* || !isDate($('#' + IdControl).val())*/) { $('#' + IdControl).val(''); }
        })
        .bind("changeDate", function (e) {
            if (e.viewMode == 'days') {
                setTimeout(function () {
                    //if (!isDate($('#' + IdControl).val())) $('#' + IdControl).val('');
                    $('#' + IdControl).datepicker("hide");
                }, 0);
                if (typeof CallbackOk == 'function') { CallbackOk.call(this); }
            }
        }).on("click focus", function () {
            setTimeout(function () {
                $('#' + IdControl).datepicker("hide");
            }, 0);
        })

        $('#' + IddpControl).click(function () {
            //if ($('#' + IdControl).val().length > 0) {
            //    var varFecha = toDatePicker($('#' + IdControl).val());
            //    $('#' + IdControl).datepicker('setValue', varFecha);
            //}
            //else {
            //    $('#' + IdControl).data({ date: new Date() });
            //    $('#' + IdControl).datepicker('update');
            //}
            $('#' + IdControl).datepicker('show');
        });
    },
    ToDatePicker: function (str) {
        return toDatePicker(str)
    },
    Rpad: function (number, length) {
        var str = '' + number;
        while (str.length < length) { str = '0' + str; }
        return str;
    },
    //
    CargarDatosVarios: function (strActionMethod, data, CallbackOk) {
        $.ajax({
            url: strActionMethod,
            data: JSON.stringify(data),
            success: function (result) {
                if (result.dato == false && result.Msg) {
                    PROYECTOCGR.MostrarPopup("Error", result.Msg, "Aceptar", null, null, null);
                }
                else {
                    if (typeof CallbackOk == 'function') { CallbackOk(result); /*CallbackOk.apply(this);*/ }
                }
            }
        });
    },
    //
    GetJQGridSeleccionado: function (container) {
        var _rowsData = [];
        jQuery.each($(container).getDataIDs(), function () {
            var id = $(container).getGridParam('selarrrow');
            var i = 0;
            while (i < id.length) {
                _rowsData[i] = $(container).getRowData(id[i]);
                i++;
            }
        });
        return _rowsData;
    }
};

var Reporte = {
    submitReportRequest: function (pParams, piframe, pDialog, pWidth, pHeight) {
        url = PROYECTOCGR.UrlActionMethod("Comun", "RunReport");
        $.ajax({
            url: url,
            type: "POST",
            dataType: 'json',
            data: JSON.stringify({ 'pObj': pParams }),
            success: function (data, textStatus, jqXhr) {
                pDialog.attr({
                    height: pHeight,
                    width: pWidth
                });

                piframe.attr({
                    height: pHeight,
                    width: parseInt(pWidth) - 250,
                    //width: (screen.availWidth - 750).toString(),
                    src: data
                });

                pDialog.modal({
                    keyboard: false, backdrop: 'static'
                });
                return false;
            } //,error: app.handleAjaxError
        });
        $("#ParametersRowReportViewer1").attr("Style", "Display:none");
        $("#ReportViewer1_ToggleParam").attr("Style", "Display:none");
        return false;
    }
}