/// <reference path="ProyectoCGR.js" />

var RegSeleccionado = null;

function setRecordCgrBuscarEntidad() {
    /// <summary>
    /// Establece el registro seleccionado en la búsqueda para la devolución
    /// </summary>
    if ($('#tblCgrBuscarEntidad').getGridParam('selrow') == null) {
        RegSeleccionado = null;
        return false;
    }
    var id = $('#tblCgrBuscarEntidad').getGridParam('selrow');
    RegSeleccionado = $("#tblCgrBuscarEntidad").getRowData(id);
}

function setRecordCgrBuscarPersonal() {
    /// <summary>
    /// Establece el registro seleccionado en la búsqueda para la devolución
    /// </summary>
    if ($('#gridDataCgrBuscarPersonal').getGridParam('selrow') == null) {
        RegSeleccionado = null;
        return false;
    }
    var id = $('#gridDataCgrBuscarPersonal').getGridParam('selrow');
    RegSeleccionado = $("#gridDataCgrBuscarPersonal").getRowData(id);
}

function getWindowCgrBuscarEntidad(Titulo) {
    /// <summary>
    /// Retorna el marcado de una ventana de dialogo
    /// </summary>
    /// <param name="Titulo" type="String">Titulo de la ventana de dialogo</param>
    var dlg = '';

    // header
    //dlg = dlg + '<div id="dlgBase" class="modal hide fade" tabindex="-1" role="dialog">';
    dlg = dlg + '<div id="dlgBase" class="modal hide" tabindex="-1" role="dialog">';
    dlg = dlg + '<div class="modal-header">';
    //dlg = dlg + '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
    dlg = dlg + '<h3>' + Titulo + '</h3>';
    dlg = dlg + '</div>';
    // body
    dlg = dlg + '<div class="modal-body" style="height:350px;"><table id="tblCgrBuscarEntidad"></table><div id="pageCgrBuscarEntidad"></div></div>';
    // footer
    dlg = dlg + '<div class="modal-footer">'
    dlg = dlg + '<a id="btnCgrBuscar_Aceptar" class="btn btn-primary">Aceptar</a>';
    dlg = dlg + '<a id="btnCgrBuscar_Cancelar" href="#" class="btn">Cancelar</a>'
    dlg = dlg + '</div>';

    return dlg;
}

