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
wall_high=204.797;
wall_wide=217.231;
wall_thick=4.0;
wall_bev=(sqrt(wall_thick*wall_thick*2));

// wall corners
wc=[[17.785, 0], // clockwise from bottom left
    [217.231, 0],
    [217.231, 195.234],
    [200.668, 204.797],
    [141.167, 101.739], // curved node
    [138.030, 99.160],  // curved node
    [0, 48.864]];

// bottom plate dims
bp_wide=18;
bp_thick=4.0;
bp_head_deep=2.0;
bp_holes=[42:50:192];
echo(bp_holes);

// Debug bottom plate mating
//translate([wall_wide-18-7, 0, 0]) rotate([110, 0, 0]) translate([0, 18-12+5., -6]) cube(12);

mirror([1, 0, 0]) translate([-wc[1][0], 0, 0]) difference() {
    union() {
        linear_extrude(wall_thick) import("side-profile-left.svg");
    
        // bottom plate
        translate([wc[0][0], 0, 0]) cube([wc[1][0]-wc[0][0], bp_thick, bp_wide]);
                    
        // corner flanges
        for (y=[40, 128]) {
            translate([wc[1][0], y, 0]) rotate([0, 0, 180]) {
                include<case-corner-test.scad>;
            }
        }
        
        // top corner flange
        translate([wc[1][0]-wall_thick-2, wc[2][1]-11.310, wall_thick]) cube([2, 9, 12]);

        // front corner flange
        translate([wc[0][0], 0, wall_thick]) rotate([0, 0, 20]) 
            translate([wall_thick, 32, 0]) cube([2, 12, 12]);
        
        // Debug magnet
        //translate([wc[4][0], wc[4][1], 0]) rotate([0, 0, 60]) translate([1.50, -30.5, wall_thick]) {
        //    include<joiner-mag-clip.scad>;
        //}
    }
    
    // bevel corners
    // front
    translate([wc[0][0], -eps, wall_thick]) rotate([270, 0, 20]) cylinder(999, wall_thick, wall_thick, $fn=4);
    // back
    translate([wall_wide, -eps, wall_thick]) rotate([270, 0, 0]) cylinder(999, wall_thick, wall_thick, $fn=4);
    // top
    translate([wc[2][0], wc[2][1], wall_thick]) rotate([270, 0, 60]) cylinder(999, wall_thick, wall_thick, $fn=4);
    // bottom plate
    translate([wc[0][0], -eps, 0]) rotate([270, 0, 0]) 
        translate([-eps, -bp_wide, 0]) cylinder(bp_thick+eps*2, bp_wide, bp_wide, $fn=4);
    translate([wall_wide, -eps, 0]) rotate([270, 0, 0]) 
        translate([-eps, -bp_wide, 0]) cylinder(bp_thick+eps*2, bp_wide, bp_wide, $fn=4);

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
    
    // top corner flange hole
    translate([wc[1][0]-wall_thick-2-eps, 189.728, wall_thick+6])
        rotate([0, 90, 0]) cylinder(99, m25_hole, m25_hole);

    // front corner flange hole
    translate([wc[0][0], 0, 0]) rotate([0, 0, 20]) 
        translate([wall_thick-eps, 38, wall_thick+6]) rotate([0, 90, 0]) cylinder(99, m25_hole, m25_hole);
//
//    translate([wc[1][0]-wall_thick-2-eps, 189.728, wall_thick+6]) rotate([0, 90, 0]) 
//        cylinder(99, m25_hole, m25_hole);
    
    // magnet mounting holes
    translate([wc[4][0], wc[4][1], 0]) rotate([0, 0, 60]) translate([1.5+3.33, -26, 1]) {
        cylinder(99, m2_thrd, m2_thrd);
        translate([24+14-6.6, 0, 0]) cylinder(99, m2_thrd, m2_thrd);
    }
        
    // Debug
    //translate([-100, -100, -eps]) cube([114, 109, 999]);
}
