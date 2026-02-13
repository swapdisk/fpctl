$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

x=11.8;
w=4.4;

difference() {
    cube([x, w, 4.3]);
    //translate([1.2, -eps, 1.3]) cube([0.88, 99, 99]);
    translate([w/2, w/2, -eps]) cylinder(99, m2_hole, m2_hole);
    translate([7.4, -eps, 4.3]) rotate([270, 0, 0]) cylinder(99, 3, 3);
    //translate([3.7, -eps, 4.3]) cube([6, 99, 99]);
}