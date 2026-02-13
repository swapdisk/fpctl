$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;
p815_thrd=3.70/2;
p815_hole=4.10/2;
p815_head=11.20/2;
p815_deep=13.50;

// wall dims
wall_high=52;
wall_wide=142;
wall_thick=4.0;
wall_bev=(sqrt(wall_thick*wall_thick*2));

// bottom plate dims
bp_wide=18;
bp_thick=4.0;
bp_head_deep=2.0;
bp_holes=[25, wall_wide/2, wall_wide-15];

// top plate dims
tp_wide=33.2;
tp_thick=3.0;
tp_from_right=64.0;
tp_from_top=2.7;
tp_holes=[73.70, 139.15];

// hinge pin holder
hph_wide=30.0;
hph_thick=10.8;
hph_from_right=wall_thick+1.5+32+0.5;
hph_from_top=8.1;
hph_from_front=11.5;
hph_pin_ir=4.20/2;

difference() {
    union() {
        // wall base
        cube([wall_wide, wall_high, wall_thick]);
        
        // bottom plate
        translate([wall_thick, 0, 0]) rotate([20, 0, 0]) cube([wall_wide-wall_thick, bp_thick, bp_wide]);

        // top plate
        translate([wall_thick+tp_from_right, wall_high-tp_thick-tp_from_top, 0]) 
            cube([wall_wide-wall_thick-tp_from_right, tp_thick, tp_wide]);
        translate([wall_thick+0.2, wall_high-tp_thick-tp_from_top, 0]) 
            cube([wall_wide-wall_thick-0.2, tp_thick, wall_thick+2]);
        
        // hinge pin holder
        translate([hph_from_right, wall_high-hph_from_top-hph_thick/2, 0])
            cube([hph_wide, hph_thick, hph_from_front+hph_thick/2]);
    }
    
    // bevel corners
    translate([0, -eps, wall_thick]) rotate([270, 0, 0]) cylinder(99, wall_thick, wall_thick, $fn=4);
    translate([0, -eps, 0]) rotate([290, 0, 0]) 
        translate([-eps, -bp_wide, 0]) cylinder(bp_thick+eps*2, bp_wide, bp_wide, $fn=4);
    //translate([wall_thick, wall_high-tp_thick-tp_from_top-eps, wall_thick+6]) rotate([270, 0, 0])
    //    cylinder(tp_thick+eps*2, 6, 6, $fn=4);

    // bottom plate holes
    for (h=bp_holes) {
        translate([h, eps, 0]) rotate([110, 0, 0]) {
            // screw hole and head
            translate([0, bp_wide/2+wall_thick/2, -bp_thick]) 
                cylinder(9, p815_hole, p815_hole);
            translate([0, bp_wide/2+wall_thick/2, -bp_thick])
                cylinder(bp_head_deep, p815_head, p815_head);
        }
    }
    
    // top plate holes
    for (h=tp_holes) {
        translate([h, eps, 0]) {
            // screw hole
            translate([0, wall_high-tp_thick-tp_from_top-eps*2, wall_thick+1.5+6]) 
                rotate([270, 0, 0]) cylinder(9, m25_hole, m25_hole);
            translate([0, wall_high-tp_thick-tp_from_top-eps*2, wall_thick+1.5+6+19.25]) 
                rotate([270, 0, 0]) cylinder(9, m25_hole, m25_hole);
        }
    }
    
    // hinge pin shaft and bevel
    translate([hph_from_right-eps, wall_high-hph_from_top, hph_from_front])
        rotate([0, 90, 0]) cylinder(hph_wide-1, hph_pin_ir, hph_pin_ir);
    translate([hph_from_right-eps, wall_high-hph_from_top, hph_from_front])
        rotate([0, 90, 0]) cylinder(1.6, hph_pin_ir+0.8, hph_pin_ir);
    // hinge pin set screw
    translate([hph_from_right+hph_wide/2, wall_high-hph_from_top-hph_thick/2-eps, hph_from_front]) 
        rotate([270, 0, 0]) cylinder(hph_thick/2, m25_thrd, m25_thrd);

    // side corner hole
    translate([wall_thick+6, 38, 0.5]) cylinder(99, m25_thrd, m25_thrd);

    // Debug
    //translate([-100, -100, -eps]) cube([114, 109, 999]);
}
