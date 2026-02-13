$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Pinouts
// Encoder 1,2,3
// NO switch 4,5

// Base dims
pan_x=136.4;
pan_y=31.5;
pan_thick=3.4;
pan_rad=2;

// Wheel location
wl_x=30.713;
wl_y=3.45;
wl_z=-21.50;

// Wheel cylinder
wlc_rad=25/2;
wlc_wide=9.50;
wlc_x=wl_x+26-wlc_wide/2+0.30;
wlc_y=pan_y/2;
wlc_z=wl_z+17.04;

// Posts
post_tall=-wl_z-3.25-1.50-eps;
posts=[[4, 4], [48, 4], [4, 22], [48, 22]];
post_or=5.5/2;
post_screw_deep=5;

// Screw holes
pan_screw_deep=2.6;
corner_screw_holes=[[2.75, 2.75],
                    [pan_x-2.75, 2.75],
                    [2.75, pan_y-2.75],
                    [pan_x-2.75, pan_y-2.75],
                    [pan_x/2, 3.75],
                    [pan_x/2, pan_y-3.75]];
// Face tabs
s=0;
dd=8;
tab_thick=1.2;
ft=[[dd, 0, pan_x-dd*2, tab_thick],
    [dd, pan_y-tab_thick, pan_x-dd*2, tab_thick],
    [0, dd, tab_thick, pan_y-dd*2],
    [pan_x-tab_thick, dd, tab_thick, pan_y-dd*2]];

// Debug wheel location
difference() {
    translate([wl_x, wl_y, wl_z]) color("lightblue") 
        import("trim-encoder-mount-mockup-0.stl");
    //translate([0, 0, 3.4+0.7]) cube(99);
}
// Debug face
translate([0, 0, 3.4]) rotate([0, 180, 90]) {
    include<trim-encoder-panel-face.scad>;
}
//color("red") translate([53.7, pan_y/2, 0]) cube(6.53);

// Uncomment one choice only:
union() {
//projection(cut=true) translate([0, 0, -2.9]) { 
//translate([0, 0, -pan_thick-0.7+0.7]) {
    color("lightgrey") difference() {
        union() {
            // base panel
            linear_extrude(pan_thick) hull() {
                translate([pan_rad, pan_rad, 0]) circle(pan_rad);
                translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
                translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
                translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
            }
            // posts
            for (p=posts) {
                translate([p[0]+wl_x, p[1]+wl_y, -post_tall]) cylinder(post_tall, post_or, post_or);
                // supports
                if (p[1]<13) 
                    translate([p[0]+wl_x-0.5, p[1]+wl_y, -4]) cube([1, 18, 4]);
                if (p[0]<30 && p[1]>0)
                    translate([p[0]+wl_x, p[1]+wl_y-0.5, -4]) cube([44, 1, 4]);
                // alignment hack
                difference() {
                    translate([p[0]+wl_x, p[1]+wl_y, -post_tall-1])
                        cylinder(post_tall+1, post_or+0.5, post_or+0.5);
                    translate([p[0]+wl_x, p[1]+wl_y, -post_tall-1-eps])
                        cylinder(1+eps, post_or+0.06, post_or+0.06);
                    translate([posts[0][0]+wl_x-0.7, posts[0][1]+wl_y-0.7, -post_tall-1-eps])
                        cube([posts[1][0]-posts[0][0]+1.4, posts[2][1]-posts[1][1]+1.4, 1+eps]);
                }
            }
            // supports around wheel opening
            translate([wlc_x-1, tab_thick+1, -4]) cube([wlc_wide+2, 5, 4]);
            translate([wlc_x-1, pan_y-tab_thick-5, -4]) cube([wlc_wide+2, 4, 4]);
        }
        // subtract face tabs
        for (f=ft) {
            translate([f[0], f[1], -eps]) cube([f[2], f[3], 99]);
        }
        // wheel opening
        translate([wlc_x, wlc_y, wlc_z]) rotate([0, 90, 0]) 
            cylinder(wlc_wide, wlc_rad, wlc_rad);

        // extra hub space
        translate([wlc_x-wlc_wide, wlc_y, wlc_z]) rotate([0, 90, 0]) 
            cylinder(wlc_wide*3, 5.7, 5.7);

        // wheel screw holes
        for (p=posts) {
            translate([p[0]+wl_x, p[1]+wl_y, -post_tall-eps]) 
                cylinder(post_screw_deep, m2_thrd, m2_thrd);
        }
        // corner screw holes
        for (h=corner_screw_holes) {
            translate([h[0], h[1], -eps]) cylinder(pan_screw_deep, m25_thrd, m25_thrd);
        }
        // Debug
        //translate([-49, -999+6, -49]) cube(999);
        //translate([-49, -999+12, -49]) cube(999);
        //translate([-49, -999+49, -13]) cube(999);
        //translate([-999+50, -999+49, -99]) cube(999);
        //translate([-eps, pan_y/2, 3.4]) rotate([0, 90, 0]) cylinder(999, 0.4, 0.4);
        //translate([-eps, pan_y/2+10, 3.4]) rotate([0, 90, 0]) cylinder(999, 0.4, 0.4);
        //translate([-eps, pan_y/2-10, 3.4]) rotate([0, 90, 0]) cylinder(999, 0.4, 0.4);
    }
}

