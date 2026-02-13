$fn=180;
eps=0.01;

// keycap model
// 0 is fcu square
// 1 is smaller rect
// 2 is big warn square
// 3 is small TO config
kmod=2;

// Params key cap
kc_tall=17.00;
kc_high=[11.589, 7.753, 19.00, 7.753];
kc_wide=[11.589, 11.589, 19.00, 11.589];
led_high=[3.123, 3.123, 9.000, 0];
led_wide=[8.958, 8.958, 13.000, 0];
led_x=(kc_wide[kmod]-led_wide[kmod])/2;
//led_y=[1.791, 1.253, 4.50, 0];
led_y=[1.791, 0.754, 5.0, 0];
led_flange_high=1.50;
led_flange_rad=4.30/2;
top_to_sw_center=[8.849, 8.311, 16.4, 8.311];
well_wall_thick=0.40;
well_depth=0.50;

translate([-kc_wide[kmod]/2, -top_to_sw_center[kmod], 0]) {
    // Debug label insert
//    translate([well_wall_thick, well_wall_thick, kc_tall-well_depth]) 
//        color("red", 0.2)
//            cube([kc_wide[kmod]-well_wall_thick*2, kc_high[kmod]-well_wall_thick*2, well_depth]);
//    echo(kc_wide[kmod]-well_wall_thick*2, kc_high[kmod]-well_wall_thick*2);
    
    difference() {
        // keycap body
        union() {
            cube([kc_wide[kmod], kc_high[kmod], kc_tall]);
        }
        // Debug
        //translate([kc_wide[kmod]/2, -eps, -eps]) cube(99);
        // led cavity
        if (led_y[kmod] > 0) {
            translate([led_x, led_y[kmod], led_flange_high-eps*2]) cube([led_wide[kmod], led_high[kmod], 99]);
            translate([kc_wide[kmod]/2, led_y[kmod]+led_high[kmod]/2, -eps]) cylinder(led_flange_high, led_flange_rad, led_flange_rad);
        }
        // top well cavity
        translate([well_wall_thick, well_wall_thick, kc_tall-well_depth])
            cube([kc_wide[kmod]-well_wall_thick*2, kc_high[kmod]-well_wall_thick*2, 99]);
        // key mate cavity
        translate([kc_wide[kmod]/2, top_to_sw_center[kmod], -eps])
            cylinder(5, 2.5, 2.5);
    }
}

// fix thin wall near led
if (kmod == 1) {
    translate([-2.5, -top_to_sw_center[kmod]-0.8+eps, 0]) cube([5, 0.8, led_flange_high+0.5]);
}

// key mate
union() {
    include <cherry-female.scad>;
}