$fn=360;
eps=0.01;

// Panel dims
pan_x=136.4;
pan_y=78;
left_x=28;
right_x=left_x+80.16;

// Bezel dims
bez_xy=37.00;
bez_rad=7.20/2;
bez_high=13.00;
bez_thick=1.70;
bez_cone=24.00;

// Rectangle buttons
rectbut_wide=12.59;
rectbut_high=8.75;
rectbut_x=[pan_x/2-rectbut_wide/2, right_x-rectbut_wide/2];
rectbut_y=63.4;
post_hole_rad=2.60/2;
echo(pan_x/2-12, right_x+12, (pan_x/2+right_x)/2);
rectbut_screw_holes=[[pan_x/2-12, rectbut_y-0.5],
                     [pan_x/2-12, rectbut_y+9],
                     [(pan_x/2+right_x)/2, rectbut_y-0.5],
                     [(pan_x/2+right_x)/2, rectbut_y+9],
                     [right_x+12, rectbut_y-0.5],
                     [right_x+12, rectbut_y+9]];

// Keycap model dims
// 0 is fcu square
// 1 is smaller rect
// 2 is big warn square
// 3 is small TO config
kmod=1;
kc_high=[11.589, 7.753, 19.00, 7.753];
kc_wide=[11.589, 11.589, 19.00, 11.589];

// Escutcheon dims
esc_high=3.80;
esc_thick=1.80;
esc_x=70.5;
esc_y=15.35;
felt_mar=1.40;

difference() {
    union() {
        // main body
        for (x=rectbut_x) {
            translate([x-esc_thick-felt_mar+0.5, rectbut_y-esc_thick-felt_mar+0.5, 0]) 
                cube([kc_wide[kmod]+esc_thick*2+felt_mar*2, 
                    kc_high[kmod]+esc_thick*2+felt_mar*2,
                    esc_high]);
        }
        // support
        translate([76, 67, 0]) cube([26, 1, esc_high]);
        // base
        translate([53, 60.0, 0]) cube([esc_x, esc_y, 1]);
//            translate([-esc_base, -esc_base, 0])
//                cube([kc_wide[kmod]+esc_thick*2+felt_mar*2+esc_base*2, 
//                        kc_high[kmod]+esc_thick*2+felt_mar*2+esc_base*2,
//                        1]);
    }
    // subtract inside
    for (x=rectbut_x) {
        translate([x-felt_mar+0.5, rectbut_y-felt_mar+0.5, -eps])
            cube([kc_wide[kmod]+felt_mar*2, kc_high[kmod]+felt_mar*2, 99]);
    }
    // button screw holes
    for (h=rectbut_screw_holes) {
        translate([h[0], h[1], -eps]) 
            cylinder(99, post_hole_rad, post_hole_rad);
    }
    // Orientation mark
    translate([80, 71, 0.8]) linear_extrude(1) text("↑", size=3, 
                font="Routed Gothic:style=Regular");
    // Rectangle buttons
//    for (i = rectbut_x) {
//        %translate([i, rectbut_y, -eps]) cube([rectbut_wide, rectbut_high, 99]);
//    }
}

