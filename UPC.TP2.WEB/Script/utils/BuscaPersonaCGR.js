/// <reference path="ProyectoCGR.js" />

var BUSCAPERSONACGR = {
    //
    SetBuscaPersonal: function (CodPersonal, NomPersonal, CodUO, NomUO, FechaIngreso, CallAdicionalObtener, CallAdicionalLimpiar, pEstadoVista, Bloquear_Inicio, Desbloquear_Fin) {

        // Mask & UpperCase
        PROYECTOCGR.ToUpperCase(CodUO);
        PROYECTOCGR.ToUpperCase(NomUO);
        PROYECTOCGR.ToUpperCase(NomPersonal);

        $.mask.definitions['~'] = '[abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789]';
        $("#" + CodUO).mask('~~~~');
        $("#" + CodPersonal).mask('99999');

        // Unidad Orgánica: Lost Focus
        $("#" + CodUO).blur(function () {
            if ($("#" + CodUO).val().length != 4) {
                $("#" + NomUO).val('');
                //$("#" + CodPersonal).val('');
                //$("#" + NomPersonal).val('');
                //$("#" + FechaIngreso).val('');
                // Adicionales Formulario: Limpiar
                if (typeof CallAdicionalLimpiar == 'function') { CallAdicionalLimpiar.call(this); }
                return false;
            }
            $.ajax({
                url: PROYECTOCGR.UrlActionMethod("Comun", "GetUniOrganicaByCodRol"),
                data: JSON.stringify({ 'token': PROYECTOCGR.GetToken(), 'pCodRol': pEstadoVista, 'pCodUniOrganica': $("#" + CodUO).val() }),
                success: function (result) {
                    if (result.Msg) alert(result.Msg);
                    $("#" + CodUO).val(result.Codigo);
                    $("#" + NomUO).val(result.Nombre);
                }
            });
        });

        // Unidad Orgánica: AutoComplete
        $("#" + NomUO).typeahead({
            ajax: {
                url: PROYECTOCGR.UrlActionMethod("Comun", "GetUniOrganicaByNomRol"),
                valueField: "Id",
                displayField: "Valor",
                triggerLength: 3,
                method: "Get",
                preDispatch: function (query) {
                    return {
                        'token': PROYECTOCGR.GetToken()
                        , pCodRol: pEstadoVista
                        , pNomUniOrganica: query
                    }
                },
                preProcess: function (data) {
                    if (data == '') {
                        return false;
                    }
                    return data;
                }
            }
        , onSelect: function (obj) {
            $('#' + CodUO).val(obj.Id);
        }
        });

        // Colaborador: Lost Focus
        $("#" + CodPersonal).focusout(function () {
            GetPersonalDatos();
        });

        function GetCodUO() {
            if (pEstadoVista == CGR_Rol_Usuario.Analista)
                return ""
            return $("#" + CodUO).val();
        }

        function GetPersonalDatos() {
            if ($("#" + CodPersonal).val().length == 5 && $("#" + CodPersonal).val() != '_____') {
                var IdPopupActivo = $(".hide.in.modal")[0];
                if (Bloquear_Inicio == 'S')
                    PROYECTOCGR.ShowProgressSubModal((!IdPopupActivo ? "" : IdPopupActivo.id));
                $.ajax({
                    url: PROYECTOCGR.UrlActionMethod("Comun", "GetPersonalByCodInUORol"),
                    data: JSON.stringify({
                        'token': PROYECTOCGR.GetToken(), 'pCodRol': pEstadoVista, 'pCodPersonal': $("#" + CodPersonal).val(),
                        'pCodUniOrganica': GetCodUO()
                    }),
                    success: function (result) {
                        if (result != null) {
                            var data = result.Dato;
                            $("#" + NomPersonal).val('');
                            if (data == false) {
                                alert(result.Msg);
                                $("#" + CodPersonal).val('');
                                $("#" + NomPersonal).val('');
                                $("#" + FechaIngreso).val('');
                                // Adicionales Formulario: Limpiar
                                if (typeof CallAdicionalLimpiar == 'function') { CallAdicionalLimpiar.call(this); }
                            }
                            else {
                                if (Desbloquear_Fin == 'S')
                                    PROYECTOCGR.HideProgress();
                                $("#" + NomPersonal).val(data.NomPersonal);
                                $("#" + FechaIngreso).val(data.FechaIngreso);
                                // Adicionales Formulario: Obtener
                                if (typeof CallAdicionalObtener == 'function') { CallAdicionalObtener.call(this); }
                                //if (pEstadoVista == CGR_Rol_Usuario.AsistenteGerencia || pEstadoVista == CGR_Rol_Usuario.Gerente) {
                                //    return;
                                //}
                                //else {
                                $("#" + CodUO).val(data.CodUniOrganica);
                                $("#" + NomUO).val(data.NomUniOrganica);
                                //}
                            }
                        }
                        if (Desbloquear_Fin == 'S')
                            PROYECTOCGR.HideProgress();
                    }
                });
            }
            else {
                $("#" + NomPersonal).val('');
                if (pEstadoVista == CGR_Rol_Usuario.AsistenteGerencia || pEstadoVista == CGR_Rol_Usuario.Gerente) {
                    // Nothing
                }
                else {
                    $("#" + CodUO).val('');
                    $("#" + NomUO).val('');
                }
                // Adicionales Formulario: Limpiar
                if (typeof CallAdicionalLimpiar == 'function') { CallAdicionalLimpiar.call(this); }
            }
        }

        // Colaborador: AutoComplete
        $("#" + NomPersonal).typeahead({
            ajax: {
                url: PROYECTOCGR.UrlActionMethod("Comun", "GetPersonalByNomRol"),
                valueField: "Id",
                displayField: "Valor",
                triggerLength: 3,
                method: "Get",
                preDispatch: function (query) {
                    return {
                        'token': PROYECTOCGR.GetToken()
                        , pCodRol: pEstadoVista
                        , pNomPersona: query
                        , pcodUniOrganica: GetCodUO()
                    }
                },
                preProcess: function (data) {
                    if (data == '') {
                        return false;
                    }
                    return data;
                }
            }
            , onSelect: function (obj) {
                $('#' + CodPersonal).val(obj.Id.split('@')[0]);
                $("#" + FechaIngreso).val(obj.Id.split('@')[3]);
                // Adicionales Formulario: Obtener
                if (typeof CallAdicionalObtener == 'function') { CallAdicionalObtener.call(this); }
                // Para los Gerentes no coincide
                $("#" + CodUO).val(obj.Id.split('@')[1]);
                $("#" + NomUO).val(obj.Id.split('@')[2]);
            }
        });
    }
}