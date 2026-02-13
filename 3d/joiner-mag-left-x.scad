$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;

m25h_holes=[[3.75, 83.5/2], [3.75, 24.75], [3.75, 33.75]];
m2t_holes=[[4.26, 79.29]];

// Debug ajoining bits
//translate([0, 0, 10.0 /*.051*/]) {
//    include<fcu-p1.scad>;
//}

color("grey") difference() {
    union () {
        // thin bottom plate
        translate([0, 38, 7.8]) cube([7, 44, 2.2]);
        // taller section
        translate([0, 46, -7.70]) cube([7, 28, 17.70]);
        // engage button panel
        translate([1, 46, -8.70]) cube([1, 11, 1.5]);
  
//        // mating upper-lower
//        translate([0, 0, 0]) cube([6.75, 6.5, 10-5.5]);
//        // mating fcu-p3
//        translate([0, 6.5, 0]) cube([6.75, 21.0, 10]);
//        // mating fcu-p1
//        translate([0, 6.5+21, 0]) cube([6.75, 9.5+3, 10-0.7]);

        // aligning wedge
        translate([-1.3, 49.5, 9]) cube([1.3, 21.0, 1.0]);
        translate([0, 49.5, 0]) rotate([0, -8.21, 0]) cube([1.5, 21.0, 9.10]);

    }
    // carve outs for spd button and stud
    translate([11.29, 49.56, -10]) cylinder(99, 8.2, 8.2);
    translate([5, 69, -10]) cylinder(99, 3.2, 3.2);
    translate([5, 69-3.2, -10]) cube([99, 6.4, 99]);
    
    for (h=m25h_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
        translate([h[0], h[1], -eps]) cylinder(2, m25_head, m25_head);
        translate([h[0], h[1], 2-eps*2]) cylinder(0.4, m25_head, m25_hole);
    }
    for (h=m2t_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m2_thrd, m2_thrd);
    }
}
