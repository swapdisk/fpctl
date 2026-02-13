$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;

m25h_holes=[[3.75, 3.75], [3.75, 56.75], [3.75, 103.50]];
m2t_holes=[[3.75, 8], [3.75, 38]];


// Debug ajoining bits
//translate([-63.5, 0, 7+3.0]) {
//    include<gear-skirt.scad>;
//}
//translate([-281, 2.898-16, 13.4494 /*.051*/]) rotate([-40, 0, 0]) {
//    include<joiner-lower-upper.scad>;
//}

mirror([1, 0, 0]) color("grey") difference() {
    union () {
        // mating upper-lower
        translate([0, 0, 0]) cube([6.75, 6.5, 10-5.5]);
        // mating fcu-gear
        translate([0, 6.5, 0]) cube([6.75, 99.75, 10]);

        // aligning wedge
        for (y=[6.5, 80]) {
            translate([-1.3, y, 9]) cube([1.3, 21.0, 1.0]);
            translate([0, y, 0]) rotate([0, -8.21, 0]) cube([1.5, 21.0, 9.10]);
        }
    }
    for (h=m25h_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
        translate([h[0], h[1], -eps]) cylinder(2.2, m25_head, m25_head);
        translate([h[0], h[1], 2.2-eps*2]) cylinder(0.4, m25_head, m25_hole);
    }
    for (h=m2t_holes) {
        translate([h[0], h[1], -eps]) cylinder(5, m2_thrd, m2_thrd);
    }
}
