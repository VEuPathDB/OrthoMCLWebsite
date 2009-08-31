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
    };

    this.getCount = function(counts) {
        var count = counts[this.id];
        if (typeof(count) != 'undefined') return count;
        if (this.isLeaf) return 0;
        count = 0;
        for(var i = 0; i < this.children.length; i++) {
            count += this.children[i].getCount(counts);
        }
        return count;
    };
}

function GroupManager() {
    this.nodes = { };
    this.roots = new Array();

    this.initialize = function() {
        this.buildTree();
        this.createTreeLayout();
        this.createGroupLayout();
        
        $("#taxon-tree #container").draggable();
        
        // register other events
        $("#showDetail").click(function() {
            var checked = $(this).attr("checked");
            if (checked) $("#groups .group .group-detail").show();
            else $("#groups .group .group-detail").hide();
        });
        $("#showPhyletic").click(function() {
            var checked = $(this).attr("checked");
            if (checked) {
                $("#groups .group .phyletic-pattern").show();
                $("#taxon-tree").show();
            } else {
                $("#groups .group .phyletic-pattern").hide();
                $("#taxon-tree").hide();
            }
        });
        $("#showCount").click(function() {
            var checked = $(this).attr("checked");
            $("#groups .group .phyletic-pattern .node").each(function() {
                var node = $(this);
                if (checked) {
                    node.css("width", "26px");
                    node.css("height", "26px");
                    node.children(".name").show();
                    node.children(".count").children("span").show();
                } else {
                    node.css("width", "10px");
                    node.css("height", "14px");
                    node.children(".name").hide();
                    node.children(".count").children("span").hide();
                }
            });            
        });
        $("#taxon-tree #tree-handle").click(function() {
            var open = $(this).val();
            if (open == '0') {
                $(this).val('1');
                $(this).text("Hide taxon tree");
                $("#taxon-tree #container").show();
            } else {
                $(this).val('0');
                $(this).text("Show taxon tree");
                $("#taxon-tree #container").hide();
            }
        });
        $("#taxon-tree #container #close-handle").click(function() {
            $("#taxon-tree #container").hide();
            $("#taxon-tree #tree-handle").val('0');
            $("#taxon-tree #tree-handle").text("Show taxon tree");
        });
    }

    this.buildTree = function() {
        var builder = this;

        $("#taxon-tree #tree-data .taxon").each(function() {
            var taxon= $(this);
            var taxonId = taxon.attr("taxon-id");
            var parentId = taxon.attr("parent");
            var abbrev = taxon.attr("abbrev");
            var isLeaf = taxon.attr("leaf-node") == "1" ? true : false;
            var index = taxon.attr("index");
            var name = taxon.html();
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
        var stub = $("#taxon-tree #tree-display");
        for(var i = 0; i < this.roots.length; i++) {
            var root = this.roots[i];
            div = this.createTreeNode(root);
            stub.append(div);
        }

        // register collapse events
        stub.find(".node .handle").click(function() {
            // collapse branch, and boxes
            var minus = $(this).attr("src").lastIndexOf("minus");
            var taxon = $(this).parent(".node").attr("taxon");
            if (minus >= 0) {
                $(this).attr("src", "images/plus.png");
                $(this).siblings(".children").hide();
            } else {
                $(this).attr("src", "images/minus.png");
                $(this).siblings(".children").show();
            }                
            $("#groups .group .phyletic-pattern .branch[taxon=\"" + taxon + "\"]").each(function() {
                if (minus >= 0) {
                    $(this).children(".node").show();
                    $(this).children(".children").hide();
                } else {
                    $(this).children(".node").hide();
                    $(this).children(".children").show();
                }
            });

        });

        // register selection events
        stub.find(".node .select").click(function() {
            // select branch
            var checked = $(this).attr("checked");
            $(this).siblings(".children").find(".select").each(function() {
                $(this).attr("checked", checked)
            });
            
            // show/hide the taxons
            var taxon = $(this).parent(".node").attr("taxon");
            $("#groups .group .phyletic-pattern .branch[taxon=\"" + taxon + "\"]").each(function() {
                if (checked) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });
    }

    this.createTreeNode = function(node) {
        // the node are create for the internal ones; leaves are skipped.
        if (node.isLeaf) return "";
        
        var div = "<div class=\"node\" taxon=\"" + node.abbrev + "\" title=\"" + node.abbrev + "\">";
        if (node.hasBranch()) {
            div += "<img class=\"handle\" src=\"images/minus.png\">";
        } else {    // no branch under it
            div += "<img src=\"images/spacer.gif\" width=\"20\" height=\"20\">";
        }
        div += "<input class=\"select\" type=\"checkbox\" checked=\"yes\" />";
        div += "<span class=\"name\">" + node.name + "</span>";
        div += "<div class=\"children\">"
        for(var i = 0; i < node.children.length; i++) {
            div += this.createTreeNode(node.children[i]);
        }
        div += "</div></div>";
        return div;
    }

    this.createGroupLayout = function() {
        var manager = this;
        $("#groups .group").each(function() {
            var groupId = $(this).attr("id");
            var counts = manager.getCounts(groupId);
            $(this).find(".phyletic-pattern").each(function() {
                for(var i = 0; i < manager.roots.length; i++) {
                    var root = manager.roots[i];
                    div = manager.createFlatNode(root, counts);
                    this.innerHTML = div;
                }
            });
        });

        // register mouse over events
        $("#groups .group .phyletic-pattern .node").tooltip({ 
            showURL: false, 
            bodyHandler: function() { 
                return $(this).children(".description").html(); 
            } 
        });
    }

    this.createFlatNode = function(node, counts) {
        var div = "";
        var style = "";
        if (!node.isLeaf) {
            div += "<div class=\"branch\" taxon=\"" + node.abbrev + "\">";
            style = "style=\"display: none;\"";
        }
        var count = node.getCount(counts);
        div += "<div class=\"node\" taxon=\"" + node.id + "\" " + style + " count=\"" + count + "\">";
        div += "  <div class=\"name\">" + node.abbrev + "</div>";
        div += "  <div class=\"count\"><span>" + count + "</span></div>";
        div += "  <div class=\"description\">" + node.getPath() + "<br /><i>" + node.name + "</i></div>";
        div += "</div>";
        
        if (!node.isLeaf) {
            div += "<div class=\"children\">"
            for(var i = 0; i < node.children.length; i++) {
                div += this.createFlatNode(node.children[i], counts);
            }
            div += "</div></div>";
        }
        return div;
    }

    this.getCounts = function(groupId) {
        var counts = { };
        $("#groups #" + groupId).find(".count-data .count").each(function () {
            var group = $(this);
            var taxonId = group.attr("taxon-id");
            var count = group.html();
            counts[taxonId] = Number(count);
        });
        return counts; 
    }
}
