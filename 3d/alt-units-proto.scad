$fn=180;
eps=0.01;

// Panel thickness
p_thick=3.00;

// Display lens area dims
d_cav_thick=1.80;
d_cav_wide=196.00;
d_cav_high=15.00;
d_cav_x=11.2;
d_cav_y=76.21-14.5;
d_lens_thick=0.60;
d_lens_wide=182.610;
d_lens_high=16.060;
d_lens_x=16.695;
d_lens_y=61.414;

// Display screws
disp_screws=[11, 54, 103, 141, 184];
          
// Display stud dims
d_stud_or=6.00/2;
d_stud_ir=2.46/2;
d_stud_high=4.22;
d_x=11.7;
d_y=76.71;

// Altitude units collar
uc_thick=1.80;
uc_rad=23.20/2;
uc_x=70.3655;
uc_y=38.3405;

// Alt units knob dims
ko_rad=9.81;
auk_or=22.74/2;
auk_ir=11.20/2;
auk_high=4.6;
auk_ring_or=18.62/2;
auk_ring_high=3; // adj vis knob height
ausm_xy=30;
ausm_hole_rad=3.06/2;
ausm_tab_wide=7;
ausm_tab_long=18;
ausm_thick=7.8;
ausm_cav=4.9;
bev=1.1;
tex_rad=1.5/2;
tex_num=24;

// Switch slot
ss_wide=5.9;
ss_long=12.9;
m2_thread_rad=1.98/2;

