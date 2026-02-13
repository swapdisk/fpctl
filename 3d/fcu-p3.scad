$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Panel dims
pan_x=216;
pan_y=28.5;
pan_thick=3.4;
pan_rad=2;

corner_screw_holes=[[3.75, 3.75],
                    [pan_x-3.75, 3.75],
                    [10, 3.75],
                    [pan_x-10, 3.75],
                    [48.19, 3.75],
                    [115, 3.75],
                    [175.39, 3.75],
                    [3.75, pan_y-3.75],
                    [pan_x-3.75, pan_y-3.75],
                    [10, pan_y-3.75],
                    [pan_x-10, pan_y-3.75],
                    [48.19, pan_y-3.75],
                    [115, pan_y-3.75],
                    [175.39, pan_y-3.75]];

echo(corner_screw_holes);
                    
// PCB dims
pcb_x=80;
pcb_y=20;
pcb_thick=1.6;

// PCB screws
pcb_stud_high=5.50;
pcb_stud_rad=4.00/2;
pcb_screws=[[120+2, pan_y/2-pcb_y/2+2],
            [120+pcb_x-2, pan_y/2-pcb_y/2+2],
            [120+pcb_x-2, pan_y/2-pcb_y/2+pcb_y-2],
            [120+2, pan_y/2-pcb_y/2+pcb_y-2]];

// IO board
iob_x=31.36;
iob_y=21.75;
iob_stud_high=5.50;
iob_stud_rad=5.00/2;
iob_screws=[[81, pan_y/2], [107, pan_y/2]];
            
difference() {
    union() {
        // base panel
        linear_extrude(pan_thick) hull() {
            translate([pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
            translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
        }
        // pcb studs
        for (x=pcb_screws) {
            translate([x[0], x[1], -pcb_stud_high]) cylinder(pcb_stud_high, pcb_stud_rad, pcb_stud_rad);
        }
        // iob studs
        for (x=iob_screws) {
            translate([x[0], x[1], -iob_stud_high]) cylinder(iob_stud_high, iob_stud_rad, iob_stud_rad);
        }
    }
    // corner screw holes
    for (h=corner_screw_holes) {
        translate([h[0], h[1], -eps]) cylinder(pan_thick-0.5, m25_thrd, m25_thrd);
    }
    // pcb screw holes
    for (x=pcb_screws) {
        translate([x[0], x[1], -pcb_stud_high-eps]) cylinder(pcb_stud_high, m2_thrd, m2_thrd);
    }
    // iob screw holes
    for (x=iob_screws) {
        translate([x[0], x[1], -iob_stud_high-eps]) cylinder(iob_stud_high, m25_thrd, m25_thrd);
    }
    // mark
    translate([2, pan_y-2, 0]) cylinder(0.2, 0.5, 0.5);
}

// Debug PCB locations
//translate([120, pan_y/2-pcb_y/2, -pcb_stud_high-pcb_thick]) difference() {
//    color("grey") cube([pcb_x, pcb_y, pcb_thick]);
//    translate([2, 2, -eps]) cylinder(99, m2_hole, m2_hole);
//    translate([pcb_x-2, 2, -eps]) cylinder(99, m2_hole, m2_hole);
//    translate([pcb_x-2, pcb_y-2, -eps]) cylinder(99, m2_hole, m2_hole);
//    translate([2, pcb_y-2, -eps]) cylinder(99, m2_hole, m2_hole);
//}
//translate([81-2.7, pan_y/2-iob_y/2, -iob_stud_high-pcb_thick]) difference() {
//    color("grey") cube([iob_x, iob_y, pcb_thick]);
//    translate([2.6, iob_y/2, -eps]) cylinder(99, m25_hole, m25_hole);
//    translate([iob_x-2.6, iob_y/2, -eps]) cylinder(99, m25_hole, m25_hole);
//}
