$fn=360;
eps=0.01;

// Params Cherry knock out
cko_width=14.00;
cko_high=14.00;
cko_thick=1.50;

// Key panel dims
kp_x=38;
kp_y=56;

// Posts
post_tall=28.81;
posts=[[6.8, 7.5], [6.8, 32.5], [6.8, 57.5], [39.2, 7.5], [39.2, 32.5], [39.2, 57.5]];
post_or=5.5/2;
post_hole_rad=2.60/2;
post_head_rad=4.36/2;

difference() {
    union() {
        // main panel
        translate([4, 4.6, 0]) cube([kp_x, kp_y, cko_thick]);
        // posts
        for (p=posts) {
            translate([p[0], p[1], cko_thick]) cylinder(post_tall, post_or, post_or);
            // supports
            if (p[1]<50) translate([p[0]-0.5, p[1], cko_thick]) cube([1, 26, 5]);
            if (p[0]<30 && p[1]>0) translate([p[0], p[1]-0.5, cko_thick]) cube([32, 1, 5]);
//            translate([6, 10, cko_thick]) cube([8, 1, 5]);
//            translate([32, 10, cko_thick]) cube([8, 1, 5]);
        }
    }
    // key switch knockouts
    
    translate([29.5-13.5, 22.6-13.5, -eps]) cube([cko_width, cko_high, 99]);
    translate([29.5-13.5, 53.6-13.5, -eps]) cube([cko_width, cko_high, 99]);
    // post holes
    for (p=posts) {
        translate([p[0], p[1], -eps]) 
            cylinder(post_tall+cko_thick-2.00, post_head_rad, post_head_rad);
        translate([p[0], p[1], -eps]) 
            cylinder(99, post_hole_rad, post_hole_rad);
    }    
    // Debug
    //translate([-99+7, 0, -eps]) cube(99);
}
