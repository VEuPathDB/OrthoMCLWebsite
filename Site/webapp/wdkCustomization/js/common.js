$(function() {
    $(".button").button();
});

function login() {
    // somehow the dialog cannot center itself
    var dialog = $("#user-control div#login").clone();
    var left = ($(window).width() - dialog.width()) / 2;
    var top = ($(window).height() - dialog.height()) / 2;
    dialog.find("form[name=loginForm]").submit(processLogin);
    dialog.dialog({
        modal: true,
        position: [left, top],
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
