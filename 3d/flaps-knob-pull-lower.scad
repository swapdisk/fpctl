$fn=180;
eps=0.01;

difference() { 
    rotate([0, 0, 90]) translate([0, 0, 16.794-16.794]) {
            include <flaps-knob-pull-scaled.scad>;
    }
    translate([-49, -49, 10.8]) cube(99);
    translate([-49, -49, -eps]) cube([99, 99, 1.804]);
    
}