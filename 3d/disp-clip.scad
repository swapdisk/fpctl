$fn=180;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

difference() {
    linear_extrude(4) hull() {
        translate([10, -4, 0]) circle(2.5);
        translate([10, 18.5, 0]) circle(2.5);
    }
    translate([0, -1, 1.0]) cube([99, 16.5, 99]);
    translate([10, -4, -eps]) cylinder(99, m2_hole, m2_hole);
    translate([10, 18.5, -eps]) cylinder(99, m2_hole, m2_hole);

}