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

var COMUNESCGR = {
    //
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

            if (iKey == 13 || iKey == 9 || iKey == 37 || iKey == 39 || iKey == 46) {//ENTER, Tab, Left, Right, Supr
                blnPermitidoCGR = true;
            }
        });

        objControl.keypress(function (e) {
            e = e || window.event;
            var iKey = e.keycode || e.which || 0;
            //var modifiers = (e.altKey || e.ctrlKey || e.shiftKey);
            var permitidos = "0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚÄËÏÖÜ%&-.,'"

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

    }
};