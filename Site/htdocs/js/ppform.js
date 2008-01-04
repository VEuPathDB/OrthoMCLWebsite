function displayNode(node) {
    var hasChild = (node.children.length != 0);
    document.writeln("<div id='" + node.id + "'>");
    
    document.write("<image id='" + node.id + "_fold' width='20' height='20'");
    document.write(" src='images/" + (hasChild ? "minus.png'" : "spacer.gif'"));
    document.writeln(" onclick=\"toggleFold('" + node.id + "')\" />");
    
    document.writeln("<image id='" + node.id + "_check' src='images/" + urls[node.state] + "'");
    document.writeln(" onclick=\"toggleState('" + node.id + "')\" />");
    
    document.writeln("<span class='node-" + (hasChild ? "highlight" : "normal") + "'>");
    document.writeln(node.name + " (" + node.abbrev + ")</span>");
    
    document.writeln("</div>");
    if (hasChild) {
        document.writeln("<div id='" + node.id + "_child' class='node-indent'>");
        for(var i = 0, j = node.children.length; i < j; i++) {
            displayNode(node.children[i]);
        }
        document.writeln("</div>");
    }
}

function toggleFold(nodeId) {
    var imgFold = document.getElementById(nodeId + "_fold");
    var divChild = document.getElementById(nodeId + "_child");
    var isFolded = (divChild.style.display == "none");
    imgFold.src = "images/" + (isFolded ? "minus.png" : "plus.png");
    divChild.style.display = (isFolded ? "block" : "none");
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

    for (var i = 0, j = roots.length; i < j; ++i) {
	 rootStrs.push(nodeText(roots[i].id));
    }

    query = rootStrs.join(" AND ");

    document.getElementById("query").value = query;
}

function nodeText(nodeId) {
    var nodeStr;

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

    return nodeStr;
}

function countLeaves(nodeId) {
    var count = 0;
    var node = taxons[nodeId];

    if (!taxons[nodeId].children.length) {
        return 1;
    }

    for (var i = 0, j = taxons[nodeId].children.length; i < j; ++i) {
        count = count + countLeaves(taxons[nodeId].children[i].id);
    }

    return count;
}