$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// unprintable as is
difference() {
    union() { 
        cube([12.6, 4, 1.5]);
        //translate([cube(
        translate([8.3, 0, 1.5]) rotate([270, 0, 0]) cylinder(4, 4.3, 4.3);
    }
    //translate([1.2, -eps, 1.3]) cube([0.88, 99, 99]);
    translate([8.3, -eps, 1.5]) rotate([270, 0, 0]) cylinder(99, 3, 3);
    translate([5.3, -eps, 0]) cube([6, 99, 1.5]);
    translate([2, 2, -eps]) cylinder(99, m2_hole);
    translate([-49, -49, -99]) cube(99);
}