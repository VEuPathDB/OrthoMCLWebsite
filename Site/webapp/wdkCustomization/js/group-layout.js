wdk.util.namespace("orthomcl.group.layout", function(ns, $) {
  "use strict";

  var taxons = {};
  var nodes = [];
  var edges = [];
  
  var init = function(layout, attrs) {
    // load data
    loadData(layout);

    // draw the layout on canvas
    initializeCanvas(layout);

    // register handlers for the UI controls
    initializeControls(layout);
  };

  function loadData(layout) {
    var data = layout.find(".data");

    // load taxons
    taxons = {};
    data.find(".taxons .taxon")
        .each(function() {
          var taxon = $(this);
          var id = taxon.attr("id");
          taxons[id] = taxon;
        });

    // load nodes
    nodes = [];
    data.find(".nodes .node")
        .each(function() {
          var node = $(this);
          var id = node.attr("id");
          nodes[id] = node; // the node id is the index, can be used for array address
        });

    // load edges
    edges = [];
    data.find(".edges .edge")
        .each(function() { edges.push($(this)); });
  }

  function initializeCanvas(layout) {
    var canvas = d3.select(layout.find(".canvas").get(0));
    canvas.selectAll(".node").data(nodes);
    canvas.selectAll(".edge").data(edges);
	
    // initialize nodes
    canvas.selectAll("circle.node")
          .style("fill", function(node){
            var taxon = taxons[node.data("taxon")];
	    return taxon.data("color"); 
          })
          .style("stroke", function(node){ 
            var taxon = taxons[node.data("taxon")];
            return taxon.data("group-color"); 
          });
    layout.find(".canvas .node")
          .hover(function() { highlightNodes(layout, ".nodes ." + this.id); },
                 function() { resetNodes(layout, ".nodes ." + this.id);	}
                );
			
    // initialize edges			
    renderEdgesByType(layout);
    layout.find(".canvas .edge")
          .hover(function() { highlightEdges(layout, ".edges ." + this.id); },
                 function() { resetEdges(layout, ".edges ." + this.id); }
                );
  }

  function initializeControls(layout) {
    var controls = layout.find(".controls");
    controls.find(".accordion").accordion();

	// edge controls
    var edgeControl = controls.find(".edge-control");
    edgeControl.find(".edge-display").change(function() {
        edgeControl.find(".type-control").toggle("slide", { "direction": "up" });
        edgeControl.find(".score-control").toggle("slide", { "direction": "down" });
        if (this.value == "type") {
          renderEdgesByType(layout);
        } else {
          renderEdgesByScore(layout);
        }
    });
    edgeControl.find(".type-control .edge-type")
               .change(function() {
                 renderEdgesByType(layout);
               });
    var exp = edgeControl.find(".score-control .evalue-exp");
    var slider = edgeControl.find(".score-control .evalue")
    slider.slider({
      min: slider.data("min-exp"),
      max: slider.data("max-exp"),
      value: slider.data("max-exp"),
      slide: function(event, ui) {
               exp.val(ui.value);
               renderEdgesByScore(layout);
             }
    });
    exp.change(function() {
      slider.slider("value", this.value);
      renderEdgesByScore(layout);
    });
	
    // node controls
    var nodeControl = controls.find(".node-control");
    nodeControl.find(".taxon")
               .each(function() {
                 var abbrev = this.id;
                 $(this).hover(function() {
                   $(this).addClass("highlight");
                   highlightNodes(layout, "circle.node." + abbrev);
                 },
                 function() {
                   $(this).removeClass("highlight");
                   resetNodes(layout, "circle.node." + abbrev);
                 });
               });
  }

  function renderEdgesByType(layout) {
    // determine which type of edges will be displayed.
    var ortholog = false;
    var coortholog = false;
    var inparalog = false;
    var normal = false;
    layout.find(".controls .edge-control .edge-type")
          .each(function() {
            if (this.checked) {
              if (this.value == "Ortholog") ortholog = true;
              else if (this.value == "Coortholog") coortholog = true;
              else if (this.value == "Inparalog") inparalog = true;
              else if (this.value == "Normal") normal = true;
            }
          });

    var canvas = d3.select(layout.find(".canvas").get(0));
    canvas.selectAll("line.edge")
          .style("display", function(edge) {
            var type = edge.data("type");
            if (type == "O") return ortholog ? "block" : "none";
            else if (type == "C") return coortholog ? "block" : "none";
            else if (type == "P") return inparalog ? "block" : "none";
            else return normal ? "block" : "none";
          })
          .style("stroke", function(edge) {
            var type = edge.data("type");
            if (type == "O") return "red";
            else if (type == "C") return "yellow";
            else if (type == "P") return "#00CC00";
            else return "gray";
          });
  }

  function renderEdgesByScore(layout) {
    // get evalue cutoff
    var cutoff = parseInt(layout.find(".controls .edge-control .evalue-exp").val());
    var canvas = d3.select(layout.find(".canvas").get(0));
    canvas.selectAll("line.edge")
          .style("display", function(edge) {
            var score = parseFloat(edge.data("score"));
            return (score <= cutoff) ? "block" : "none";
          })
          .style("stroke", function(edge) { return edge.data("color"); });
  }

  function highlightNodes(layout, selector) {
    var canvas = d3.select(layout.find(".canvas").get(0));
    var labels = canvas.select(".labels");
    canvas.selectAll(selector).each(function(node) {
      var circle = d3.select(this).attr("r", 8);
      var x = parseFloat(circle.attr("cx")) + 13;
      var y = parseFloat(circle.attr("cy")) + 2;
      drawLabel(labels, node.data("source-id"), x, y); 
    });
  }

  function resetNodes(layout, selector) {
    var canvas = d3.select(layout.find(".canvas").get(0));
    var labels = canvas.select(".labels");
    canvas.selectAll(selector).attr("r", 4);
    // can only remove all labels; selecting labels by id is not working;
    labels.selectAll("text").remove();
  }

  function highlightEdges(layout, selector) {
    var canvas = d3.select(layout.find(".canvas").get(0));
    var labels = canvas.select(".labels");
    canvas.selectAll(selector).each(function(edge) {
      var line = d3.select(this).style("stroke-width", 6);
      var type = edge.data("type");
      var label = (type == "O") ? "Ortholog" : (type == "C") ? "Coortholog" : (type == "P") ? "Inparalog" : "Normal";
      label += ", evalue=" + edge.data("evalue");
      var x = (parseFloat(line.attr("x1")) + parseFloat(line.attr("x2"))) / 2 + 13;
      var y = (parseFloat(line.attr("y1")) + parseFloat(line.attr("y2"))) / 2 + 2;
      drawLabel(labels, label, x, y);
      var nodeSelector = ".nodes .n" + edge.data("query") + ", .nodes .n" + edge.data("subject");
      highlightNodes(layout, nodeSelector);
    });
  }

  function resetEdges(layout, selector) {
    var canvas = d3.select(layout.find(".canvas").get(0));
    var labels = canvas.select(".labels");
    canvas.selectAll(selector).each(function(edge) {
      d3.select(this).style("stroke-width", 2);
      var nodeSelector = ".nodes .n" + edge.data("query") + ", .nodes .n" + edge.data("subject");
      resetNodes(layout, nodeSelector);
    });
  }

  function drawLabel(labels, text, x, y) {
    // draw the shadow first
    labels.append("text")
          .attr("class", "shadow")
          .attr("x", x+1)
          .attr("y", y+1)
          .text(text);

    // draw the actual text
    labels.append("text")
          .attr("x", x)
          .attr("y", y)
          .text(text);    
  }

  ns.init = init;

});
