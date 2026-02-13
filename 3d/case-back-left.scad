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
wall_high=195.234;
wall_wide=149.5;
wall_thick=4.0;
wall_bev=(sqrt(wall_thick*wall_thick*2));

// bottom plate dims
bp_wide=18;
bp_thick=4.0;
bp_head_deep=2.0;
bp_holes=[25, wall_wide/2, wall_wide-15];

// back wall tabs
bw_wide=12;
bw_high=10;
bw_thick=2;
bw_x=[21, 63, 105, 133.5];

// base sides mating dims
bs_high=p815_head*2+3;
bs_wide=bs_high;
bs_thick=4;
bs_y=[30, 114];

// Debug more panels
//translate([0, 0, 217.231]) rotate([0, 90, 0]) {
//    include<case-side-left-panel.scad>;
//}
//translate([0, wall_high, 0]) rotate([60, 0, 0]) translate([wall_wide, 19.125, 0]) rotate([0, 0, 180]) {
//    include<case-top-left.scad>;
//}

difference() {
    union() {
        cube([wall_wide, wall_high, wall_thick]);
    
        // bottom plate
        translate([0, 0, 0]) cube([wall_wide, bp_thick, bp_wide]);
                    
        // corner flanges
        for (y=[10, 98]) {
            translate([0, y, 0]) rotate([0, 0, 0]) {
                include<case-corner-test.scad>;
            }
        }
        
        // side mating bits and support
        for (y=bs_y) {
            // screw side
            //translate([wall_wide-bs_thick, y+bs_wide/2, wall_thick+bs_wide/2]) 
            //    rotate([0, 90, 0]) cylinder(bs_thick, bs_wide/2, bs_wide/2);
            // threads side
            translate([wall_wide-p815_deep, y+bs_wide/2, wall_thick+bs_wide/2]) 
                rotate([0, 90, 0]) cylinder(p815_deep, bs_wide/2, bs_wide/2);
            translate([wall_wide-p815_deep, y, 0]) 
                cube([p815_deep, bs_wide, wall_thick+bs_wide/2]);
        }
        translate([wall_wide-bs_thick, 0, 0]) cube([bs_thick, wall_high-68, wall_thick+bs_wide/2]);
        // special top bit
        translate([wall_wide-10, wall_high-5.506, wall_thick+m25_head+1]) 
                rotate([0, 90, 0]) cylinder(10, m25_head+0.3, m25_head+0.3);
        translate([wall_wide-10, wall_high-5.506-m25_head-0.3, wall_thick]) 
                cube([10, m25_head*2+0.6, m25_head+1]);
        translate([wall_wide-bs_thick, 0, 0]) cube([bs_thick, wall_high-5.506, wall_thick+2]);
    }
    
    // bevel corners
    // side
    translate([0, -eps, wall_thick]) rotate([270, 0, 0]) cylinder(999, wall_thick, wall_thick, $fn=4);
    // top
    translate([-eps, wall_high, 0]) rotate([30, 0, 0]) cube([999, 5, 5]);
    // bottom plate
    translate([0, -eps, 0]) rotate([270, 0, 0]) 
        translate([-eps, -bp_wide, 0]) cylinder(bp_thick+eps*2, bp_wide, bp_wide, $fn=4);
//    translate([wall_wide, -eps, 0]) rotate([270, 0, 0]) 
//        translate([-eps, -bp_wide, 0]) cylinder(bp_thick+eps*2, bp_wide, bp_wide, $fn=4);

    // bottom plate holes
    for (h=bp_holes) {
        echo(h-17.785-6);
        translate([h, eps, 0]) rotate([90, 0, 0]) {
            // screw hole and head
            translate([0, bp_wide/2+wall_thick/2, -bp_thick]) 
                cylinder(9, p815_hole, p815_hole);
            translate([0, bp_wide/2+wall_thick/2, -bp_thick])
                cylinder(bp_head_deep, p815_head, p815_head);
        }
    }
    
    // top tabs holes
    for (x=bw_x) {
        translate([wall_wide-x-bw_wide/2, wall_high-5.506, 0.5]) rotate([0, 0, 0])
            cylinder(99, m25_thrd, m25_thrd);
    }

    // side mating holes
    for (y=bs_y) {
        // screw side
        //translate([wall_wide-bs_thick-eps, y+bs_wide/2, wall_thick+bs_wide/2]) 
        //    rotate([0, 90, 0]) cylinder(99, p815_hole, p815_hole);
        //translate([wall_wide-bs_thick-eps, y+bs_wide/2, wall_thick+bs_wide/2]) 
        //    rotate([0, 90, 0]) cylinder(bs_thick/2, p815_head, p815_head);
        // threads side
        translate([wall_wide-p815_deep+1, y+bs_wide/2, wall_thick+bs_wide/2]) 
            rotate([0, 90, 0]) cylinder(99, p815_thrd, p815_thrd);
    }
    // special top bit hole
    translate([wall_wide-9, wall_high-5.506, wall_thick+m25_head+1]) 
            rotate([0, 90, 0]) cylinder(10, m25_thrd, m25_thrd);

    // extra special carve out for p2 space
    translate([-eps, 170, 0.8]) cube([22, 13.5, 4]);
    
    // Debug
    //translate([-100, -100, -eps]) cube([114, 109, 999]);
}
