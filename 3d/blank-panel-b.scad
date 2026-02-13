$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Panel dims
pan_x=281; // 33.75;
pan_xa=143.1;
pan_y=28;
pan_thick=3.4;
pan_rad=2;
pcb_screw_deep=pan_thick+eps*2;
corner_screw_holes=[[2.75, 6],
                    [14, 6],
                    [pan_xa-2.75, 6],
                    [2.75, pan_y-2.75],
                    [14, pan_y-2.75],
                    [pan_xa-2.75, pan_y-2.75],
                    [43.25, 6],
                    [pan_xa-43.25, 6],
                    [43.25, pan_y-2.75],
                    [pan_xa-43.25, pan_y-2.75],
                    [pan_xa+1.5+2.75, 6],
                    [pan_xa+1.5+2.75, pan_y-2.75],
                    [pan_x-2.75, 6],
                    [pan_x-2.75, pan_y-2.75],
                    [pan_x-14, 6],
                    [pan_x-14, pan_y-2.75],
                    [pan_x-68.2, 6],
                    [pan_x-68.2, pan_y-2.75],
                    ];                    

// alignment slots
as_wide=0.9;
as_long=4.2;
as_high=2;
                    
// Debug 220 mm volume
//translate([-pan_y/2+1.05, -pan_y/2, -1]) rotate([0, 0, -45]) cube([220, 220, 1]);                    

// rotate([180, 0, 0]) translate([0, 0, -pan_thick]) 
difference() {
    union() {
        // base panel
        linear_extrude(pan_thick) hull() {
            translate([pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
            translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
        }
    }

    // corner screw holes
    for (h=corner_screw_holes) {
        translate([h[0], h[1], -eps]) cylinder(pcb_screw_deep, m25_thrd, m25_thrd);
        echo(h[0]+136.4+1.5);
    }
    
    // alignment slots
    translate([1.25-as_wide/2, pan_y/2-as_long/2, pan_thick-as_high]) cube([as_wide, as_long, as_high]);
    for (x=[5:265/11:270]) {
        translate([x-0.1, 1.25-as_wide/2, pan_thick-as_high]) cube([as_long, as_wide, as_high]);
        translate([x-0.1, pan_y-1.25-as_wide/2, pan_thick-as_high]) cube([as_long, as_wide, as_high]);
    }
}

// color("pink") translate([5, 0, 0]) cube([3, 0.8, 9]);
