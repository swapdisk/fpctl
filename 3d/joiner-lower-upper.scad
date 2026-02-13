$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;

lower_m25h_holes=[[2.75, 4.75],
                [133.65, 4.75],
                [140.65, 4.75],
                [278.25, 4.75],
                [181.15, 4.75],
                [237.75, 4.75]];

upper_m25h_holes=[[3.75, 3.75],
                [212.25, 3.75],
                [10, 3.75],
                [206, 3.75],
                [48.19, 3.75],
                [115, 3.75],
                [175.39, 3.75],
                [227.5, 3.75],
                [221.25, 3.75],
                [277.25, 3.75],
                [271, 3.75],
                ];
                
sqkos=[];

// to slide top panel up slightly
shift=0.7;

difference() {
    union () {
        // lower crossmember
        translate([0, 0, ]) cube([281, 9, 3.3]);
        // upper crossmember
        translate([0, 14.182, 3.481]) rotate([40, 0, 0]) translate([0, 0, -10]) cube([281, 6+shift, 13]);
        // support platform
        translate([0, 8.0, 0]) cube([281, 10, 5.779]);
        //translate([0, 15, 0]) cube([281, 3.778, 7.037]);


    }
    // shave platform bottom
    translate([-eps, 0, -99]) cube([299, 99, 99]);
    
    // angle transition cylinder
    translate([-eps, 7.5, 3+7.4+0.75+0.3]) rotate([0, 90, 0]) cylinder(299, 7.4, 7.4);
    
    // lower panel screws
    for (h=lower_m25h_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
    }
    // upper panel screws
    translate([0, 14.182, 3.481]) rotate([40, 0, 0]) translate([0, shift, -10]) for (h=upper_m25h_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
    }
    // upper screw angled platform
    translate([-eps, 14.182, 3.481]) rotate([40, 0, 0]) translate([0, -9, -10-99+13-5.5]) cube([290, 99, 99]);

    // carve out for joystick buttons
    translate([50, -eps, -eps]) cube([78, 7.0, 99]);
    
    // carve outs for boards
    rotate([40, 0, 0]) translate([118.5, 14+shift, -99]) cube([90, 7.0, 99]);
    rotate([40, 0, 0]) translate([70.5, 14+shift, -99]) cube([41, 7.0, 99]);
    
    // not used?
    for (h=sqkos) {
        translate([h[0], h[1], -eps]) cube([7, 7, 99]);
    }

    // Debug test prinnt
    //translate([13.75, -eps, -eps]) cube(999);
}
