$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Debug hinge pin
//color("silver") translate([6, -24, 0]) cylinder(33, hinge_pin_rad-0.1, hinge_pin_rad-0.1);

// Debug card window panel
translate([-0.7, 16.5, 0]) rotate([0, 270, 0]) {
    color("lightgrey") translate([0, -18-28-0.5, -1.3]) {
        include<blank-panel-b.scad>;
    }
    translate([0, -18-28-0.5, 3.4]) rotate([180, 0, 0]) {
        include<blank-panel-b-face.scad>;
    }
}

// Debug panel rotation
//translate([6, -24, 0]) rotate([0, 0, 17]) translate([-6, 24, 0])

difference() {
    union() {
        // Debug real panel
        color("lightgrey") translate([-0.7, 16.5, 0]) rotate([-20, 270, 0]) {
            import("main-mockup.stl");
        }

        // Debug left hinge
        color("grey") {
            import("hinge-left.stl");
        }
    }
}
