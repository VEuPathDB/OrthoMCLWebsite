$(function() {
    $(".button").button();

    // submit Contact us via AJAX
    $("body").on("submit", "#contact-us", function(e) {
      e.preventDefault();
      var form = this,
          jform = $(form),
          emailRegex = /^\S+@\S+$/,
          ccAddrs = this.addCc.value.split(/,\s*(?=\w)/);

      // validation of email addresses
      if (ccAddrs.length > 10) {
        $("<div>You have entered more than 10 Cc addresses. " +
            "Please limit this to 10.</div>").dialog({
          title: "Oops! An error occurred.",
          buttons: [{
            text: "OK",
            click: function() { $(this).dialog("close"); }
          }],
          modal: true
        });
        return;
      }

      var badAddrs = $.grep(ccAddrs.concat(form.reply.value), function(addr) {
        emailRegex.test(addr);
      }, true);

      if (badAddrs.length > 0) {
        var list = $.map(badAddrs, function(addr) {
          return "<li>" + addr + "</li>";
        }).join("");
        $("<div></div>").html("<h3>The following email addresses appear to " +
            "be invalid.</h3><ul>" + list + "</ul>").dialog({
          title: "Oops! An error occurred.",
          buttons: [{
            text: "OK",
            click: function() { $(this).dialog("close"); }
          }],
          modal: true
        }).addClass("contact-us");
        return;
      }

      // send request
      $.post(jform.attr("action"), jform.serialize(), function(data) {
        switch (data.status) {

          case "success":
            // close containing dialog
            form.reset();
            jform.parents("#wdk-dialog-contact-us").dialog("close");
            $("<div></div>").html(data.message).dialog({
              title: "Thank you!",
              buttons: [{
                text: "OK",
                click: function() { $(this).dialog("close"); }
              }],
              modal: true
            });
            break;

          case "error":
            var response = "<h3>Please try to correct any errors below</h3>" +
                "<br/>" + data.message;
            $("<div></div>").html(response).dialog({
              title: "Oops! An error occurred.",
              buttons: [{
                text: "OK",
                click: function() { $(this).dialog("close"); }
              }],
              modal: true
            });
            break;
        }
      }, "json").error(function(jqXHR, textStatus, errorThrown) {
        var response = "<h3>A " + textStatus + " error occurred.</h3><br/>" +
            "<p>This indicates a problem with our server. Please email " +
            "support directly.";
        $("<div></div>").html(response).dialog({
          title: "Oops! An error occurred.",
          buttons: [{
            text: "OK",
            click: function() { $(this).dialog("close"); }
          }],
          modal: true
        });
      });
    });

});

function login() {
    // somehow the dialog cannot center itself
    var dialog = $("#user-control div#login").clone();
    dialog.find("form[name=loginForm]").submit(processLogin);
    dialog.dialog({
        modal: true,
    });
}

function processLogin() {
    var form = $("#user-control form[name=loginForm]");
    var url = form.attr("action");
    var data = form.serialize();
    $.ajax({
        url: url,
        data: data,
        type: 'POST',
        success: function(data, textStatus, jqXHR) {
            window.location.reload( true );
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert(textStatus + "\n" + errorThrown);
        },
    });
    return false;
}

function logout() {
    var userName = $("#user-control #user-name").text();
    if(confirm("Do you want to logout as " + userName + "?")) {
        var form =  $("#user-control form[name=logoutForm]");
        var url = form.attr("action");
        $.ajax({
            url: url,
            type: 'POST',
            success: function(data, textStatus, jqXHR) {
                window.location.reload( true );
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(textStatus + "\n" + errorThrown);
            },
        });
    }
}
