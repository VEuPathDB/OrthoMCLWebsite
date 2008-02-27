var taxons = { };
var categories = [];

function initial() {
    var taxonMap = { };
    
    // resolve the children of each node
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        taxonMap[taxon.abbrev] = taxon;
        if (taxon_id != taxon.parent_id) {
            var parent = taxons[taxon.parent_id];
            parent.children.push(taxon);
        }
        // modify display names
        if (taxon.abbrev == "EUKA" || taxon.abbrev == "BACT") 
            taxon.name = "Other " + taxon.name;
            
        getPath(taxon);
    }

    // get categories as the children of roots
    makeCategories(taxonMap);
    
    // order the species in each category
    for (var row = 0; row < categories.length; row++) {
        for (var col = 0; col < categories[row].length; col++) {
            var category = categories[row][col];
            category.species.sort(compareTaxons);
        }
    }
}

function getPath(taxon) {
    if (!("path" in taxon)) {
        if (taxon.id == taxon.parent_id) taxon.path = "";
        else {
            var parentPath = getPath(taxons[taxon.parent_id]);
            if (parentPath != "") parentPath += "->";
            taxon.path = parentPath + taxon.abbrev;
        }
    }
    return taxon.path;
}

function makeCategories(taxonMap) {
    // the order of each key in the keys array is important, and the parent 
    // level is always after the children level in order to make correct groups
    var keys = [["FIRM", 0, 1], ["PROT", 0, 2], ["BACT", 0, 0],
                ["ARCH", 1, 0], 
                ["PLAL", 1, 2], ["KINE", 1, 3], ["ALVE", 1, 4],
                ["FUNG", 2, 0], ["META", 2, 1],
                ["EUKA", 1, 1]];
                
    // prepare category array
    for (var taxon_id in taxons) {
        var taxon = taxons[taxon_id];
        if (!taxon.is_species) continue;
        
        for (var i = 0; i < keys.length; i++) {
            var key = keys[i][0];
            var row = keys[i][1];
            var col = keys[i][2];
            
            var category;
            if (!categories[row] || !categories[row][col]) {
                category = { root: taxonMap[key],
                          species: [] };
                if (!categories[row]) categories[row] = [];
                categories[row][col] = category;
            } else category = categories[row][col];
            
            if (isAncestor(taxon, category.root)) {
                category.species.push(taxon);
                taxon.category = category;
                break;
            }
        }
    }
}

function isAncestor(taxon, ancestor) {
    while (taxon.id != taxon.parent_id) {
        var parent = taxons[taxon.parent_id];
        if (parent == ancestor) return true;
        taxon = parent;
    }
    return false;
}

function compareTaxons(a, b) {
    if(!(a.is_species ^ b.is_species)) return a.index - b.index;
    else if (a.is_species) return -1;
    else return 1;
}

function displayLegend() {
    var content = [];
    
    var index = 0;
    for (var row = 0; row < categories.length; row++) {
        for (var col = 0; col < categories[row].length; col++) {
            var category = categories[row][col];
            
            content.push("<td><div index=\"", index ,"\" count=\"0\" location='head-tail'");
            content.push(" style=\"width: 30px;\" ");
            content.push(" onmouseover=\"return escape(getLegendDetail(", category.root.id, "));\">");
            content.push(category.root.abbrev, "</div></td>");
            
            index++;
        }
    }

    document.write(content.join(""));      
}

function getLegendDetail(taxon_id) {
    var taxon = taxons[taxon_id];
    var content = [];
    content.push("<i>", taxon.name, "</i> (", taxon.abbrev, "), ", taxon.path);
    return content.join("");
}

function displayCategories(group) {
    var content = [];

    var index = 0;
    for (var row = 0; row < categories.length; row++) {
        content.push("<tr>");
        if (row == 2) content.push("<td></td><td></td>");
        for (var col = 0; col < categories[row].length; col++) {
            if (row == 1 && col == 1) content.push("<td></td>");
            displayCategory(content, group, categories[row][col], index++);
        }
        content.push("</tr>");
    }

    document.write(content.join(""));      
}

function displayCategory(content, group, category, index) {
    for(var i = 0; i < category.species.length; i++) {
        var taxon = category.species[i];
        var count = (taxon.id in group) ? group[taxon.id] : 0;
        var position = "";
        if (i == 0 && i == category.species.length - 1) position = "head-tail";
        else if (i == 0) position = "head";
        else if (i == category.species.length - 1) position = "tail";
        
        content.push("<td>");
        
        content.push("<div class='species' index='", index ,"' ");
        if (position != "") content.push(" location='", position ,"' ");
        content.push(" count='", ((count > 1) ? "many" : count) ,"' ");
        content.push(" onmouseover=\"return escape(getTaxonDetail(", taxon.id, ", ", count, "));\">");
        content.push(taxon.abbrev, "</div></td>");
    }
}

function getTaxonDetail(taxon_id, count) {
    var taxon = taxons[taxon_id];
    var content = [];
    content.push("<i>", taxon.name, "</i> (", taxon.abbrev, ") = ", count, " gene");
    if (count > 1) content.push("s");
    content.push(", ", taxon.category.root.name, ", ", taxon.path);
    return content.join("");
}
