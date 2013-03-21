function initializePfams() {
    var manager = new PfamManager();
    manager.initialize();
}


// use a seeded random function to make sure the color is always in the same random order
var seedobja = 1103515245; 
var seedobjc = 12345; 
var seedobjm = 4294967295; //0x100000000 

 
// Creates a new seed for seeded functions such as srandom(). 
function newseed(seednum) { 
    return [seednum];
}
 
// Works like Math.random(), except you provide your own seed as the first argument. 
function srandom(seedobj) 
{ 
    seedobj[0] = (seedobj[0] * seedobja + seedobjc) % seedobjm 
    return seedobj[0] / (seedobjm - 1) 
}

String.prototype.hash = function() {
    var value = 0;
    var i = 0;
    var shift = 0;
    for (i = 0; i < this.length; i++) {
        value ^= (this.charCodeAt(i) << shift);
        shift = (shift < 24) ? shift + 8 : 0;
    }
    return value;
}

Array.prototype.shuffle = function() {
    // get seed from group name
    var strSeed = $("#Record_Views #domains").attr("seed");
    var seed = strSeed.hash();
    var s = [];
    var my_seed_value = newseed(seed);
    while (this.length) s.push(this.splice(srandom(my_seed_value) * this.length, 1)[0]);
    while (s.length) this.push(s.pop());
    return this;
} 

function PfamManager() {
    
    this.initialize = function() {
        var manager = this;
        // the function generates 168 colors, and max domain # per group should be smaller than this.
        // if the domain # is bigger than that, should change the DIFF to 2
        var domains = manager.loadDomains();
        var domainCount = 0;
        for(var domain in domains) { domainCount++; }
        var colors = manager.generateColors(manager, 3);
        if (domainCount > colors.length)
            colors = manager.generateColors(manager, 2);
        manager.assignColors(domains, colors);
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

    this.loadDomains = function() {
        var domains = { };
        $("#Record_Views #domains .domain").each(function() {
            var name = $(this).attr("id");
            domains[name] = "";
        });
        return domains;
    };
        
    this.assignColors = function(domains, colors) {
        var index = 0;
        for (var domain in domains) {
          domains[domain] = colors[index];
          index++;
        }

        $("#Record_Views #domains .domain").each(function() {
            var name = $(this).attr("id");
            $(this).find(".legend").css(domains[name]);
            index++;
        });
    };

    this.loadProteins = function(domains) {
        var maxLength = parseInt($("#Record_Views #proteins").attr("maxlength"));
        $("#Record_Views #proteins .protein").each(function() {
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
