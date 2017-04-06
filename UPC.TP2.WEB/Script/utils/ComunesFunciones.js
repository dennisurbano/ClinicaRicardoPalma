//=== BEGIN: MAIN LOAD ON PAGE
(function ($) {

    //Bitacora
    if ($("#bitacora_action_select_plan").val() == "default" || $("#bitacora_action_select_plan").val() == "-1") {
        $("#bitacora_create_button").attr("disabled", "disabled");
        $("#bitacora_create_button").prop("disabled", "disabled");
    }
    //Estrategia comercial
    if ($("#estrategia_comercial_action_select_plan").val() == "default" || $("#estrategia_comercial_action_select_plan").val() == "-1") {
        $("#estrategia_comercial_create_button").attr("disabled", "disabled");
        $("#estrategia_comercial_create_button").prop("disabled", "disabled");
    }

})(jQuery);

//=== END: MAIN LOAD ON PAGE

// BEGIN ## DATEPICKER ##

$("#estrategia_comercial_detalle_fecha_inicio").datepicker({ format: "dd/mm/yyyy" });

$("#estrategia_comercial_detalle_fecha_fin").datepicker({ format: "dd/mm/yyyy" });

$("#plan_salud_fecha_inicio").datepicker({ format: "dd/mm/yyyy" });

$("#plan_salud_fecha_fin").datepicker({ format: "dd/mm/yyyy" });

// END ## DATEPIKER ##

// BEGIN ## SERVICIOS SALUD ##

//-- Valida fechas
$('#form_generar_servicio_salud').on('submit', function (e) {

    var fi = $("#fecha_inicio").val();//$.datepicker.formatDate("yyyy/mm/dd", $("#fecha_inicio").val());//$("#fecha_inicio").val();
    var ff = $("#fecha_fin").val();//$.datepicker.formatDate("yyyy/mm/dd", $("#fecha_fin").val());//$("#fecha_fin").val();

});

//-- Retirar servicios
$('#submit_retirar').on('click', function (e) {
    $('#accion').attr('value', 'retirar');
    var min = 0;
    $("#table_retirar").find("input[type='checkbox']").each(function () {
        if ($(this).is(":checked")) {
            min++;
        }
    });
    if (min > 0) {
        $("#form_generar_accion").submit();
    }
    else {
        alert("Debe seleccionar almenos una fila");
        e.preventDefault();
    } 
});

//-- Asignar servicios
$("#submit_asignar").on("click", function (e) {
    $("#accion").attr("value", "asignar");
    var min = 0;
    $("#table_asignar").find("input[type='checkbox']").each(function () {
        if ($(this).is(":checked")) {
            min++;
        }
    });
    if (min > 0) {
        $("#form_generar_accion").submit();
    }     
    else {
        alert("Debe asignar almenos una fila");
        e.preventDefault();
    }
        
});

// END ## SERVICIOS SALUD ##

// BEGIN ## BITACORAS ##

$("#bitacora_action_select_plan").on("change", function (e) {
    if ($(this).val() != "default") {
        $("#form_bitacora_index").attr("action", "/Bitacora/ChangePlanSalud");
        $("#form_bitacora_index").submit();
    } 
});

$("#bitacora_create_button").on("click", function (e) {
    if ($(this).attr("disabled") == "disabled") {
        e.preventDefault();
        e.stopPropagation();
        return;
    }

    if ($("#bitacora_action_select_plan").val() == "default" || $("#bitacora_action_select_plan").val() == "-1") {
        alert("Debe selecionar un plan de salud");
        e.preventDefault();
        e.stopPropagation();
    }
});

$("#bitacora_button_create_submit").on("click", function (e) {

    var to_submit = true;

    $("#bitacora_create_form_div").find("input, select").each(function () {
        if ($(this).val() == "") {
            alert("Debe llenar todos los campos");
            to_submit = false;
            e.preventDefault();
            return false; //break loop
        }
    });

    if (to_submit) {
        $("#form_bitacora_index").attr("action", "/Bitacora/Create");
        $("#form_bitacora_index").submit();
    } 
});

// END ## BITACORAS ##

// BEGIN ## ESTRATEGIAS COMERCIALES ##

$("#estrategia_comercial_action_select_plan").on("change", function (e) {
    if ($(this).val() != "default") {
        $("#form_estrategia_comercial_index").attr("action", "/EstrategiaComercial/Index");
        $("#form_estrategia_comercial_index").submit();
    }
});

$("#estrategia_comercial_create_button").on("click", function (e) {
    if ($(this).attr("disabled") == "disabled") {
        e.preventDefault();
        e.stopPropagation();
        return;
    }

    if ($("#estrategia_comercial_select_plan").val() == "default" || $("#estrategia_comercial_action_select_plan").val() == "-1") {
        alert("Debe selecionar un plan de salud");
        e.preventDefault();
        e.stopPropagation();
    }
});

$("#estrategia_comercial_detalle_button_create_save").on("click", function (e) {

    var to_submit = true;

    $("#estrategia_comercial_detalle_form").find("input, select").each(function () {
        if ($(this).val() == "") {
            alert("Debe llenar todos los campos");
            to_submit = false;
            e.preventDefault();
            return false; //break loop
        }
    });

    if (to_submit) {
        $("#estrategia_comercial_detalle_form").attr("action", "/EstrategiaComercial/CreateDetalleSave");
        $("#estrategia_comercial_detalle_form").submit();
    }

});

// END ## ESTRATEGIAS COMERCIALES ##

// BEGIN ## PLAN DE SALUD ##

$("#plan_salud_action_select_plan").on("change", function (e) {
    if ($(this).val() != "default") {
        $("#form_plan_salud_index").attr("action", "/PlanSalud/Index");
        $("#form_plan_salud_index").submit();
    }
});

// END ## PLAN DE SALUD ##
