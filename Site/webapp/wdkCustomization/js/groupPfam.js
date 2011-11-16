function initializePfams() {
    var manager = new PfamManager();
    manager.initialize();
}

Array.prototype.shuffle = function() {
    var s = [];
    while (this.length) s.push(this.splice(Math.random() * this.length, 1)[0]);
    while (s.length) this.push(s.pop());
    return this;
} 

function PfamManager() {
    
    this.initialize = function() {
        var manager = this;
        // the function generates 168 colors, and max domain # per group should be smaller than this.
        // if the domain # is bigger than that, should change the DIFF to 2
        var domainCount = parseInt($("#Record_View #domains").attr("count"));
        var colors = manager.generateColors(manager, 3);
        if (domainCount > colors.length)
            colors = manager.generateColors(manager, 2);
        var domains = manager.loadDomains(colors);
        manager.loadProteins(domains);
    }

    this.generateColors = function(manager, threshold) {
        // minimal distance between each color.
        var STEP = 100;
        // r, g, b cannot be all greater than UPPER; too bright
        var UPPER = 220;
        // the difference between the background and border, the bigger, the better.
        var DIFF = threshold;

        var colors = new Array();
        var r, g, b, br, bg, bb;
        for(r = 0; r <= 255; r += STEP) {
            for( g = 0; g <= 255; g += STEP) {
                for ( b = 0; b <= 255; b += STEP) {
                    if (r == 0 && g == 0 && b == 0) continue;
                    if (r > UPPER && g > UPPER && b > UPPER) continue;
                    for( br = 0; br <= 255; br += STEP) {
                        for( bg = 0; bg <= 255; bg += STEP) {
                            for ( bb = 0; bb <= 255; bb += STEP) {
                                if (br == 0 && bg == 0 && bb == 0) continue;
                                if (br > UPPER && bg > UPPER && bb > UPPER) continue;
                                if (br == bg && br == bb && br == 2 * STEP) continue;
                                var dr = Math.abs(r - br);
                                var db = Math.abs(b - bb);
                                var dg = Math.abs(g - bg);
                                if (dr + db + dg <= DIFF * STEP) continue;
                        
                                var color = {
                                    'background-color' : "#" + manager.hex(r) + manager.hex(g) + manager.hex(b),
                                    'border-color'     : "#" + manager.hex(br) + manager.hex(bg) + manager.hex(bb)
                                };
                                colors.push(color);
                            }
                        }
                    }
                }
            }
        }
        colors.shuffle();
        return colors;
    };

    this.hex = function(val) {
        var sval = val.toString(16);
        if (sval.length == 1) sval = '0' + sval;
        return sval;
    };
        
    this.loadDomains = function(colors) {
        var domains = new Array();
        var index = 0;
        $("#Record_View #domains .domain").each(function() {
            var name = $(this).attr("id");
            var color = colors[index];
            $(this).find(".legend").css(color);
            domains[name] = color;
            index++;
        });
        return domains;
    };

    this.loadProteins = function(domains) {
        var maxLength = parseInt($("#Record_View #proteins").attr("maxlength"));
        $("#Record_View #proteins .protein").each(function() {
            var length = parseInt($(this).find(".length").text());
            var width = (100.0 * length / maxLength).toString() + "%";
            $(this).find(".protein-graph").width(width);
            $(this).find(".domains .domain").each(function() {
                var name = $(this).attr("id");
                var start = parseInt($(this).attr("start"));
                var end = parseInt($(this).attr("end"));
                var color = domains[name];
                var dw = (100.0 * (end - start + 1) / maxLength).toString() + "%";
                var x = (100.0 * start / maxLength).toString() + "%";
                $(this).css("width", dw).css("left", x);
                $(this).children("div").css(color);
            });
        });
    }
};
