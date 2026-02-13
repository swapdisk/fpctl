$fn=180;
eps=0.01;

// Scale
sf=0.6;

// Chop bottom of stl
z_chop=24.00+eps;

// Center offset of stl
x_stl=42.00;

// Post dims
p_high=3.90;
p_xy=4.00;
p_rad=p_xy/2;
glue_high=1.20;
glue_rad=p_rad+0.90;

// Fill pin hole
pin_rad=8.502;
pin_high=28.000;

// Collar fitting
col_rad=7.40/2;
col_high=14;

// Shaft channel dim
shaft_rad=4.60/2;

// Flat bit
fb_deep=0.60;

// Debug
debug=false;

difference() {
    union () {
        translate([x_stl*sf, 0, -z_chop*sf]) scale([sf, sf, sf]) union() {
            import("flaps-assembly-ma60-20-pull-knob.stl");
        }
        translate([0, 0, -eps*sf]) cylinder(pin_high*sf, pin_rad*sf, pin_rad*sf);
    }
    
    // collar fitting
    translate ([0, 0, -eps]) cylinder(col_high, col_rad, col_rad);
    
    // shaft hole
    translate ([0, 0, -eps]) cylinder(99, shaft_rad, shaft_rad);
      
    // Debug
    if (debug) translate([0, 0, -49]) cube([99, 99, 99]);
}

// Flat bit
difference() {
    translate([-2.5, col_rad-fb_deep, 0]) cube([5, 1, col_high]);
    // Debug
    if (debug) translate([0, 0, -49]) cube([99, 99, 99]);
}
