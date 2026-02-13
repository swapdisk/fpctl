$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

difference() {
    cube([11.4, 3.4, 5]);
    translate([1.2, -eps, 1.3]) cube([0.88, 99, 99]);
    translate([6.7, -eps, 4.3]) rotate([270, 0, 0]) cylinder(99, 3, 3);
    translate([3.7, -eps, 4.3]) cube([6, 99, 99]);
}