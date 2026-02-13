$fn=180;
eps=0.01;

// Wheel dims
w_rad=13.00;
w_fil=2.20;
w_wide=5.00;
w_elip=0.7;

// Lever cavity
lc_wide=9.00;
lc_deep=3.00;

difference() {
    rotate_extrude(angle=360) translate([w_rad, w_wide/2, 0]) rotate([0, 0, 90]) hull() {
        translate([w_wide/2-w_fil*w_elip, w_fil, 0]) scale([w_elip, 1, 0]) circle(w_fil);
        translate([-w_wide/2+w_fil*w_elip, w_fil, 0]) scale([w_elip, 1, 0]) circle(w_fil);
        translate([-w_wide/2, w_rad-w_wide, 0]) square(w_wide);
    }
    translate([0, 0, w_wide-lc_deep]) cylinder(99, lc_wide/2, lc_wide/2);
    translate([-lc_wide/2, 0, w_wide-lc_deep]) cube([lc_wide, 99, 99]);
    
    // Debug
    //translate([0, 0, -eps]) cube(99);
}