var BUSQUEDACGR = {
    //
    GetData: function () {
        /// <summary>
        /// Retorna un array con la data del registro seleccionado en la búsqueda
        /// </summary>
        return RegSeleccionado;
    },
    // 
    BuscarPersonal: function (container, CallbackAccept, CallbackCancel, codUO) {
        /// <summary>
        /// Muestra una ventana de dialogo para realizar la búsqueda de informes
        /// </summary>
        /// <param name="CallbackAccept" type="function">(Opcional) Función a ejecutar luego de pulsar [Aceptar]</param>
        /// <param name="CallbackCancel" type="function">(Opcional) Función a ejecutar luego de pulsar [Cancelar] ó al salir de la ventana</param>
        /// <param name="codUO" type="string">(Opcional) Codigo de unidad organica </param>
        var executeCallBack = false;

        $("#divBaseCgrBuscarPersonal").remove();
        $(container).append("<div id='divBaseCgrBuscarPersonal'></div>")
        $("#divBaseCgrBuscarPersonal").load(PROYECTOCGR.UrlActionMethod("/SARI/Comun", "BusquedaPersonal"), function (response, status) {
            var dialogo = $("#dialogConsultaPersonal");
            /*
                configura jqgrid
            */
            $("#gridDataCgrBuscarPersonal").jqGrid({
                datatype: function () {

                    var parFiltroB = new Object();
                    parFiltroB.PARAMETRO1 = $('#txtCgrBuscarNomPersonal').val();
                    parFiltroB.PARAMETRO2 = (codUO == null ? '' : codUO);
                    parFiltroB.PARAMETRO3 = '';
                    parFiltroB.Page_size = $('#gridDataCgrBuscarPersonal').getGridParam("rowNum");
                    parFiltroB.Page_number = $('#gridDataCgrBuscarPersonal').getGridParam("page");
                    parFiltroB.Sort_Column = $('#gridDataCgrBuscarPersonal').getGridParam("sortname");
                    parFiltroB.Sort_Order = $('#gridDataCgrBuscarPersonal').getGridParam("sortorder");

                    PROYECTOCGR.CargarGridLoad(PROYECTOCGR.UrlActionMethod("/AsistenciaRH/Comun", "GetPersonal"), "gridDataCgrBuscarPersonal", { 'dato': parFiltroB }, null, "dialogConsultaPersonal");
                },
                colNames: ['Código', 'Nombre del Colaborador', 'Unidad Orgánica', 'Cod Unidad Organica', 'Fecha Ingreso'],
                colModel: [
                              { name: 'codigo', index: 'codigo', hidden: false, align: "center", width: 50, sortable: false }
                            , { name: 'NomCompleto', index: 'NomCompleto', hidden: false, align: "left", width: 280, sortable: false }
                            , { name: 'UniOrganica', index: 'UniOrganica', hidden: false, align: "left", width: 150, sortable: false }
                            , { name: 'CodUniOrganica', index: 'CodUniOrganica', hidden: true, align: "center", width: 0, sortable: false }
                            , { name: 'FechaIngreso', index: 'FechaIngreso', hidden: true, align: "center", width: 0, sortable: false }
                ]
                        , rowNum: 10, rowList: [5, 10, 15, 20], pager: '#pageDataCgrBuscarPersonal', sortname: 'NomCompleto', viewrecords: true, sortorder: "asc"
                        , height: 200
                        , autowidth: true
                        , shrinkToFit: false
                        , caption: "Listado de Personal"
                        , rownumbers: false
                        , reloadAfterEdit: false
                        , reloadAfterSubmit: false
                        , toolbar: [true, "top"]
                        , hidegrid: false
                        , ondblClickRow: function (rowid) { return $('#btnCgrBuscarPersonal_Aceptar').click(); /*aceptarB(rowid);*/ }
            }).navGrid('#pageDataCgrBuscarPersonal', { refresh: false, search: false, add: false, edit: false, del: false });
            $("#gridDataCgrBuscarPersonal").addToolBar("toolbarB");
            $('#pageDataCgrBuscarPersonal_left').css("display", "none");

            /*
                cuadro de busqueda
            */
            $('#txtCgrBuscarNomPersonal').keypress(function (e) {
                if (e.which == 13) {
                    $("#gridDataCgrBuscarPersonal").trigger("reloadGrid");
                    return false;
                }
            });
            $('#txtCgrBuscarNomPersonal').keydown(function (e) {
                if (e.keyCode == 40) {
                    if ($("#gridDataCgrBuscarPersonal").getGridParam("records") > 0) {
                        $("#gridDataCgrBuscarPersonal").focus();
                    }
                }
            });
            /*
                aceptar
            */
            $('#btnCgrBuscarPersonal_Aceptar').click(function () {
                if ($('#gridDataCgrBuscarPersonal').getGridParam('selrow') == null)
                    return false;
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
            $('#btnCgrBuscarPersonal_Cancelar').click(function () {
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
                setRecordCgrBuscarPersonal();
                GoSubModalCGR(false);
                if (typeof CallbackCancel == 'function') {
                    if (!executeCallBack) { CallbackCancel.call(dialogo); }
                }
                $("#divBaseCgrBuscarPersonal").remove();
                $("#dialogConsultaPersonal").remove();
            });
            // buscar
            $("#btnCgrBuscarPersonal").click(function () {
                $("#gridDataCgrBuscarPersonal").trigger("reloadGrid");
                return false;
            });
            /*
                muestra dialogo
            */
            if ($.browser.msie) {
                dialogo.removeClass('fade');
            }

            dialogo.modal({
                keyboard: false, backdrop: 'static'
            });

        });

    },
    //
    // 
    BuscarPersonalReport: function (container, CallbackAccept, CallbackCancel, codUO) {
        /// <summary>
        /// Muestra una ventana de dialogo para realizar la búsqueda de informes
        /// </summary>
        /// <param name="CallbackAccept" type="function">(Opcional) Función a ejecutar luego de pulsar [Aceptar]</param>
        /// <param name="CallbackCancel" type="function">(Opcional) Función a ejecutar luego de pulsar [Cancelar] ó al salir de la ventana</param>
        /// <param name="codUO" type="string">(Opcional) Codigo de unidad organica </param>
        var executeCallBack = false;

        $("#divBaseCgrBuscarPersonal").remove();
        $(container).append("<div id='divBaseCgrBuscarPersonal'></div>")
        $("#divBaseCgrBuscarPersonal").load(PROYECTOCGR.UrlActionMethod("/AsistenciaRH/Comun", "BusquedaPersonal"), function (response, status) {
            var dialogo = $("#dialogConsultaPersonal");
            /*
                configura jqgrid
            */
            $("#gridDataCgrBuscarPersonal").jqGrid({
                datatype: function () {

                    var parFiltroB = new Object();
                    parFiltroB.PARAMETRO1 = $('#txtCgrBuscarNomPersonal').val();
                    parFiltroB.PARAMETRO2 = (codUO == null ? '' : codUO);
                    parFiltroB.PARAMETRO3 = '';
                    parFiltroB.Page_size = $('#gridDataCgrBuscarPersonal').getGridParam("rowNum");
                    parFiltroB.Page_number = $('#gridDataCgrBuscarPersonal').getGridParam("page");
                    parFiltroB.Sort_Column = $('#gridDataCgrBuscarPersonal').getGridParam("sortname");
                    parFiltroB.Sort_Order = $('#gridDataCgrBuscarPersonal').getGridParam("sortorder");

                    PROYECTOCGR.CargarGridLoad(PROYECTOCGR.UrlActionMethod("/AsistenciaRH/Comun", "GetPersonalReport"), "gridDataCgrBuscarPersonal", { 'dato': parFiltroB }, null, "dialogConsultaPersonal");
                },
                colNames: ['Código', 'Nombre del Colaborador', 'Unidad Orgánica', 'Cod Unidad Organica', 'Fecha Ingreso'],
                colModel: [
                              { name: 'codigo', index: 'codigo', hidden: false, align: "center", width: 50, sortable: false }
                            , { name: 'NomCompleto', index: 'NomCompleto', hidden: false, align: "left", width: 280, sortable: false }
                            , { name: 'UniOrganica', index: 'UniOrganica', hidden: false, align: "left", width: 150, sortable: false }
                            , { name: 'CodUniOrganica', index: 'CodUniOrganica', hidden: true, align: "center", width: 0, sortable: false }
                            , { name: 'FechaIngreso', index: 'FechaIngreso', hidden: true, align: "center", width: 0, sortable: false }
                ]
                        , rowNum: 10, rowList: [5, 10, 15, 20], pager: '#pageDataCgrBuscarPersonal', sortname: 'NomCompleto', viewrecords: true, sortorder: "asc"
                        , height: 200
                        , autowidth: true
                        , shrinkToFit: false
                        , caption: "Listado de Personal"
                        , rownumbers: false
                        , reloadAfterEdit: false
                        , reloadAfterSubmit: false
                        , toolbar: [true, "top"]
                        , hidegrid: false
                        , ondblClickRow: function (rowid) { return $('#btnCgrBuscarPersonal_Aceptar').click(); /*aceptarB(rowid);*/ }
            }).navGrid('#pageDataCgrBuscarPersonal', { refresh: false, search: false, add: false, edit: false, del: false });
            $("#gridDataCgrBuscarPersonal").addToolBar("toolbarB");
            $('#pageDataCgrBuscarPersonal_left').css("display", "none");

            /*
                cuadro de busqueda
            */
            $('#txtCgrBuscarNomPersonal').keypress(function (e) {
                if (e.which == 13) {
                    $("#gridDataCgrBuscarPersonal").trigger("reloadGrid");
                    return false;
                }
            });
            $('#txtCgrBuscarNomPersonal').keydown(function (e) {
                if (e.keyCode == 40) {
                    if ($("#gridDataCgrBuscarPersonal").getGridParam("records") > 0) {
                        $("#gridDataCgrBuscarPersonal").focus();
                    }
                }
            });
            /*
                aceptar
            */
            $('#btnCgrBuscarPersonal_Aceptar').click(function () {
                if ($('#gridDataCgrBuscarPersonal').getGridParam('selrow') == null)
                    return false;
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
            $('#btnCgrBuscarPersonal_Cancelar').click(function () {
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
                setRecordCgrBuscarPersonal();
                GoSubModalCGR(false);
                if (typeof CallbackCancel == 'function') {
                    if (!executeCallBack) { CallbackCancel.call(dialogo); }
                }
                $("#divBaseCgrBuscarPersonal").remove();
                $("#dialogConsultaPersonal").remove();
            });
            // buscar
            $("#btnCgrBuscarPersonal").click(function () {
                $("#gridDataCgrBuscarPersonal").trigger("reloadGrid");
                return false;
            });
            /*
                muestra dialogo
            */
            if ($.browser.msie) {
                dialogo.removeClass('fade');
            }

            dialogo.modal({
                keyboard: false, backdrop: 'static'
            });

        });

    },
    //
    BuscarInforme: function (CallbackAccept, CallbackCancel) {
        /// <summary>
        /// Muestra una ventana de dialogo para realizar la búsqueda de informes
        /// </summary>
        /// <param name="CallbackAccept" type="function">(Opcional) Función a ejecutar luego de pulsar [Aceptar]</param>
        /// <param name="CallbackCancel" type="function">(Opcional) Función a ejecutar luego de pulsar [Cancelar] ó al salir de la ventana</param>

        var executeCallBack = false;

        var dlg = getWindowCgrBuscarEntidad("Buscar Informes");

        var dialogo = $(dlg).modal({
            keyboard: false, backdrop: 'static'
        });

        dialogo.on('hide', function () {
            setRecordCgrBuscarEntidad();
            if (typeof CallbackCancel == 'function') {
                if (!executeCallBack) { CallbackCancel.call(dialogo); }
            }
            dialogo.remove();
        });

        dialogo.on('shown', function () {
            // grid
            $("#tblCgrBuscarEntidad").jqGrid({
                datatype: function () {
                    PROYECTOCGR.CargarGridLoad(PROYECTOCGR.UrlActionMethod("Movimiento", "Get_Movimientos"), "tblCgrBuscarEntidad",
                                {
                                    'pageNumber': $('#tblCgrBuscarEntidad').getGridParam("page")
                                    , 'pageSize': $('#tblCgrBuscarEntidad').getGridParam("rowNum")
                                    , 'sortColumn': $('#tblCgrBuscarEntidad').getGridParam("sortname")
                                    , 'sortOrder': $('#tblCgrBuscarEntidad').getGridParam("sortorder")
                                });
                },
                colNames: ['Numero Informe', 'Nº Movimiento', 'Estado', 'Area'],
                colModel: [
                                { name: 'ciac_codigo', index: 'ciac_codigo', hidden: false, align: "center", width: 82, sortable: false },
                                { name: 'nmov_numero', index: 'nmov_numero', hidden: false, align: "center", width: 110, sortable: true },
                                { name: 'cmov_estado', index: 'cmov_estado', hidden: false, align: "left", width: 270, sortable: false },
                                { name: 'cmov_area', index: 'cmov_area', hidden: false, align: "left", width: 305, sortable: false }
                ]
                            , rowNum: 5, rowList: [5, 10, 15, 20], pager: '#pageCgrBuscarEntidad', sortname: 'ciac_codigo', viewrecords: true, sortorder: "asc"
                            , height: 200
                            , autowidth: true
                            , shrinkToFit: false
                            , caption: "MOVIMIENTOS"
                            , rownumbers: false
                            , reloadAfterEdit: false
                            , reloadAfterSubmit: false
            }).navGrid('#pageCgrBuscarEntidad', { refresh: false, search: false, add: false, edit: false, del: false });
            // boton aceptar
            $('#btnCgrBuscar_Aceptar').bind('click', function () {
                if ($('#tblCgrBuscarEntidad').getGridParam('selrow') == null)
                    return false;
                if (typeof CallbackAccept == 'function') {
                    executeCallBack = true;
                    dialogo.modal('hide');
                    CallbackAccept.call(dialogo);
                } else {
                    dialogo.modal('hide');
                }
                return true;
            });
            // boton cancelar
            $("#btnCgrBuscar_Cancelar").bind('click', function () {
                if (typeof CallbackCancel == 'function') {
                    executeCallBack = true;
                    dialogo.modal("hide");
                    CallbackCancel.call(dialogo);
                } else {
                    dialogo.modal("hide");
                }
                return true;
            });
        });

    }
}