// Altitude units prototype
rotate([180, 0, 180]) 
                // translate([-216, -1.5, 0]) 
                // translate([uc_x, uc_y, p_thick-uc_thick]) 
                rotate([0, 0, 0]) {
    color("lightblue") translate([0, 0, 4.5]) rotate([0, 0, 0]) difference() {
        // Main ring
        union() {
            // cylinder minus flat spot actuator
            rot=0; // do not print at 50!
            difference() {
                union() {
                    cylinder(auk_high-bev, auk_or, auk_or);
                    translate([0, 0, auk_high-bev]) cylinder(bev, auk_or, auk_or-bev);
                }
                // switch actuator
                rotate([0, 0, rot]) 
                    translate([auk_or-0.7, -49, -eps]) cube([99, 99, auk_high+eps*2]);
                // spring detents
                rotate([0, 0, rot-155]) 
                    translate([auk_or-2.15, 1, -eps]) cube([99, 99, auk_high+eps*2]);
                rotate([0, 0, rot-75]) 
                    translate([auk_or-2.15, -100, -eps]) cube([99, 99, auk_high+eps*2]);
                rotate([0, 0, rot-115]) 
                    translate([auk_or-1.85, -95, -eps]) cube([99, 99, auk_high+eps*2]);
            }
            // cylinder hack for detents
            rotate([0, 0, 227.48+rot]) 
                    rotate_extrude(angle=35) square([auk_or-1.389, auk_high]);
            // cylinder for knobage
            //translate([0, 0, -auk_ring_high]) cylinder(auk_ring_high, auk_ring_or, auk_ring_or);
            // stop tab
            intersection() {
                rotate([0, 0, 146+rot]) 
                    rotate_extrude(angle=18) square([auk_or+1.9, auk_high/2-0.4]);
                cylinder(auk_high/2-0.5, auk_or+2.2, auk_or);
            }
        }
        // Knob attachment cavity hack
        translate([0, 0,  -eps]) cylinder(2, 7, 7);
        
        // Subtract ir
        translate([0, 0, -49]) cylinder(99, auk_ir, auk_ir);
        translate([0, 0, auk_high-bev]) cylinder(bev, auk_ir, auk_ir+bev);

        // Debug
        //translate([00, 0, -105.4]) cube(99);
    }

    // Altitude units switch mount
    color("cyan") translate([-ausm_xy/2, -ausm_xy/2, 4.22]) {
        difference() {
            cube([ausm_xy+3.7, ausm_xy, ausm_thick]);
        
            // Subtract collar
            translate([ausm_xy/2, ausm_xy/2, -eps]) cylinder(ausm_cav, auk_or, auk_or);
            
            // Subtract ir
            translate([ausm_xy/2, ausm_xy/2, -eps]) cylinder(99, auk_ir, auk_ir);
            // Screw holes
            translate([ausm_xy/2+uc_rad, ausm_xy/2+uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);
            translate([ausm_xy/2-uc_rad, ausm_xy/2+uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);
            translate([ausm_xy/2+uc_rad, ausm_xy/2-uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);
            translate([ausm_xy/2-uc_rad, ausm_xy/2-uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);

            // Subtract actuator cavity
            translate([ausm_xy/2, ausm_xy/2, -eps]) rotate([0, 0, 145])
                rotate_extrude(angle=70) square([14, ausm_cav/2]);
            // Switch slot
            translate([26.5, 10.69, -eps]) {
                translate([-1.5, 0, 0]) cube([99, ss_long, ss_wide]);
                translate([5.45, 3.20, 0]) cylinder(99, m2_thread_rad, m2_thread_rad);
                translate([5.45, 9.70, 0]) cylinder(99, m2_thread_rad, m2_thread_rad);
            }
            // Spring holder
            translate([ausm_xy/2, 0, -eps]) { 
                translate([-1.2, 0.4, 0]) cube([2.4, 4, ausm_cav]);
                translate([-7.8, -eps, 0]) cube([15.6, 2.4, ausm_cav]);
                translate([-9.5, 2.2, 0]) cube([19, 0.7, ausm_cav]);
            }
            //%cube([8, 4, 1]);
            
            // Debug
            //translate([ausm_xy/2, ausm_xy/2, -49]) cube(99);        
        }
    }

//    // Altitude units switch cover
    color("grey") translate([-ausm_xy/2, -ausm_xy/2, 3.2]) {
        difference() {
            cube([ausm_xy+3.7, ausm_xy, 1.0]);
        
            // Subtract knob opening
            translate([ausm_xy/2, ausm_xy/2, -eps]) 
                cylinder(ausm_cav, ko_rad, ko_rad);
            
            // Screw holes
            translate([ausm_xy/2+uc_rad, ausm_xy/2+uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);
            translate([ausm_xy/2-uc_rad, ausm_xy/2+uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);
            translate([ausm_xy/2+uc_rad, ausm_xy/2-uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);
            translate([ausm_xy/2-uc_rad, ausm_xy/2-uc_rad, -eps]) 
                cylinder(99, ausm_hole_rad, ausm_hole_rad);
            // Switch screw space
            translate([29, 10.69, -eps]) cube([99, ss_long, ss_wide]);
        }
    }
    
    // Leaf spring
//    lwide=18.2;
//    lthick=0.5;
//    xlnum=4;
//    xlwide=14.0;
//    xlthick=0.1;
//    xlfact=3;
//    bump=2.04;
//    bhigh=ausm_cav-0.6;
//    bwide=2.04;
//    translate([-ausm_xy/2, -ausm_xy/2, 4.52]) {
//        color("pink") translate([ausm_xy/2, 2.35, -eps]) {
//            // main leaf
//            translate([-lwide/2, 0, 0]) cube([lwide, lthick, bhigh]);
//            // extra leafs
//            for (n=[0:xlnum-1]) {
//                translate([-xlwide/2+n/2*xlfact, lthick+xlthick*n, 0]) 
//                    cube([xlwide-n*xlfact, xlthick, bhigh]);
//            }
//            // bump extension
//            translate([0, lthick+xlthick*xlnum+bump, 0]) cylinder(bhigh, bwide/2, bwide/2);
//            // bump tip
//            translate([-bwide/2, lthick+xlthick*xlnum, 0]) cube([bwide, bump, bhigh]);
//        }
//    }
}

// Debug knobs
//rotate([180, 0, 0]) {
//    translate([0, 0, -18]) {
//        include<knob-alt.scad>;
//    }
//}
