$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Panel dims
pan_x=136.4;
pan_y=78;
pan_thick=3.4;
pan_rad=2;

//translate([-1, -20, -15]) cube([1, 220, 220]);

// Space between panels
sp=1.5;
// Total width
tw=pan_x+sp+95.50+47.6;
// Panel tilts
lower_tilt=20;
upper_tilt=60;
// Panel spacing dims
wrist=15;
wbw=46;
top_spacer=15;

// Choose one
//projection(cut=true) rotate([0, 90, 0]) translate([-248.34, 0, 0]) {
union() {
    // Lower panels container
    rotate([lower_tilt, 0, 0]) union() {
        // Joystick panel
        translate([0, top_spacer+sp, 3.4]) {
            include<js-panel.scad>;
            //import("js-panel-mockup-0.stl");
        }
        // Trim panel
        // cube([pan_x, wrist+top_spacer+sp, 3.4]);
//        translate([0, -sp-wrist, -0.7]) {
//            include<trim-encoder-panel.scad>;
//            //import("trim-encoder-panel-mockup-0.stl");
//        }
        // Card window panel
//        color("lightgrey") translate([0, -sp-wrist-sp-28, -1.3]) {
//            include<blank-panel-b.scad>;
//        }
//        translate([0, -sp-wrist-sp-28, 3.4]) rotate([180, 0, 0]) {
//            include<blank-panel-b-face.scad>;
//        }
        rotate([0, 90, 180]) translate([0.7, -wrist+28+sp+2.0, -281]) {
            include<hinge-right.scad>;
        }
        
        // Blank panels
        translate([pan_x+sp, -wrist-sp, 2.7]) rotate([180, 0, 0]) {
            include<blank-panel-a.scad>;
        }
        translate([pan_x+sp, +pan_y+sp, 2.7]) rotate([180, 0, 0]) {
            include<blank-panel-a.scad>;
        }
        // Warning buttons
        translate([pan_x+sp, 0, 3.4]) {
            //rotate([0, 0, 180]) translate([-wbw, -pan_y, 0]) import("warn-panel-mockup-0.stl");
            rotate([0, 0, 180]) translate([-wbw, -pan_y, -3.4]) {
                include<warn-panel.scad>;
            }
        }
        // Flaps
        translate([pan_x+sp+wbw+sp+0.1, 0, 3.4]) {
            import("flaps-control-mockup-0.stl");
        }
        // joiners
        color("grey") translate([64, -10.5, -3.0]) {
            include<joiner-js-trim-warn.scad>;
        }
        translate([64, -10.5, -0.7]) {
            include<joiner-js-hack.scad>;
        }
        color("pink") translate([185.4, 0, -5.4]) {
            include<joiner-flaps-warn.scad>;
        }
        color("pink") translate([0, top_spacer+sp+78-7.5, -4.0]) {
            include<joiner-lower-upper.scad>;
        }
    }

    // Upper panels container
    rotate([lower_tilt, 0, 0]) translate([0, pan_y+sp+top_spacer+sp+sp+0.6, 0.767]) 
            rotate([upper_tilt-lower_tilt, 0, 0]) translate([0, sp, 0]) {
        // alignment cylinder example
        //rotate([0, 90, 0]) translate([-4-3.4, 0, 0]) cylinder(281, 4, 4);
        // Gear
        // 10.94, 20.75, 2.5
        translate([216+sp++10.94, 27.75, 2.5]) {
            import("gear-control-panel-mockup-0.stl");
        }
        // Gear skirt
        translate([216+sp, 0, 0]) difference() {
            include<gear-skirt.scad>;
    //        cube([tw-216-sp, 83.5+30, 3.4]);
    //        translate([10, 19, -eps]) cube([tw-216-20, 88-14, 99]);
        }

        // FCU take 2
        translate([0, 30, -0.7]) { 
            include<fcu-p1.scad>;
            rotate([0, 180, 90]) translate([0, 0, -3.4]) {
                include<fcu-p1-face.scad>;
            }
            translate([0, -29.95, -9.3]) {
                include<joiner-mag-left.scad>;
                translate([0, 40, 0]) rotate([180, 0, 0]) {
                    include<joiner-metal-clip.scad>;
                }
            }
            //import("fcu-mockup-0.stl");
        }

        // Filler below fcu
        //translate([0, 0, -3.4]) cube([216, 30-sp, 3.4]);
        include<fcu-p3.scad>;
        
        // joiners
        color("grey") translate([7, 21, -3]) {
            include<joiner-fcu-p1-p3.scad>;
        }
        color("grey") translate([208.50, 7, -3]) {
            include<joiner-fcu-gear.scad>;
        }
        color("grey") translate([208.50, 99.5+7.25, -3]) {
            include<joiner-fcu-gear-sm.scad>;
        }
        // 
    }
    
    // Case sides container
    color("grey") rotate([90, 0, 90]) translate([-49.344, -65.334, -3.0-1.5-1]) {
        include<case-side-left-panel.scad>;
    }
}

echo(28.5-3.75-3.75, (10+3.75)/2, 7, 3.75*4+sp, 3.75*2, tw-216-sp, 83.5+30);

// Card window
cww=tw-41.64-sp;
//translate([0, pan_y+sp, 0]) cube([cww, 72.00, 3.4]);
