$fn=180;
eps=0.01;

// Unit switch mount dims
mount_thick=3.00;
d_stud_or=6.00/2;
d_stud_ir=2.46/2;
uc_rad=11.60;
knob_hole=8.60;

difference() {
    linear_extrude(mount_thick) hull() {
        translate([uc_rad, uc_rad, 0])
            circle(d_stud_or);
        translate([uc_rad, -uc_rad, 0])
            circle(d_stud_or);
        translate([-uc_rad, uc_rad, 0])
            circle(d_stud_or);
        translate([-uc_rad, -uc_rad, 0])
            circle(d_stud_or);
    }
    translate([uc_rad, uc_rad, -eps])
        cylinder(99, d_stud_ir, d_stud_ir);
    translate([uc_rad, -uc_rad, -eps])
        cylinder(99, d_stud_ir, d_stud_ir);
    translate([-uc_rad, uc_rad, -eps])
        cylinder(99, d_stud_ir, d_stud_ir);
    translate([-uc_rad, -uc_rad, -eps])
        cylinder(99, d_stud_ir, d_stud_ir);
    // subtract center
    translate([0, 0, -49]) cylinder(99, knob_hole, knob_hole);
}
