$fn=360;
eps=0.01;

// Verified good dims
p=1;
dome_thick=eps;
dc_high=1.69;
ex_high=0.40+14.84-dc_high;
ex_wide=0.40+35.69;
s_rad=ex_wide/2+0.84;
s_y=s_rad-ex_high-dc_high;
cb_rad=36.252/2;

difference() {
    // outer dome
    translate([0, 0, -s_y]) sphere(s_rad+dome_thick);
    union() {
        // lower disk
        cylinder(dc_high, ex_wide/2, ex_wide/2);
        // test sphere
        difference() {
            union() {
                //translate([-p/2, -p/2, 0]) cube([p, p, ex_high+dc_high]);
                //translate([-ex_wide/2, -p/2, dc_high]) cube([ex_wide, p, p]);
                //color("red", 0.5)
                translate([0, 0, -s_y]) sphere(s_rad);
            }
            // subtract test sphere below horizon
            translate([0, 0, -99+dc_high-eps]) cylinder(99, 99, 99);
        }
    }
    // subtract lower disk and down
    translate([0, 0, -99+dc_high]) cylinder(99, 99, 99);

    // Debug
//    translate([0, -99, -eps]) cube(99);
//    rotate([0, 0, 45]) translate([0, -99, -eps]) cube(99);
}

difference() {
    // cylindrical base
    cylinder(dc_high, cb_rad, cb_rad);
    translate([0, 0, -eps]) cylinder(dc_high+eps*2, cb_rad-eps, cb_rad-eps);
    
    // Debug
//    translate([0, -99, -eps]) cube(99);
//    rotate([0, 0, 45]) translate([0, -99, -eps]) cube(99);

}


echo(s_rad, s_y);