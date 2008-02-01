var taxons = { };
var categories = { };

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

    // get categories as the children of roots
    for (var i = 0; i < roots.length; i++) {
        var children = roots[i].children;
        for (var j = 0; j < children.length; j++) {
            var taxon = children[j];
            var key = taxon.abbrev;
            if (key != "BACT" && key != "ARCH" && key != "EUKA") key = "OTHER";
            
            var category = (key in categories) ? categories[key] : [];
            buildCategory(taxon, category, "");
            category.sort(compareTaxons);
            category.key = key;
            category.name = taxon.name;
            categories[key] = category;
        }
    }
}

function buildCategory(taxon, category, prefix) {
    if (taxon.is_species) {
        taxon.path = prefix;
        category.push(taxon);
    } else {
        if (prefix.length > 0) prefix += "->";
        prefix += taxon.abbrev;
        for (var i = 0; i < taxon.children.length; i++) {
            buildCategory(taxon.children[i], category, prefix);
        }
    }
}

function compareTaxons(a, b) {
    if(!(a.is_species ^ b.is_species)) return a.index - b.index;
    else if (a.is_species) return -1;
    else return 1;
}

function displayCategories(group) {
    var content = [];

    content.push("<tr>");
    
    // display the first row
    var key = "BACT";
    if (key in categories) {
        var category = categories[key];
        displayCategory(group, category, 0, category.length, content);
    }

    content.push("</tr><tr>");
   
    // display the first half of second row
    key = "ARCH";
    if (key in categories) {
        var category = categories[key];
        displayCategory(group, category, 0, category.length, content);
    }
   
    // display the second half of second row
    key = "EUKA";
    if (key in categories) {
        var category = categories[key];
        displayCategory(group, category, 0, 25, content);
    }

    content.push("<td></td></tr><tr>");
    
    // display the third row
    if (key in categories) {
        var category = categories[key];
        displayCategory(group, category, 25, category.length, content);
    }        

    content.push("</tr><tr>");
    
    // display the first row
    var key = "OTHER";
    if (key in categories) {
        var category = categories[key];
        displayCategory(group, category, 0, category.length, content);
    }

    content.push("<td></td><td></td></tr>");

    document.write(content.join(""));      
}

function displayCategory(group, category, from, to, content) {
    to = (category.length >= to) ? to : category.length;
    for (var i = from; i < to; i++) {
        var taxon = category[i];
        var count = (taxon.id in group) ? group[taxon.id] : 0;
        var style = "";
        if (count == 0) style = "color: black; background-color: white;";
        else if (count == 1) style = "color: white; background-color: gray;";
        else style = "color: white; background-color: black;";
        
        content.push("<td><div class=\"", category.key, "\" style=\"", style);
        content.push("\" title=\"", taxon.name, " (", taxon.abbrev, ") = ", count, " gene");
        if (count > 1) content.push("s");
        content.push(", ", category.name, ", ", taxon.path ,"\">");
        content.push(taxon.abbrev, "</div></td>");
    }
}
