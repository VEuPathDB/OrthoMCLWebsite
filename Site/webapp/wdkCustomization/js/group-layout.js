wdk.util.namespace("orthomcl.group.layout", function(ns, $) {
  "use strict";

  var taxons = {};
  var nodes = [];
  var edges = [];
  
  var init = function(layout, attrs) {
    // load data
    loadData(layout);

    // set up tabs
    layout.find(".control-tabs").tabs();
    layout.find(".datatable").DataTable({ bJQueryUI: true });

    // draw the layout on canvas
    initializeCanvas(layout);

    // register handlers for the UI controls
    layout.find(".controls").accordion({ collapsible: true, });
    initializeNodeControls(layout);
    initializeEdgeControls(layout);

    // initialize the display of node detail section
    initializeNodeDetail(layout);
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
    var tooltip = window.wdk.tooltips;
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
          })
          .on("mouseover", function(node) {
            highlightNodes(layout, ".nodes ." + this.id);
          })
          .on("mouseout", function(node) {
            resetNodes(layout, ".nodes ." + this.id);
          })
          .on("click", function(node) {
            showNodeDetail(layout, node);
          });
      
    // initialize edges      
    renderEdgesByType(layout);
    layout.find(".canvas .edge")
          .hover(function() { highlightEdges(layout, ".edges ." + this.id); },
                 function() { resetEdges(layout, ".edges ." + this.id); }
                );

    // provide handler to reset node detail
    layout.find(".canvas .background").click(function() { resetNodeDetail(layout); });
  }

  function initializeNodeDetail(layout) {
     var content = layout.find(".node-detail").find(".content");
     content.find(".gene-info")
            .accordion({ collapsible: true, })
            .hover(function() { 
                     var nodeId = layout.find(".node-detail .source-id").attr("id");
                     highlightNodes(layout, ".nodes .n" + nodeId); 
                   },
                   function() {
                     var nodeId = layout.find(".node-detail .source-id").attr("id");
                     resetNodes(layout, ".nodes .n" + nodeId); 
                   });
     content.find(".edge-info")
            .accordion({ collapsible: true,
                         activate: function(event, ui) {
                                     if (ui.newPanel.length == 0) return;
                                     if ($(this).data("loaded") == "yes") return;                                   
                                     showEdgeDetails(layout);
                                     $(this).data("loaded", "yes")
                                            .accordion("refresh");
                                   },
                       });
     content.find(".pfam-info")
            .accordion({ collapsible: true,
                        activate: function(event, ui) {
                                     if (ui.newPanel.length == 0) return;
                                     if ($(this).data("loaded") == "yes") return;
                                     showPFamDetails(layout);
                                     $(this).data("loaded", "yes")
                                            .accordion("refresh");
                                   },
                       });
     content.find(".ec-number-info")
            .accordion({ collapsible: true,
                         activate: function(event, ui) {
                                     if (ui.newPanel.length == 0) return;
                                     if ($(this).data("loaded") == "yes") return;
                                     showEcNumberDetails(layout);
                                     $(this).data("loaded", "yes")
                                            .accordion("refresh");
                                   },
                       });
  }

  function showNodeDetail(layout, node) {
    layout.find(".control-tabs").tabs({active: 1});
    var detail = layout.find(".node-detail");
    var nonContent = detail.find(".non-content");
    var content = detail.find(".content");

    var nodeId = content.find(".source-id").attr("id");
    if (nodeId == node.attr("id")) return; // node detail already loaded
    nodeId = node.attr("id");

    nonContent.hide();
    content.show("highlight");

    // fill in the gene info
    content.find(".source-id").attr("id", nodeId).html(node.data("source-id"));
    content.find(".length").html(node.data("length"));
    content.find(".description").html(node.html());

    var taxon = taxons[node.data("taxon")];
    content.find(".taxon-name").html(taxon.text());
    content.find(".taxon-id").html(taxon.attr("id"));

    content.find(".gene-info").accordion("refresh")

    // reset the content of lazy-loading sections
    content.find(".edge-info, .pfam-info, .ec-number-info")
           .accordion("option", "active", false)
           .data("loaded", "no")
           .find(".datatable").DataTable({ bDestroy : true, });
  }

  function showEdgeDetails(layout) {
    var nodeId = layout.find(".node-detail .source-id").attr("id");
    var node = nodes[nodeId];
    var content = layout.find(".node-detail .content");

    // fill in edge info
    var data = [];
    layout.find(".data .edge[data-query=" + nodeId + "]")
          .each(function() {
            data.push(convertEdgeToArray($(this), "subject"));
          });
    layout.find(".data .edge[data-subject=" + nodeId + "]")
          .each(function() {
            data.push(convertEdgeToArray($(this), "query"));
          });
// The 1.10 syntax is not supported yet
//    content.find(".blast-scores")
//           .DataTable().clear()
//                       .row.add(data)
//                       .draw();

// The 1.9 syntax is used now, but will be replace by 1.10 syntax after upgrading.
    content.find(".blast-scores")
           .DataTable({ bDestroy: true,
                        bJQueryUI: true,
                        aaData: data,
                        bPaginate: false,
                        "sScrollY": "200",
                        "bScrollCollapse": true,
                      });

    var nodeSelector = ".nodes .n" + node.attr("id");
    content.hover(function() { highlightNodes(layout, nodeSelector); },
                  function() { resetNodes(layout, nodeSelector); });
    content.find(".blast-scores tr")
           .each(function() {
             var edgeId = $(this).find(".subject").attr("id");
             $(this).hover(function() { 
                             $(this).addClass("highlight");
                             highlightEdges(layout, ".edges .e" + edgeId); 
                           },
                           function() { 
                             $(this).removeClass("highlight");
                             resetEdges(layout, ".edges .e" + edgeId); 
                           }
                     );
           });
  }

  function showEcNumberDetails(layout) {
    var nodeId = layout.find(".node-detail .source-id").attr("id");
    var node = nodes[nodeId];
    var content = layout.find(".node-detail .content");

    // fill in ec numbers
    var data = [];
    node.find(".ec-number").each(function() {
      var ecNumber = layout.find(".data .ec-numbers #" + this.id);
      data.push([ ecNumber.data("code") ]);
    });

    content.find(".ec-numbers")
           .DataTable({ bDestroy: true,
                        bJQueryUI: true,
                        aaData: data,
                        bPaginate: false,
                        "sScrollY": "200",
                        "bScrollCollapse": true,
                      });
  }

  function showPFamDetails(layout) {
    var nodeId = layout.find(".node-detail .source-id").attr("id");
    var node = nodes[nodeId];
    var content = layout.find(".node-detail .content");

    // fill in pfams
    var data = [];
    node.find(".pfam").each(function() {
      var proteinPFam = $(this);
      var pfam = layout.find(".data .pfams #" + this.id);
      data.push([ pfam.data("accession"), pfam.data("symbol"),
                  proteinPFam.data("start"), proteinPFam.data("end"), proteinPFam.data("length") ]);
    });

    content.find(".pfams")
           .DataTable({ bDestroy: true,
                        bJQueryUI: true,
                        aaData: data,
                        bPaginate: false,
                        "sScrollY": "200",
                        "bScrollCollapse": true,
                      });
  }

  function convertEdgeToArray(edge, subjectName) {
    var edgeId = edge.attr("id");
    var subjectId = edge.data(subjectName);
    var sourceId = nodes[subjectId].data("source-id");
    var subject = "<span id=\"" + edgeId + "\" class=\"subject\">" + sourceId + "</span>";

    var type = edge.data("type");    
    type = (type == "O") ? "Ortholog" : (type == "C") ? "Coortholog" : (type == "P") ? "Inparalog" : "Normal";

    return [ subject, type, edge.data("evalue") ];

  }

  function resetNodeDetail(layout) {
    var detail = layout.find(".node-detail");
    detail.find(".non-content").show();
    detail.find(".content").hide()    
                           .find(".source-id").attr("id", "");
  }

  function initializeNodeControls(layout) {
    // handle switch between different node controls
    var nodeControl = layout.find(".controls .node-control");
    nodeControl.find(".node-display")
               .change(function() {
                  if (this.value == "taxon") {
                    nodeControl.find(".taxon-control").show(); 
                    nodeControl.find(".ec-number-control").hide();
                    nodeControl.find(".pfam-control").hide();
                    renderNodesByTaxon(layout);
                  } else if (this.value == "ec-number") {
                    nodeControl.find(".taxon-control").hide(); 
                    nodeControl.find(".ec-number-control").show();
                    nodeControl.find(".pfam-control").hide();
                    renderNodesByEcNumber(layout);
                  } else {
                    nodeControl.find(".taxon-control").hide(); 
                    nodeControl.find(".ec-number-control").hide();
                    nodeControl.find(".pfam-control").show();
                    renderNodesByPfam(layout);
                  }
                });
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
  
  function renderNodesByTaxon(layout) {
    var canvas = layout.find(".canvas");
    canvas.find(".nodes").css("display", "block");
    canvas.find(".ec-numbers").css("display", "none");
    canvas.find(".pfams").css("display", "none");
  }
  
  function renderNodesByEcNumber(layout) {
    var canvas = layout.find(".canvas");
    canvas.find(".nodes").css("display", "none");
    canvas.find(".pfams").css("display", "none");
    canvas.find(".ec-numbers").css("display", "block");
    
    renderNodesAsPies(layout, ".ec-numbers", ".ec-number", "ec");
  }
  
  function renderNodesByPfam(layout) {
    var canvas = layout.find(".canvas");
    canvas.find(".nodes").css("display", "none");
    canvas.find(".ec-numbers").css("display", "none");
    canvas.find(".pfams").css("display", "block");
    
    renderNodesAsPies(layout, ".pfams", ".pfam", "pf");
  }

  
  function renderNodesAsPies(layout, groupSelector, nodeSelector, prefix) {
    var canvas = layout.find(".canvas");
    
    var items = layout.find(".data " + groupSelector + " " + nodeSelector);
    var arcSize = Math.PI / items.length;
    var arc = d3.svg.arc()
                     .innerRadius(0)
                     .outerRadius(6)
                     .startAngle(function(d, i) { return i * Math.PI * 2 / items.length; })
                     .endAngle(function(d, i) { return (i + 1) * Math.PI * 2 / items.length; });


    var nodes = d3.select(canvas.get(0))
                    .select(groupSelector).selectAll(nodeSelector)
                    .data(items)
                    .enter().append("svg:g")
                            .attr("class", nodeSelector.substring(1))
                            .attr("id", function(node) { return node.attr("id"); })
                            .attr("transform", function(node) { 
                              return "translate(" + node.data("x") + "," + node.data("y") + ")"; 
                            })
                            .on("mouseover", function(node) {
                              highlightNodes(layout, ".nodes .n" + this.id);
                            })
                            .on("mouseout", function(node) {
                              resetNodes(layout, ".nodes .n" + this.id);
                            })
                            .on("click", function(node) {
                              showNodeDetail(layout, node);
                            });

    nodes.each(function(node) {
      d3.select(this).selectAll("path")
        .data(items)
        .enter().append("svg:path")
                .attr("class", function(item) { return prefix + item.id; })
                .attr("fill", function(item) {
                  if (node.find("#" + item.id + nodeSelector).length > 0) {
                    return $(item).data("color");
                  } else {
                    return "white";
                  }                    
                })
                .attr("d", arc);
    });
  }
  
  function initializeEdgeControls(layout) {
    // handle switching between different edge controls
    var edgeControl = layout.find(".controls .edge-control");
    edgeControl.find(".edge-display").change(function() {
        edgeControl.find(".type-control").toggle("slide", { "direction": "up" });
        edgeControl.find(".score-control").toggle("slide", { "direction": "down" });
        if (this.value == "type") {
          renderEdgesByType(layout);
        } else {
          renderEdgesByScore(layout);
        }
    });
    
    // handle edge by type control
    edgeControl.find(".type-control .edge-type input")
               .change(function() {
                 renderEdgesByType(layout);
               });
    
    // handle edge by score control
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
  }

  function renderEdgesByType(layout) {
    // determine which type of edges will be displayed.
    var ortholog = false;
    var coortholog = false;
    var inparalog = false;
    var normal = false;
    layout.find(".controls .edge-control .edge-type input")
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
            if (type == "O") return "#FF6600";
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
      var visible = $(this).css("display");
      if (visible == "none") {
        $(this).css("display", "block");
        $(this).data("visible", "no");
      }

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
      var visible = $(this).data("visible");
      if (visible == "no") {
        $(this).css("display", "none");
        $(this).data("visible", "");
      }

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
