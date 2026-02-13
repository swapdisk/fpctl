$fn=180;
eps=0.01;

// Dust cover raceway
dcr_long=60;
dcr_wide=20;
dcr_thick=3;
dcr_chan_deep=0.6;
dcr_chan_wide=10.5;
dcr_slot_long=54;
dcr_slot_wide=8;
rd_rad=10;
el_holes_rad=3.20/2;

// Dust cover raceway
//translate([-dcr_long/2, -30, -dcr_thick-eps-eps])
difference() {
    union() {
        // main body
        cube([dcr_long, dcr_wide, dcr_thick]);
        // rolldown cylinder
        translate([0, dcr_wide, dcr_thick-rd_rad-dcr_chan_deep]) rotate([90, 270, 0])
            rotate_extrude(angle=90) translate([rd_rad-3, 0, 0]) square([3, dcr_chan_wide]); 
        //rotate([270, 0, 0]) cylinder(dcr_chan_wide, rd_rad, rd_rad);
    }
    // subtract raceway channel
    translate([-eps, dcr_wide-dcr_chan_wide, dcr_thick-dcr_chan_deep]) cube(99);
    // subtract slot
    translate([dcr_long/2-dcr_slot_long/2, dcr_wide-dcr_slot_wide-1, -eps])
        cube([dcr_slot_long, dcr_slot_wide, 99]);
    // el holes
    for (x = [dcr_long/2+25, dcr_long/2, dcr_long/2-25]) {
        translate([x, 3.4, -eps]) 
            cylinder(99, el_holes_rad, el_holes_rad);
    }
}
