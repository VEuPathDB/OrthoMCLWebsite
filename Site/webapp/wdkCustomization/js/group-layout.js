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
    data.find(".taxons .taxon").each(function() {
      var taxon = $(this);
      var id = taxon.attr("id");
      taxons[id] = taxon;
    });

    // load nodes
    nodes = [];
    data.find(".nodes .node").each(function() {
      var node = $(this);
      var id = node.attr("id");
      nodes[id] = node; // the node id is the index, can be used for array address
    });

    // load edges
    edges = [];
    data.find(".edges .edge").each(function() {
      var edge = $(this);
      edges.push(edge);
    });
  }

  function initializeCanvas(layout) {
    d3.select(layout.find(".canvas").get(0)).selectAll(".node")
      .data(nodes)
      .style("fill", function(node){
                       var taxon = taxons[node.data("taxon")];
                       return taxon.data("color"); 
                     })
      .style("stroke", function(node){ 
                         var taxon = taxons[node.data("taxon")];
                         return taxon.data("group-color"); 
                       });
    renderEdgesByType(layout);
  }

  function initializeControls(layout) {
    var controls = layout.find(".controls");
    controls.find(".accordion").accordion();

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
    edgeControl.find(".type-control .edge-type").change(function() {
      renderEdgesByType(layout);
    });
    edgeControl.find(".score-control .evalue").slider({
      min: -180,
      max: -5,
      value: -5,
      slide: function() {
               edgeControl.find(".score-control .evalue-exp").text($(this).value);
               renderEdgesByScore(layout);
             }
    });
  }

  function renderEdgesByType(layout) {
    // determine which type of edges will be displayed.
    var ortholog = false;
    var coortholog = false;
    var inparalog = false;
    var normal = false;
    layout.find(".controls .edge-control .edge-type").each(function() {
      if (this.checked) {
        if (this.value == "Ortholog") ortholog = true;
        else if (this.value == "Coortholog") coortholog = true;
        else if (this.value == "Inparalog") inparalog = true;
        else if (this.value == "Normal") normal = true;
      }
    });
    d3.select(layout.find(".canvas").get(0)).selectAll(".edge")
      .data(edges)
      .style("stroke", function(edge) {
                         var type = edge.data("type");
                         if (type == "O") return "red";
                         else if (type == "C") return "yellow";
                         else if (type == "P") return "#00CC00";
                         else return "gray";
                       })
      .style("display", function(edge) {
                          var type = edge.data("type");
                          if (type == "O") return ortholog ? "block" : "none";
                          else if (type == "C") return coortholog ? "block" : "none";
                          else if (type == "P") return inparalog ? "block" : "none";
                          else return normal ? "block" : "none";
                        });
  }

  function renderEdgesByScore(layout) {

  }

  ns.init = init;

});
