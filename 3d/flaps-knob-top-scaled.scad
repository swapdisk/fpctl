$fn=180;
eps=0.01;

// Scale
sf=0.6;

// Chop bottom of stl
z_chop=73.00+eps;

// Center offset of stl
x_stl=42.00;

// Post dims
p_high=7.00*sf+eps;
p_xy=4.00;
p_rad=p_xy/2;
glue_high=1.20;
glue_rad=p_rad+0.90;

translate([0, 0, -5]) difference() {
    translate([x_stl*sf, 0, -z_chop*sf]) scale([sf, sf, sf]) {
        import("flaps-assembly-ma60-21-top-knob.stl");
    }
    translate([-99, -99, -99]) cube([199, 199, 99]);
    translate([0, 0, -eps]) {
        cylinder(p_high, p_rad, p_rad);
        cylinder(glue_high, glue_rad, p_rad);
    }
    
    // Debug
    //translate([0, 0, -eps]) cube([99, 99, 99]);
}