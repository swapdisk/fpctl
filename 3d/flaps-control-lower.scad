eps=0.01;

rotate([90, 0, 0]) difference() {
    union() {
        include<flaps-control.scad>;
    }
    translate([0, 0, -eps]) cylinder(99, 99, 99);
}
