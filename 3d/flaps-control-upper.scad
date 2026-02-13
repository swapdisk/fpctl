eps=0.01;

difference() {
    translate([0, 0, -eps]) {
        include <flaps-control.scad>;
    }
    // Subtract lower
    translate([0, 0, -99]) cylinder(99, 99, 99);
}
