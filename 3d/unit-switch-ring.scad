$fn=180;
eps=0.01;

// Altitude units collar
uc_thick=1.80;
uc_rad=11.60;
uc_high=4.22;

// Altitude units control
uctl_or1=11.20;
uctl_or2=9.40;
uctl_ir=8.20;

// Altitude units control
difference() {
    union() {
        // base cylinders
        translate([0, 0, 0]) cylinder(uc_high, uctl_or1, uctl_or1);
        translate([0, 0, uc_thick]) cylinder(uc_high, uctl_or2, uctl_or2);
    }
    // subtract center
    translate([0, 0, -49]) cylinder(99, uctl_ir, uctl_ir);
    
    // notch for lever
    translate([0, 0, uc_high-2]) rotate_extrude(20) square(uctl_or2+eps);

    // Debug
    //translate([0, 0, -49]) cube(99);
}

