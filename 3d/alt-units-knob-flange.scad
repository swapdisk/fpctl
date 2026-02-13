$fn=180;
eps=0.01;

// Attachment
att_rad=6.90;
att_high=2.00;

// Flange
fl_rad=18.62/2;
fl_high=4.40;

// Alt units knob dims
auk_ir=11.20/2;

color("grey") difference() {
    union() {
        // attachment surface
        cylinder(att_high, att_rad, att_rad);
        // visual flange ring
        translate([0, 0, att_high]) cylinder(fl_high, fl_rad, fl_rad); 
    }
    // inner shaft
    translate([0, 0, -eps]) cylinder(99, auk_ir, auk_ir);
    // Knob attachment cavity hack
    translate([0, 0, att_high+fl_high-2]) cylinder(99, 7, 7);
    translate([0, 0, att_high+fl_high-4+eps]) cylinder(2, auk_ir, 7);

    // Pointer
    //translate([0, 0, att_high+fl_high]) rotate([90, 0, 0]) cylinder(99, .75, .75);
    linear_extrude(20) hull() {
        translate([0, fl_rad+1.1, 0]) circle(eps);
        translate([1, fl_rad-1.8, 0]) circle(eps);
        translate([-1, fl_rad-1.8, 0]) circle(eps);
    }

    // Debug
    //translate([0, 0, -49]) cube(99);
}

