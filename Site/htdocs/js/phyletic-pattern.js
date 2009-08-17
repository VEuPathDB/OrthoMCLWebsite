$(document).ready(function() {
    GroupDisplay display = new GroupDisplay();
    display.buildTree();
    display.createLayout();
    display.fillCounts();
});

function TreeNode(id, parentId, isLeaf, abbrev, index, name) {
    var this.parent == null;
    var this.id = id;
    var this.parentId = parentId;
    var this.isLeaf = isLeaf;
    var this.index = index;
    var this.name = name;
    var this.children = new Array();
    
    this.getPath = function() {
        if (!("path" in this)) {
            if (this.id == this.parentId) this.path = "";
            else {
                var parentPath = parent.getPath();
                if (parentPath != "") parentPath += "->";
                this.path = parentPath + this.abbrev;
            }
        }
        return this.path;
    };
}

function GroupDisplay() {
    var nodes = { };
    var roots = new Array();

    this.buildTree = function() {
        $("#phyletic-data taxon").each(function() {
            var taxonId = $(this).attr("taxon-id");
            var parentId = $(this).attr("parent");
            var abbrev = $(this).attr("abbrev");
            var isLeaf = $(this).attr("leaf-node") == "1" ? true : false;
            var index = $(this).attr("index");
            var name = $(this).html();
            var node = new TreeNode(taxonId, parentId, isLeaf, abbrev, index, name);
            this.nodes[taxonId] = node;
        });
        for(var taxonId in this.nodes) {
            var node = this.nodes[taxonId];
            node.parent = this.nodes[node.parentId];
            node.parent.children.push(node);
        }
        for (var taxonId in this.nodes) {
            var node = this.nodes[taxonId];
            if (node.parent == null) this.roots.push(node);
        }
    }

    this.createLayout = function() {
        var stub = $("#groups .group:first .phyletic-pattern");
        for(var root in this.roots) [
            var div = this.createNode(root);
            stub.append(div);
        }
        var index = 0;
        $("#groups .group .phyletic-pattern").each(function() {
            if (index++ == 0) return;
            $(this).append(stub.clone());
        });
        // register collapse events
        $("#groups .group .phyletic-pattern .branch .handle").each(function() {
            var parent = $(this).parent();
            parent.children(".node:first").toggle();
            parent.children(".children").toggle();
            var img = $(this).attr("src");
            img = (img.lastIndexOf("plus") > 0) ? "minus" : "plus";
            $(this).attr("src", "images/" + img + ".gif");
        }
    }
    
    this.createNode = function(node) {
        var div = "";
        if (!node.isLeaf) {
            div += "<div class=\"branch\">";
            div += "<img class=\"handle\" src="images/plus.gif\" />";
        }
        div += "<div class=\"node\" taxon=\"" + node.taxonId + "\">";
        div += "<span class=\"abbrev\">" + node.abbrev + "<span><br />";
        div += "<span class=\"count\"></span>";
        if (!node.isLeaf) {
            div += "<div class=\"children\">"
            for(var child in node.children) {
                div += this.createNode(child);
            }
            div += "</div></div>";
        }
        return div;
    }
    
    this.fillInCounts = function() {
        $("#groups .group .phyletic-pattern").each(function () {
            var counts = { };
            $(this).find(".count-data group").each(function () {
                var taxonId = $(this).attr("taxon-id");
                var count = $(this).attr("count");
                counts[taxonId] = count;
            });
            for (var taxonId in nodes) {
                var count = this.getCount(node, counts);
                $(this).find(".node[taxon=" + taxonId + "]").text(count);
            }
        });
    }
    
    this.getCount = function(node, counts) {
        if (node.isLeaf) return counts[node.taxonId];
        else {
            var count = 0;
            for (var child in node.children) {
                count += this.getCount(child, counts);
            }
            return count;
        }
    }
}