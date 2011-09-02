$(function() {
    var home = new Home();
    home.configureBubbles();
});

function Home() {

    this.configureBubbles = function() {
        $("#search-bubbles > ul > li").addClass("ui-widget ui-widget-content ui-corner-all");
        $("#search-bubbles > ul > li > a").addClass("ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all");
        $("#search-bubbles > ul > li > div a.parent").each(function() {
            $(this).addClass("opened").click(function() {
                if ($(this).hasClass("opened")) {
                    $(this).siblings("div").hide();
                    $(this).removeClass("opened");
                } else {
                    $(this).siblings("div").show();
                    $(this).addClass("opened");
                }
            }); 
        }); 
    };

}
