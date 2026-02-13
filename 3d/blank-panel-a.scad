$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Panel dims
pan_x=143.1;
pan_y=15;
pan_thick=4.1;
pan_rad=2;
pcb_screw_deep=pan_thick-0.5;
corner_screw_holes=[[2.75, 2.75],
                    [pan_x-2.75, 2.75],
                    [2.75, pan_y-2.75],
                    [pan_x-2.75, pan_y-2.75],
                    [43.25, 2.75],
                    [pan_x-43.25, 2.75],
                    [43.25, pan_y-2.75],
                    [pan_x-43.25, pan_y-2.75]];                    

rotate([180, 0, 0]) translate([0, 0, -3.4]) difference() {
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
}