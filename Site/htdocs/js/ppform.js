var urls = new Array("dc.gif", "yes.gif", "no.gif", "maybe.gif", "unk.gif");
var taxons = { };
var roots = [];
var inLeaves;
var outLeaves;

function initial() {
    // resolve the children of each node
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        taxon.expanded = !taxons.is_species;
        if (taxon_id != taxon.parent_id) {
            var parent = taxons[taxon.parent_id];
            parent.children.push(taxon);
        } else { 
            roots.push(taxon); 
        }
    }
    roots.sort(compareTaxons);
    
    // sort children
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        taxon.children.sort(compareTaxons);
    }
    // load the saved status
    loadState();
}

function compareTaxons(a, b) {
    return a.index - b.index;
}

function displayNodes() {
    var content  = [];
    for(var i = 0; i < roots.length; i++) {
        displayNode(roots[i], content);
    }
    document.write(content.join(""));
}

function displayNode(node, content) {
    var hasChild = (node.children.length != 0);
    var foldImage = hasChild ? (node.expanded ? "minus.png" : "plus.png") : "spacer.gif";

    content.push("<div id='", node.id, "'>");
    content.push("<image id='", node.id + "_fold' width='20' height='20' ");
    content.push(" style=\"cursor:pointer;\" ");
    content.push(" src=\"images/" + foldImage + "\" ");
    content.push(" onclick=\"toggleFold('" + node.id + "')\" />");
    
    content.push("<image id='" + node.id + "_check' src='images/" + urls[node.state]);
    content.push("' onclick=\"toggleState('" + node.id + "')\" />");
    
    content.push("<span class='node-" + (hasChild ? "highlight" : "normal") + "'>");
    content.push(node.name + " (" + node.abbrev + ")</span>");
    
    content.push("</div>");
    if (hasChild) {
        var display = node.expanded ? "" : "display: none;";
        content.push("<div id='" + node.id + "_child' class='node-indent' ");
        content.push(" style=\"" + display + "\">");
        for(var i = 0, j = node.children.length; i < j; i++) {
            displayNode(node.children[i], content);
        }
        content.push("</div>");
    }
}

function toggleFold(nodeId) {
    var imgFold = document.getElementById(nodeId + "_fold");
    var divChild = document.getElementById(nodeId + "_child");
    var taxon = taxons[nodeId];
    taxon.expanded = !taxon.expanded;
    
    imgFold.src = "images/" + (taxon.expanded ? "minus.png" : "plus.png");
    divChild.style.display = (taxon.expanded ? "block" : "none");

    saveState();
}

function toggleState(nodeId) {
    var imgState = document.getElementById(nodeId + "_check");
   
    if (taxons[nodeId].children.length) {
        taxons[nodeId].state = (taxons[nodeId].state + 1) % 4;
        imgState.src = "images/" + urls[taxons[nodeId].state];

	for (var i = 0, j = taxons[nodeId].children.length; i < j; ++i) {
            if (taxons[nodeId].state < 3) {
                setState(taxons[nodeId].children[i].id, taxons[nodeId].state);
            }
            else {
                setState(taxons[nodeId].children[i].id, 0);
            }
        }
    }
    else {
        taxons[nodeId].state = (taxons[nodeId].state + 1) % 3;
        imgState.src = "images/" + urls[taxons[nodeId].state];
    }

    if (nodeId != taxons[nodeId].parent_id) {
        fixParent(nodeId);
    }
    calcText();
}

function setState(nodeId, nodeState) {
    var imgState = document.getElementById(nodeId + "_check");
   
    taxons[nodeId].state = nodeState;
    imgState.src = "images/" + urls[nodeState];
   
    if (taxons[nodeId].children.length) {
        for (var i = 0, j = taxons[nodeId].children.length; i < j; ++i) {
            setState(taxons[nodeId].children[i].id, nodeState);
        }
    }
}

function fixParent (nodeId) {
    var parentId = taxons[nodeId].parent_id;
    var parentImg = document.getElementById(parentId + "_check");
    
    taxons[parentId].state = 0;

    for (var i = 0, j = taxons[parentId].children.length; i < j; ++i) {
        if (taxons[nodeId].state != taxons[parentId].children[i].state) {
	    taxons[parentId].state = 4;
            parentImg.src = "images/" + urls[taxons[parentId].state];
            break;
        }
    }
    if (!taxons[parentId].state) {
        taxons[parentId].state = taxons[nodeId].state;
        parentImg.src = "images/" + urls[taxons[parentId].state];
    }
    if (parentId != taxons[parentId].parent_id) {
	fixParent(parentId);
    }
}

function calcText () {
    var query;
    var rootStrs = [];

    inLeaves = [];
    outLeaves = [];

    for (var i = 0, j = roots.length; i < j; ++i) {
         var rootText;
         if (rootText = nodeText(roots[i].id)) {
	     rootStrs.push(rootText);
         }
    }

    if (inLeaves.length) {
        rootStrs.push(inLeaves.join("+") + "=" + inLeaves.length + "T");
    }
    if (outLeaves.length) {
        rootStrs.push(outLeaves.join("+") + "=0T");
    }

    query = rootStrs.join(" AND ");

    document.getElementById("query").value = query;
}

function nodeText(nodeId) {
    var nodeStr;

    if (taxons[nodeId].children.length) {
    if (taxons[nodeId].state == 1) {
        nodeStr = taxons[nodeId].abbrev + "=" + countLeaves(nodeId) + "T";
    }
    else if (taxons[nodeId].state == 2) {
        nodeStr = taxons[nodeId].abbrev + "=0T"
    }
    else if (taxons[nodeId].state == 3) {
        nodeStr = taxons[nodeId].abbrev + ">=1T";
    }
    else if (taxons[nodeId].state == 4) {
	var childStrs = [];
        for (var i = 0, j = taxons[nodeId].children.length; i < j; ++i) {
            var resp = nodeText(taxons[nodeId].children[i].id);
            if (resp) {
                childStrs.push(resp);
            }
        }
        nodeStr = childStrs.join(" AND ");
    }
    }
    else {
        if (taxons[nodeId].state == 1) {
            inLeaves.push(taxons[nodeId].abbrev);
        }
        else if (taxons[nodeId].state == 2) {
            outLeaves.push(taxons[nodeId].abbrev);
        }
    }

    return nodeStr;
}

function countLeaves(nodeId) {
    var count = 0;
   
    if (!taxons[nodeId].children.length) {
        return 1;
    }

    for (var i = 0, j = taxons[nodeId].children.length; i < j; ++i) {
        count = count + countLeaves(taxons[nodeId].children[i].id);
    }

    return count;
}


function saveState() {
    var content = "";
    for(var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        if (!taxon.is_species && !taxon.expanded) {
            if (content.length > 0) content += "|";
            content += taxon.abbrev;
        }
    }

    document.cookie = "phyletic-tree=" + content + "; max-age=" + (60*60*24*365);
}

function loadState() {
    var allcookies = document.cookie;
    var key = "phyletic-tree=";
    var pos = allcookies.indexOf(key);
    if (pos >= 0) {
        pos += key.length;
        var end = allcookies.indexOf(";", pos);
        var content = (end >= 0) ? allcookies.substring(pos, end) 
                                 : allcookies.substring(pos);

        var collapsed = { };
        var parts = content.split("|");
        for (var i = 0; i < parts.length; i++) {
            collapsed[parts[i]] = true;
        }
        // update taxons
        for (var taxon_id in taxons) {
            var taxon = taxons[taxon_id];
            if (taxon.abbrev in collapsed) taxon.expanded = false;
        }
    }
}
