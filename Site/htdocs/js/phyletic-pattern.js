$(document).ready(function() {

    document.groupManager = new GroupManager();
    document.groupManager.initialize();
});

function TreeNode(id, parentId, isLeaf, abbrev, index, name) {
    this.parent = null;
    this.id = id;
    this.parentId = parentId;
    this.isLeaf = isLeaf;
    this.index = index;
    this.name = name;
    this.abbrev = abbrev;
    this.children = new Array();
    
    this.getPath = function() {
        if (!("path" in this)) {
            if (this.parent == null) this.path = "";
            else {
                var parentPath = this.parent.getPath();
                if (parentPath != "") parentPath += "-&gt;";
                this.path = parentPath + this.abbrev;
            }
        }
        return this.path;
    };

    this.hasBranch = function() {
        if (this.isLeaf) return false;
        for (var i = 0; i < this.children.length; i++) {
            if (!this.children[i].isLeaf) return true;
        }
        return false;
    }
}

function GroupManager() {
    this.nodes = { };
    this.roots = new Array();

    this.initialize = function() {
        this.buildTree();
        this.createTreeLayout();
        this.createGroupLayout();
        this.fillInCounts();
        
        // register other events
        $("#showDetail").change(function() {
            var checked = $(this).attr("checked");
            if (checked) $("#groups .group .group-detail").show();
            else $("#groups .group .group-detail").hide();
        });
        $("#showPhyletic").change(function() {
            var checked = $(this).attr("checked");
            if (checked) {
                $("#groups .group .phyletic-pattern").show();
                $("#legend #taxon-legend").show();
            } else {
                $("#groups .group .phyletic-pattern").hide();
                $("#legend #taxon-legend").hide();
            }
        });
        $("#showCount").change(function() {
            var checked = $(this).attr("checked");
            $("#groups .group .phyletic-pattern .node").each(function() {
                if (checked) {
                    $(this).css("width", "25px");
                    $(this).css("height", "24px");
                    $(this).children(".name").show();
                    $(this).children(".count").children("span").show();
                } else {
                    $(this).css("width", "10px");
                    $(this).css("height", "10px");
                    $(this).children(".name").hide();
                    $(this).children(".count").children("span").hide();
                }
            });            
        });
    }

    this.buildTree = function() {
        var builder = this;

        $("#phyletic-data taxon").each(function() {
            var taxonId = $(this).attr("taxon-id");
            var parentId = $(this).attr("parent");
            var abbrev = $(this).attr("abbrev");
            var isLeaf = $(this).attr("leaf-node") == "1" ? true : false;
            var index = $(this).attr("index");
            var name = $(this).html();
            var node = new TreeNode(taxonId, parentId, isLeaf, abbrev, index, name);
            builder.nodes[taxonId] = node;
        });
        for(var taxonId in this.nodes) {
            var node = this.nodes[taxonId];
            if (node.parentId != null && node.parentId != "" && node.parentId != taxonId) {
                node.parent = this.nodes[node.parentId];
                node.parent.children.push(node);
            }
        }
        for (var taxonId in this.nodes) {
            var node = this.nodes[taxonId];
            if (node.parent == null) this.roots.push(node);
        }
    }

    this.createTreeLayout = function() {
        var stub = $("#legend #taxon-legend");
        for(var i = 0; i < this.roots.length; i++) {
            var root = this.roots[i];
            div = this.createTreeNode(root, 2);
            stub.append(div);
        }

        // register collapse events
        $("#legend #taxon-legend .node .handle").click(function() {
            var minus = $(this).attr("src").lastIndexOf("minus");
            if (minus >= 0) {
                $(this).attr("src", "images/plus.png");
                $(this).siblings(".children").hide();
            } else {
                $(this).attr("src", "images/minus.png");
                $(this).siblings(".children").show();
            }                
        });
        // register selection events
        $("#legend #taxon-legend .node .select").change(function() {
            // select branch
            var checked = $(this).attr("checked");
            $(this).siblings(".children").find(".select").each(function() {
                $(this).attr("checked", checked)
            });
            
            // show/hide the taxons
            var taxon = $(this).parent(".node").attr("taxon");
            $("#groups .group .phyletic-pattern .branch[taxon=\"" + taxon + "\"]").each(function() {
                if (checked) {
                    $(this).children(".node").hide();
                    $(this).children(".children").show();
                } else {
                    $(this).children(".node").show();
                    $(this).children(".children").hide();
                }
            });
        });
    }

    this.createTreeNode = function(node, level) {
        // the node are create for the internal ones; leaves are skipped.
        if (node.isLeaf) return "";
        
        var hidden = "";
        var div = "<div class=\"node\" taxon=\"" + node.abbrev + "\" title=\"" + node.abbrev + "\">";
        if (node.hasBranch()) {
            if (level > 1) { // expand the children
                div += "<img class=\"handle\" src=\"images/minus.png\">";
            } else { // collapse the children
                div += "<img class=\"handle\" src=\"images/plus.png\">";
                hidden = "style=\"display: none;\"";
            }
        } else {    // no branch under it
            div += "<img src=\"images/spacer.gif\" width=\"20\" height=\"20\">";
        }
        div += "<input class=\"select\" type=\"checkbox\" checked=\"yes\" />";
        div += node.name;
        div += "<div class=\"children\" " + hidden + ">"
        for(var i = 0; i < node.children.length; i++) {
            div += this.createTreeNode(node.children[i], level - 1);
        }
        div += "</div></div>";
        return div;
    }

    this.createGroupLayout = function() {
        var stub = $("#groups .group:first .phyletic-pattern");
        for(var i = 0; i < this.roots.length; i++) {
            var root = this.roots[i];
            div = this.createFlatNode(root);
            stub.append(div);
        }

        var index = 0;
        $("#groups .group .phyletic-pattern").each(function() {
            if (index++ == 0) return;
            $(this).append(stub.clone());
        });
        // register mouse over events
        $("#groups .group .phyletic-pattern .node").tooltip({ 
            showURL: false, 
            bodyHandler: function() { 
                return $(this).siblings(".description").html(); 
            } 
        });
    }

    this.createFlatNode = function(node) {
        var div = "";
        var hidden = "";
        if (!node.isLeaf) {
            div += "<div class=\"branch\" taxon=\"" + node.abbrev + "\">";
            hidden = "style=\"display: none;\"";
        }
        div += "<div class=\"node\" taxon=\"" + node.id + "\" " + hidden + ">";
        div += "<div class=\"name\">" + node.abbrev + "</div>";
        div += "<div class=\"count\"><span>0</span></div></div>";
        div += "<div class=\"description\">" + node.getPath() + "<br /><i>" + node.name + "</i></div>";
        div += "<div class=\"children\">"
        for(var i = 0; i < node.children.length; i++) {
            div += this.createFlatNode(node.children[i]);
        }
        div += "</div>";
        if (!node.isLeaf) div += "</div>";
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
            for (var taxonId in this.nodes) {
                var count = this.getCount(node, counts);
                $(this).find(".node[taxon=" + taxonId + "]").children(".count span").text(count);
            }
        });
    }
    
    this.getCount = function(node, counts) {
        if (node.isLeaf) return counts[node.taxonId];
        else {
            var count = 0;
            for (var i = 0; i < node.children.length; i++) {
                count += this.getCount(node.children[i], counts);
            }
            return count;
        }
    }
}
