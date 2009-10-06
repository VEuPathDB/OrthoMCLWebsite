// cookie names
$(document).ready(function() {
    document.svg = new Svg();
    document.svg.addNodeMotion();
    document.svg.addEdgeMotion();
    document.svg.addControlMotion();
});

function Svg() {

    this.info1 = $("#info1");
    this.info2 = $("#info2");
    this.info3 = $("#info3");

    this.addNodeMotion = function() {
        var svg = this;
        $("circle").each(function() {
            var gene = $(this).attr("id");
            var taxon = $(this).parent();
            $(this).hover(function() {
                    taxon.children("circle").attr("r", "7");
                    svg.info1.text($(this).attr("name"));
                    svg.info2.text(taxon.attr("name") + " (" + taxon.attr("abbrev") + ")");
                    svg.info3.text($(this).attr("description"));
                },
                function() {
                    taxon.children("circle").attr("r", "5");
                    svg.info1.text("");
                    svg.info2.text("");
                    svg.info3.text("");
                }
            );
            $(this).click(function() {
                var gene = $(this).attr("id");
                $("line").each(function() {
                    var query = $(this).attr("query");
                    var subject = $(this).attr("subject");
                    var display = (gene == query || gene == subject) ? "block" : "none";
                    $(this).attr("display", display);
                });
            });
        });
    };

    this.addEdgeMotion = function() {
        var svg = this;
        $("line").each(function() {
            var queryId = $(this).attr("query");
            var subjectId = $(this).attr("subject");
            var query = $("circle#" + queryId);
            var subject = $("circle#" + subjectId);
            $(this).hover(function() {
                    this.setAttributeNS(null,"style","stroke-width:4;");
                    $(this).attr("stroke-width", "5");
                    query.attr("r", "7");
                    subject.attr("r", "7");
                    svg.info1.text(query.attr("name"));
                    svg.info2.text(subject.attr("name"));
                    svg.info3.text($(this).attr("evalue"));
                },
                function() {
                    this.setAttributeNS(null,"style","stroke-width:2;");
                    query.attr("r", "5");
                    subject.attr("r", "5");
                    svg.info1.text("");
                    svg.info2.text("");
                    svg.info3.text("");
                }
            );
        });
    };

    this.addControlMotion = function() {
        this.addControlMotionByType("Ortholog");
        this.addControlMotionByType("Coortholog");
        this.addControlMotionByType("Inparalog");
        this.addControlMotionByType("Normal");
    };

    this.addControlMotionByType = function(type) {
        $("#control #" + type + "_switch").each(function() {
            $(this).hover(function() {
                    $(this).attr("fill", "red");
                },
                function() {
                    $(this).attr("fill", "black");
                }
            );
            $(this).click(function() {
                var display = ($(this).text().substr(0, 4) == "Show") ? "block" : "none";
                var next = (display == "block") ? "Hide" : "Show"
                var rest = $(this).text().substr(4);
                $(this).text(next + rest);
                $("#" + type + " line").each(function() {
                    $(this).attr("display", display);
                });
            });
        });
    };
}
