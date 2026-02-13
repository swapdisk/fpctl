$fn=360;
eps=0.01;

// Params Cherry knock out
cko_width=14.00;
cko_high=14.00;
cko_thick=1.50;

// Key panel dims
kp_x=69.96;
kp_y=22;

// Posts
post_tall=28.81-1.7;
posts=[[3,9.5],
       [3,19],
       [34.98,9.5],
       [34.98,19],
       [66.96,9.5],
       [66.96,19],
        ];
post_or=5.5/2;
post_hole_rad=2.60/2;
post_head_rad=4.36/2;

difference() {
    union() {
        // main panel
        cube([kp_x, kp_y, cko_thick]);
        // posts
        for (p=posts) {
            translate([p[0], p[1], cko_thick]) cylinder(post_tall, post_or, post_or);
            // supports
            if (p[1]<12) translate([p[0]-0.5, p[1], cko_thick]) cube([1, 8, 5]);
            if (p[0]<50 && p[1]>12) translate([p[0], p[1]-0.5, cko_thick]) cube([30, 1, 5]);

        }
    }
    // key switch knockouts
    translate([8, 3, -eps]) cube([cko_width, cko_high, 99]);
    translate([47.96, 3, -eps]) cube([cko_width, cko_high, 99]);
    // post holes
    for (p=posts) {
        translate([p[0], p[1], -eps]) 
            cylinder(post_tall+cko_thick-4.00, post_head_rad, post_head_rad);
        translate([p[0], p[1], -eps]) 
            cylinder(99, post_hole_rad, post_hole_rad);
    }    
    // Debug
    //translate([-99+3, 0, -eps]) cube(99);
}
