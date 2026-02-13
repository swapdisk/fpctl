$fn=360;
eps=0.01;

// flange dims
flange_rad=18.62/2;
flange_thick=2.00;
shaft_hole_rad=9.3/2;

color("grey") difference() {
    cylinder(flange_thick, flange_rad, flange_rad);
    translate([0, 0, -eps]) cylinder(99, shaft_hole_rad, shaft_hole_rad);
}
