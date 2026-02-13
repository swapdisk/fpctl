$fn=180;
eps=0.01;

// Attachment
att_rad=6.90;
att_high=2.00;

// Alt units knob dims
auk_ir=11.20/2;
auk_ring_high=11;
auk_ring_or=16.62/2;
tex_rad=1.5/2;
tex_num=24;

color("grey") difference() {
    union() {
        // attachment surface
        cylinder(att_high, att_rad, att_rad);
        // base knob ring
        translate([0, 0, att_high]) cylinder(auk_ring_high, auk_ring_or, auk_ring_or); 
    }
    // inner shaft
    translate([0, 0, -eps]) cylinder(99, auk_ir, auk_ir);
    // Knob texture
    for (t=[0:360/tex_num:360]) {
        rotate([0, 0, t]) translate([auk_ring_or, 0, att_high-eps])  
            cylinder(99, tex_rad, tex_rad);                
    }

    // Debug
    //translate([0, 0, -49]) cube(99);
}

// Debug attachment
//translate([0, 0, -4.4]) {
//    include<alt-units-knob-flange.scad>;
//}