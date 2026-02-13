$fn=180;
eps=0.01;

difference() { 
    rotate([180, 0, 90]) translate([0, 0, -16.794]) {
            include <flaps-knob-pull-scaled.scad>;
    }
    translate([-49, -49, 5.9]) cube(99);
    
}