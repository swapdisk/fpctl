$fn=360;
eps=0.01;

// Pinouts
// Encoder 1,2,3
// NO switch 4,5

// Base dims
base_x=52;
base_y=26;
base_thick=1.50;

// Posts
post_tall=3.25;
posts=[[4, 4], [48, 4], [4, 22], [48, 22]];
post_or=5.5/2;
post_hole_rad=2.60/2;
post_head_rad=4.36/2;

// Board dims
screw_xy=[[14.8, 4], [36.3, 4], [15.0, 22], [36.7, 22]];
screw_rad=1.98/2;
bd_mnt_rad=5.50/2;
bd_mnt_high=3.25;
echo(22-4);

// Wheel support
ws_c=12.30;
ws_high=17.22;
ws_thick=1.27;
ws_long=[9.00, 11.00];
wsb_rad=[3.15/2, 7.50/2];
wsb_high=[15.44, 15.44];
wheel_wide=8.90;
ws_x=[base_x/2-wheel_wide/2-ws_thick, base_x/2+wheel_wide/2];
            
difference() {
    union() {
        // base plate
        //cube([base_x, base_y, base_thick]);
        m=1;
        translate([m, m, 0]) cube([base_x-m*2, base_y-m*2, base_thick]);
        // posts
        for (p=posts) {
            translate([p[0], p[1], base_thick]) cylinder(post_tall, post_or, post_or);
            // supports
            if (p[1]<13) 
                translate([p[0]-0.5, p[1], base_thick]) cube([1, 18, bd_mnt_high]);
            if (p[0]<30 && p[1]>0)
                translate([p[0], p[1]-0.5, base_thick]) cube([44, 1, bd_mnt_high]);
        }

        // board screws
        for (p=screw_xy) {
            translate([p[0], p[1], base_thick]) cylinder(bd_mnt_high, bd_mnt_rad, bd_mnt_rad);
        }
        // wheel supports
        for (i=[0, 1]) {
            translate([ws_x[i], ws_c-ws_long[i]/2, base_thick])
                cube([ws_thick, ws_long[i], ws_high]);
        }
        // wheel support anchors
        for (y=[ws_c-4.5, ws_c+3.5]) {
            translate([ws_x[0]+ws_thick, y, base_thick]) 
                cube([ws_x[1]-ws_x[0]-ws_thick, 1, 3.0+(ws_x[1]-ws_x[0]-ws_thick)/2]);
        }
        for (y=[ws_c-5.5, ws_c+3.5]) {
            translate([ws_x[1]+ws_thick, y, base_thick]) 
                cube([2, 2, bd_mnt_high]);
        }
        translate([ws_x[0]-1, ws_c-4.5, base_thick]) cube([1, ws_long[0], bd_mnt_high]);
    }
    // post holes
    for (p=posts) {
        //translate([p[0], p[1], -eps]) 
        //    cylinder(post_tall+base_thick-3.00, post_head_rad, post_head_rad);
        translate([p[0], p[1], -eps]) 
            cylinder(99, post_hole_rad, post_hole_rad);
    }    
    // Debug
    //translate([-99+4, 0, -eps]) cube(99);

    // board screw holes
    for (p=screw_xy) {
        translate([p[0], p[1], 1]) cylinder(99, screw_rad, screw_rad);
    }
    // wheel supports
    for (i=[0, 1]) {
        translate([ws_x[i]-eps, ws_c, base_thick+wsb_high[i]]) {
            rotate([0, 90, 0]) cylinder(ws_thick+eps*2, wsb_rad[i], wsb_rad[i]);
            translate([0, -wsb_rad[i], 0])cube([ws_thick+eps*2, wsb_rad[i]*2, 99]);
        }
    }
    // wheel support anchors
    for (y=[ws_c-4.5, ws_c+3.5]) {
        translate([base_x/2, y-eps, 3.0+base_thick+(ws_x[1]-ws_x[0]-ws_thick)/2]) rotate([270, 0, 0])
            cylinder(1+eps*2, (ws_x[1]-ws_x[0]-ws_thick)/2, (ws_x[1]-ws_x[0]-ws_thick)/2);
    }
    // cavity below wheel
    translate([ws_x[0]+ws_thick+0.5, ws_c-3.5, -eps]) cube([wheel_wide-1.0, ws_long[0]-2, 99]);
}
     
// More wheel support strength
translate([ws_x[0]+ws_thick, ws_c-4.5, base_thick]) 
    cube([0.5, ws_long[0], wsb_high[0]-wsb_rad[0]-1.7]);
translate([ws_x[1]-0.5, ws_c-5.5, base_thick]) 
    cube([0.5, ws_long[1], wsb_high[1]-wsb_rad[1]-1]);

echo("z", 0.1+base_thick+wsb_high[0]);

difference() { union() {

// Mock wheel
color("lightblue") translate([ws_x[0]-4.928, ws_c, 0.1+base_thick+wsb_high[0]]) rotate([0, 90, 0]) {
    cylinder(4, 1.68/2, 1.68/2, $fn=6);
    translate([0, 0, 3]) cylinder(4, 3.07/2, 3.07/2);
    translate([0, 0, 6.18]) cylinder(6, 5.08/2, 5.08/2);
    translate([0, 0, 7.75+6.47/2-2]) cylinder(4, 10, 10);
    translate([0, 0, 7.75-0.35/2+6.47/2])
        rotate_extrude(angle=360) translate([23.25/2-6.47/2, 0, 0]) circle(6.47/2);
    translate([0, 0, 11.112]) cylinder(4, 7.89/2, 7.89/2);
    difference() {
        translate([0, 0, 15]) cylinder(22.76-15, 7.34/2, 7.34/2);
        translate([0, 0, 15+eps]) cylinder(22.76-15, 2, 2);
    }
}

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

} //translate([-eps, -eps, -eps]) cube([99, base_y/2, 99]); 
}

