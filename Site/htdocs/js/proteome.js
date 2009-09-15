$(document).ready(function() {
    document.proteome = new Proteome();
    document.proteome.initialize();
});

function Proteome() {

    this.initialize = function() {
        this.decorateForms();
        this.validateForms();
    };

    this.decorateForms = function() {
        $("form input[required=\"true\"]").each(function() {
            $(this).after("<span style=\"color:red\" title=\"This field is required\">*</span>");
        });
    }

    this.validateForms = function() {
        $("form").submit(function() {
            var result = true;
            $(this).find("input").each(function() {
                var required = $(this).attr("required");
                if (required != "true") return;
      
                // reset the state
                $(this).siblings(".error").remove();
                $(this).css("background-color", "white");
                var value = $(this).val();
                if (value == "") {
                    result = false;
                    $(this).before("<div class=\"error\" style=\"color:red\">" + $(this).attr("name") + " is required.</div>");
                    $(this).css("background-color", "#FFCCCC");
                    $(this).focus();
                }
            });
            return result;
        });
    }
}


