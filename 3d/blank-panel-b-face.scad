$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Panel dims
pan_x=281;
pan_xa=143.1;
pan_y=28;
pan_thick=1.3;
pan_rad=2;

window_corners=[[8, 5, eps],
                [8, pan_y-5, eps],
                [pan_x-15, pan_y-5, eps],
                [pan_x-15, 5, eps]];
echo(pan_x-15-8);
card_deep=0.4;
card_y=pan_y-3.4;
glass_thick=0.3;

finger_rad=5;

// alignment slots
as_wide=0.7;
as_long=4;
as_high=1;
                
// Debug 220 mm volume
//translate([-pan_y/2+1.05, -pan_y/2, -1]) rotate([0, 0, -45]) cube([220, 220, 1]);                    

rotate([180, 0, 0]) translate([0, 0, -pan_thick]) difference() {
    union() {
        // base face
        linear_extrude(pan_thick) hull() {
            translate([pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
            translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
        }
        // alignment slots
        translate([1.35-as_wide/2, pan_y/2-as_long/2, -as_high]) cube([as_wide, as_long, as_high]);
        for (x=[5:265/11:270]) {
            translate([x, 1.35-as_wide/2, -as_high]) cube([as_long, as_wide, as_high]);
            translate([x, pan_y-1.35-as_wide/2, -as_high]) cube([as_long, as_wide, as_high]);
        }
    }

    // bevelled window
    layers=pan_thick*10+1;
    for (n=[1:layers]) {
        translate([0, 0, pan_thick-0.1-layers/10+n*0.1]) linear_extrude(99) 
                offset(1.2+n*0.1+(n==layers ? 0.3 : 0)) hull() {
            for (c = window_corners) {
                translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
            }
        }
    }
    
    // window glass
    translate([2, pan_y/2-card_y/2, -eps+card_deep]) cube([pan_x-13, card_y, glass_thick+eps]);

    // card slot
    translate([2, pan_y/2-card_y/2, -eps]) cube([999, card_y, card_deep+eps]);
    
    // finger ko
    translate([pan_x-2, pan_y/2, -eps]) cylinder(pan_thick+eps*2, finger_rad, finger_rad);
    translate([pan_x-2, pan_y/2-finger_rad, -eps]) cube([99, finger_rad*2, 99]); 
    translate([pan_x-1, pan_y/2-finger_rad-1, -eps]) difference() {
        cube([99, 2, 99]);
        translate([0, 0, 0]) cylinder(99, 1, 1);
    }
    translate([pan_x-1, pan_y/2+finger_rad-1, -eps]) difference() {
        cube([99, 2, 99]);
        translate([0, 2, 0]) cylinder(99, 1, 1);
    }
}