//difference() {
//    union() {
//        // base plate
//        //cube([base_x, base_y, base_thick]);
//        m=1;
//        translate([m, m, 0]) cube([base_x-m*2, base_y-m*2, base_thick]);
//        // posts
//        for (p=posts) {
//            translate([p[0], p[1], base_thick]) cylinder(post_tall, post_or, post_or);
//            // supports
//            if (p[1]<13) 
//                translate([p[0]-0.5, p[1], base_thick]) cube([1, 18, bd_mnt_high]);
//            if (p[0]<30 && p[1]>0)
//                translate([p[0], p[1]-0.5, base_thick]) cube([44, 1, bd_mnt_high]);
//        }
//
//        // board screws
//        for (p=screw_xy) {
//            translate([p[0], p[1], base_thick]) cylinder(bd_mnt_high, bd_mnt_rad, bd_mnt_rad);
//        }
//        // wheel supports
//        for (i=[0, 1]) {
//            translate([ws_x[i], ws_c-ws_long[i]/2, base_thick])
//                cube([ws_thick, ws_long[i], ws_high]);
//        }
//        // wheel support anchors
//        for (y=[ws_c-4.5, ws_c+3.5]) {
//            translate([ws_x[0]+ws_thick, y, base_thick]) 
//                cube([ws_x[1]-ws_x[0]-ws_thick, 1, 3.0+(ws_x[1]-ws_x[0]-ws_thick)/2]);
//        }
//        for (y=[ws_c-5.5, ws_c+3.5]) {
//            translate([ws_x[1]+ws_thick, y, base_thick]) 
//                cube([2, 2, bd_mnt_high]);
//        }
//        translate([ws_x[0]-1, ws_c-4.5, base_thick]) cube([1, ws_long[0], bd_mnt_high]);
//    }
//    // post holes
//    for (p=posts) {
//        //translate([p[0], p[1], -eps]) 
//        //    cylinder(post_tall+base_thick-3.00, post_head_rad, post_head_rad);
//        translate([p[0], p[1], -eps]) 
//            cylinder(99, post_hole_rad, post_hole_rad);
//    }    
//    // Debug
//    //translate([-99+4, 0, -eps]) cube(99);
//
//    // board screw holes
//    for (p=screw_xy) {
//        translate([p[0], p[1], 1]) cylinder(99, screw_rad, screw_rad);
//    }
//    // wheel supports
//    for (i=[0, 1]) {
//        translate([ws_x[i]-eps, ws_c, base_thick+wsb_high[i]]) {
//            rotate([0, 90, 0]) cylinder(ws_thick+eps*2, wsb_rad[i], wsb_rad[i]);
//            translate([0, -wsb_rad[i], 0])cube([ws_thick+eps*2, wsb_rad[i]*2, 99]);
//        }
//    }
//    // wheel support anchors
//    for (y=[ws_c-4.5, ws_c+3.5]) {
//        translate([base_x/2, y-eps, 3.0+base_thick+(ws_x[1]-ws_x[0]-ws_thick)/2]) rotate([270, 0, 0])
//            cylinder(1+eps*2, (ws_x[1]-ws_x[0]-ws_thick)/2, (ws_x[1]-ws_x[0]-ws_thick)/2);
//    }
//    // cavity below wheel
//    translate([ws_x[0]+ws_thick+0.5, ws_c-3.5, -eps]) cube([wheel_wide-1.0, ws_long[0]-2, 99]);
//}
//     
//// More wheel support strength
//translate([ws_x[0]+ws_thick, ws_c-4.5, base_thick]) 
//    cube([0.5, ws_long[0], wsb_high[0]-wsb_rad[0]-1.7]);
//translate([ws_x[1]-0.5, ws_c-5.5, base_thick]) 
//    cube([0.5, ws_long[1], wsb_high[1]-wsb_rad[1]-1]);
//
//difference() { union() {

// Mock wheel
//color("lightblue") translate([ws_x[0]-4.928, ws_c, 0.1+base_thick+wsb_high[0]]) rotate([0, 90, 0]) {
//    cylinder(4, 1.68/2, 1.68/2, $fn=6);
//    translate([0, 0, 3]) cylinder(4, 3.07/2, 3.07/2);
//    translate([0, 0, 6.18]) cylinder(6, 5.08/2, 5.08/2);
//    translate([0, 0, 7.45+6.47/2-2]) cylinder(4, 10, 10);
//    translate([0, 0, 7.45+6.47/2])
//        rotate_extrude(angle=360) translate([23.25/2-6.47/2, 0, 0]) circle(6.47/2);
//    translate([0, 0, 11.112]) cylinder(4, 7.89/2, 7.89/2);
//    difference() {
//        translate([0, 0, 15]) cylinder(22.76-15, 7.34/2, 7.34/2);
//        translate([0, 0, 15+eps]) cylinder(22.76-15, 2, 2);
//    }
//}

// Mock panel
// Wheel opening dims
wo_wide=7.47;
wo_rad=24.25/2;
//wo_y=7.45;

//color("lightgrey") translate([0, 0, post_tall+base_thick]) {
//    difference() {
//        cube([base_x, base_y, 0.4]);
//        translate([(ws_x[1]-ws_x[0]+ws_thick)/2+ws_x[0]-wo_wide/2, ws_c, 0.1-post_tall+wsb_high[0]]) rotate([0, 90, 0]) {
////            translate([0, 0, 0]) cylinder(0.25, 99, 99);        
////            translate([0, 0, wo_wide-0.25]) cylinder(0.25, 99, 99);        
//            translate([0, 0, 0]) cylinder(wo_wide, wo_rad-wo_wide/2, wo_rad-wo_wide/2);
//            translate([0, 0, wo_wide/2])
//                rotate_extrude(angle=360) 
//                translate([wo_rad-wo_wide/2, 0, 0]) circle(wo_wide/2);
////            translate([0, 0, 7.45+6.47/2])
////                rotate_extrude(angle=360) translate([23.25/2-6.47/2, 0, 0]) circle(6.47/2);
//
//
//        }
//    }
//}

//} //translate([-eps, -eps, -eps]) cube([99, base_y/2, 99]); 
//}

