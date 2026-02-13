// Victum of the include scad with module bug?
// import stl vs. include fixed it

$fn=180;
eps=0.01;
translate([37.5, 39, -6.5]) rotate([0, 0, 270]) {
    difference() {
        translate([0, 0, -eps]) {
//            import("flaps-control-panel.stl");
//            rotate([270, 0, 0]) import("flaps-control-lower.stl");
            union() {
                include <flaps-control.scad>;
            }
            translate([0, 0, 0.5]) rotate([0, 180, 90]) import("flaps-control-face.stl");
        }
        // Subtract lower
        //translate([0, 0, -99]) cylinder(99, 99, 99);
    }

    //rotate([0, -26, 0]) translate([-21.9, 0, 10.3])
    rotate([0, -26, 0]) translate([-20.3, 0, 4.7])
    //translate([0, 0, 5.3]) 
    //translate([0, 0, 1.2]) 

    union() {
        translate([0, -15, 0]) cylinder(50, 3.88/2, 3.88/2);
        rotate ([0, 0, 90]) translate([-15, 0, 25.3*0.6]) {
            include <flaps-knob-pull-scaled.scad>;
        }
        rotate ([0, 0, 90]) translate([-15, 0, -34.23+16*0.87-6]) {
            include <flaps-knob-pull-collar.scad>;
        }

        rotate ([0, 0, 90]) translate([-15, 0, -34.23+16*0.87-6]) {
            include <flaps-knob-pot-base.scad>;
        }

        rotate ([0, 0, 90]) translate([-15, 0, 39.62+5.3]) {
            include <flaps-knob-top-scaled-pt2.scad>;
        }

        rotate ([0, 0, 90]) translate([-15, 0, 39.62+10.29]) {
            include <flaps-knob-top-scaled.scad>;
        }
    }
}