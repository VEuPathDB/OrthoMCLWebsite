$(function() {
    $(".button").button();

    initLoginDialog();
    
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

var loginDialog;

function initLoginDialog() {
	loginDialog = $('#user-control div#login').dialog({
		modal: true,
		autoOpen: false
	});
	$('#login-cancel-button').click(function() {
		$(loginDialog).dialog('close');
		//$(loginDialog).child('form').clear();
	});
}

function login() {
	$(loginDialog).dialog('open');
}

function logout() {
    var userName = $("#user-control #user-name").text();
    if(confirm("Do you want to logout as " + userName + "?")) {
    	window.location = $('#logout').data('location');
    }
}
