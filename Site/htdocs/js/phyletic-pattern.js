var taxons = { };
var categories = [];
var groups = { };

function initial() {
    var roots = [];
    // resolve the children of each node
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        if (taxon_id != taxon.parent_id) {
            var parent = taxons[taxon.parent_id];
            parent.children.push(taxon);
        } else {
            roots.push(taxon);
        }
    }
    // get species count
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        taxon.species_count = countSpecies(taxon);
    }
    // get categories as the children of roots
    for (var i = 0; i < roots.length; i++) {
        for (var j = 0; j < roots[i].children.length; j++) {
            categories.push(roots[i].children[j]);
        }
    }
    // load the saved status
    loadState();
}

function countSpecies(taxon) {
    if (taxon.is_species == 1) return 1;
    var count = 0;
    for (var i = 0; i < taxon.children.length; i++) {
        count += countSpecies(taxon.children[i]);
    }
    return count;
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
    for(var i = 0; i < categories.length; i++) {
        document.writeln("<tr><td width=\"10\" nowrap>" + categories[i].name + "</td>");
        document.writeln("<td class=\"phyletic-category\"><span>");
        displayCategory(group, categories[i]);
        document.writeln("</span></td></tr>");
    }
}

function displayCategory(group, taxon) {
    var className;
    if (group.counts[taxon.id].gene_count == 0) className = "zero";
    else if (group.counts[taxon.id].gene_count == 1) className = "one";
    else if (group.counts[taxon.id].gene_count == 2) className = "two";
    else className = "more";
    
    document.write("<div class=\"" + className + "\" ");
    document.write(" title=\"" + taxon.name + "\" ");
    if (taxon.is_species == 1) {    // display species
        document.writeln(" >" + taxon.abbrev + "<br/>");
        document.writeln(group.counts[taxon.id].gene_count);
        document.writeln("</div>");
    } else {    // display clade
        var infoDisplay = taxon.expanded ? "none" : "block";
        document.write(" id=\"" + group.name + "_" + taxon.id + "_info\" ");
        document.write(" style=\"display: "+ infoDisplay +"; cursor: pointer;\" ");
        document.writeln(" onclick=\"toggleTaxon('" + taxon.id + "')\" >");
        document.writeln(taxon.abbrev + "<br/>");
        document.write(group.counts[taxon.id].species_count + "/");
        document.writeln(taxon.species_count + "<br/>");
        document.writeln(group.counts[taxon.id].gene_count);
        document.writeln("</div>");
        
        document.write("<table id=\"" + group.name + "_" + taxon.id + "_child\" ");
        if (!taxon.expanded) document.write(" style=\"display: none\" ");
        document.writeln(" ><tr><td>");
        document.write("<img src=\"images/minus.png\" ");
        document.write(" style=\"cursor: pointer\" ");
        document.write(" title=\"" + taxon.name + "\" ");
        document.writeln(" onclick=\"toggleTaxon('" + taxon.id + "')\" />");
        document.writeln("</td>");
        for (var i = 0; i < taxon.children.length; i++) {
            document.writeln("<td>")
            displayCategory(group, taxon.children[i]);
            document.writeln("</td>")
        }
        document.writeln("</td></tr></table>");
    }
}

function toggleTaxon(taxon_id) {
    var taxon = taxons[taxon_id];
    for (var groupName in groups) {
        var taxonInfo = document.getElementById(groupName + "_" + taxon_id + "_info");
        var taxonChild = document.getElementById(groupName + "_" + taxon_id + "_child");
        taxonInfo.style.display = taxon.expanded ? "block" : "none";
        taxonChild.style.display = taxon.expanded ? "none" : "block";
    }
    taxon.expanded = !taxon.expanded;
    saveState();
}

function saveState() {
    var content = "";
    for(var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        if (!taxon.expanded) {
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
