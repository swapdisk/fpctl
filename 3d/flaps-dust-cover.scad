$fn=180;
eps=0.01;

// Dust cover
dc_thick=0.5;
dc_wide=8+2;
dc_long=120.4;

difference() {
    translate([-dc_long/2, 0, 0]) cube([dc_long, dc_wide, dc_thick]);
    translate([0, dc_wide/2, -eps]) 
        scale([1.3, 1, 1]) cylinder(99, (dc_wide/2)-1, (dc_wide/2)-1);
    for (x = [-dc_long:0.8:dc_long]) {
        translate([x-0.2, -eps, 0.3]) cube([0.4, 99, 99]);
    }
}
