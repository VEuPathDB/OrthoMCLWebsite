var taxons = { };
var categories = [];
var groups = { };

function initial() {
    var roots = [];
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
    
    // sort children
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        taxon.children.sort(compareTaxons);
    }
    
    // get species count
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        countSpecies(taxon);
    }

    // count the depth, from leaf, of each node
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        countDepths(taxon);
    }

    // get categories as the children of roots
    for (var i = 0; i < roots.length; i++) {
        for (var j = 0; j < roots[i].children.length; j++) {
            categories.push(roots[i].children[j]);
        }
    }
    categories.sort(compareTaxons);
    // load the saved status
    loadState();
}

function compareTaxons(a, b) {
    return a.index - b.index;
}

function countSpecies(taxon) {
    if (!("species_count" in taxon)) {
        if (taxon.is_species) {
            taxon.species_count = 1;
        } else {
            taxon.species_count = 0;
            for (var i = 0; i < taxon.children.length; i++) {
                taxon.species_count += countSpecies(taxon.children[i]);
            }
        }
    }
    return taxon.species_count;
}

function countDepths(taxon) {
    if (!("depth" in taxon)) {
        if (taxon.is_species) {
            taxon.depth = 0;
        } else {
            var maxDepth = 0;
            for (var i = 0; i < taxon.children.length; i++) {
                var depth = countDepths(taxon.children[i]);
                if (depth > maxDepth) { maxDepth = depth; }
            }
            taxon.depth = maxDepth + 1;
        }
    }
    return taxon.depth;
}

function updateGroup(group) {
    for (var taxon_id in taxons) {
        if (!(taxon_id in group.counts)) {
            countGroup(group, taxons[taxon_id]);
        }
    }
}

function countGroup(group, taxon) {
    var count = {gene_count: 0,
                 species_count: 0};
    if (taxon.id in group.counts) {  // taxon already counted
        count = group.counts[taxon.id];
    } else {
        if (!taxon.is_species) { // clade not counted yet
            for (var i = 0; i < taxon.children.length; i++) {
                var child_count = countGroup(group, taxon.children[i]);
                count.gene_count += child_count.gene_count;
                count.species_count += child_count.species_count;
            }
        } // otherwise, species not included, use default 0, 0
        group.counts[taxon.id] = count;
    }
    return count;
}

function displayCategories(group) {
    var content = [];
    for(var i = 0; i < categories.length; i++) {
        content.push("<tr><td width=\"10\">", categories[i].name, "</td>");
        content.push("<td class=\"phyletic-category\">");
        content.push("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr>");
        displayCategory(group, categories[i], false, content);
        content.push("</tr></table></td></tr>");
    }
    document.write(content.join(""));
}

function displayCategory(group, taxon, isHide, content) {
    var geneCount = group.counts[taxon.id].gene_count;
    var idPrefix = group.name + "_" + taxon.id;
    var className;
    if (geneCount == 0) className = "zero";
    else if (geneCount == 1) className = "one";
    else if (geneCount == 2) className = "two";
    else className = "more";
    
    content.push("<td id=\"", idPrefix, "_info\" style=\"");
    if (taxon.is_species) {    // display species
        var display = isHide ? "display:none" : "";
        var tooltip = [];
        tooltip.push("[", taxon.name, "] ", geneCount, " genes in the group.");
        
        content.push(display, "\"><div class=\"", className);
        content.push("\" title=\"", tooltip.join(""), "\" >");
        content.push(taxon.abbrev, "<br/>");
        content.push(geneCount);
        content.push("</div></td>");
    } else {    // display clade
        var display = (isHide | !taxon.expanded) ? "display:none" : "";
        var speciesCount = group.counts[taxon.id].species_count;
        var fontSize = taxon.depth / 3 + 1;

        var tooltipArray = [];
        tooltipArray.push("[", taxon.name, "] "  , speciesCount, "/");
        tooltipArray.push(taxon.species_count, " species, ");
        tooltipArray.push(geneCount, " genes in the group.");
        var tooltip = tooltipArray.join("");
        
        // output clade info section
        content.push((isHide | taxon.expanded) ? "display:none" : "");
        content.push("\"><div class=\"", className, "\" title=\"");
        content.push(tooltip, " Click to show the branch.\" ");
        content.push(" style=\"cursor: pointer;\" ");
        content.push(" onclick=\"toggleTaxon('", taxon.id, "')\" >");
        content.push(taxon.abbrev, "<br/>");
        content.push(speciesCount, "/", taxon.species_count, "<br/>");
        content.push(geneCount);
        content.push("</div></td>");
        
        // output collapse handle
        content.push("<td id=\"", idPrefix, "_handle\" style=\"", display);
        content.push("\"><img src=\"images/minus.png\" style=\"cursor: pointer;\"");
        content.push(" title=\"", tooltip, " Click to hide this branch.\" ");
        content.push(" onclick=\"toggleTaxon('", taxon.id, "')\" /></td>");
        
        // output clade open bracket
        content.push("<td id=\"", idPrefix);
        content.push("_open\" class=\"closure\" style=\"font-size:");
        content.push(fontSize, "em; ", display, "\">{</td>");
        
        // output children
        for (var i = 0; i < taxon.children.length; i++) {
            displayCategory(group, taxon.children[i], !taxon.expanded, content);
        }
        
        // output close bracket
        content.push("<td id=\"", idPrefix);
        content.push("_close\" class=\"closure\" style=\"font-size:");
        content.push(fontSize, "em; ", display, "\">}</td>");
        return content;
    }
}

function toggleTaxon(taxon_id) {
    var cursor = document.body.style.cursor;
    document.body.style.cursor = "wait";
    
    var taxon = taxons[taxon_id];
    taxon.expanded = !taxon.expanded;
    
    showHide(taxon, false);
    saveState();
    
    document.body.style.cursor = cursor;
}

function showHide(taxon, isHide) {
    for (var groupName in groups) {
        var idPrefix = groupName + "_" + taxon.id;

        var tdInfo = document.getElementById(idPrefix + "_info");
        if (taxon.is_species) {
            tdInfo.style.display = isHide ? "none" : "table-cell";;
        } else {
            tdInfo.style.display = (isHide | taxon.expanded) ? "none" : "table-cell";
        }

        var display = (isHide | !taxon.expanded) ? "none" : "table-cell";

        var tdHandle = document.getElementById(idPrefix + "_handle")
        if (tdHandle) tdHandle.style.display = display;

        var tdOpen = document.getElementById(idPrefix + "_open")
        if (tdOpen) tdOpen.style.display = display;

        var tdClose = document.getElementById(idPrefix + "_close")
        if (tdClose) tdClose.style.display = display;
    }

    for (var i = 0; i < taxon.children.length; i++) {
        showHide(taxon.children[i], !taxon.expanded);
    }
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
    document.cookie = "phyletic-pattern=" + content + "; max-age=" + (60*60*24*364);
}

function loadState() {
    var allcookies = document.cookie;
    var pos = allcookies.indexOf("phyletic-pattern=");
    if (pos >= 0) {
        pos += 17;
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
