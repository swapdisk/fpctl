$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

//m25h_holes=[[3, 3.75], [199, 3.75], [41.19, 3.75], [108, 3.75], [168.39, 3.75],
//            [3, 12.75], [199, 12.75], [108, 12.75]];
//m2t_holes=[[41.19, 13.26], [168.39, 13.26]];
//sqkos=[[112, -3], [187, -3], [43.5, 11], [110.5, 11], [156.5, 11], [189, 11]];

m25h_holes=[[4.2, 21.75],
//4.08-2.75
[69.65, 22.75],
[69.65, 29.75],
[68.65, 29.75-2.75+6.675+4.08],
[68.65, 29.75-2.75+6.675+41.22],
[76.65, 6.25],
[117.15, 6.25],
[76.65, 13.25],
[117.15, 13.25],
//[96.9, 13.25],
[76.65, 49.5],
[76.65, 85.75],
[96.9, 85.75],
[117.15, 85.75],
[76.65, 92.75],
[117.15, 92.75]];

sqkos=[[8, 17], [13.2, 17],
 [77.2, 27.5],
 [77.2, 52.5],
 [77.2, 76.7]];

// PCB dims
pcb_x=80;
pcb_y=20;
pcb_thick=1.6;
off_x=30;
off_y=20.5;

// PCB screws
pcb_screws=[[off_x+2, off_y/2-pcb_y/2+2],
            [off_x+pcb_x-2, off_y/2-pcb_y/2+2],
            [off_x+pcb_x-2, off_y/2-pcb_y/2+pcb_y-2],
            [off_x+2, off_y/2-pcb_y/2+pcb_y-2]];

hack_thick=6;
        
color("pink") translate([0, 0, -hack_thick]) {
    difference() {
        union() {
            translate([-1, 24, 0]) cube([9, 8, hack_thick-2.3]);
            translate([0, 20, 0]) cube([8, 5, hack_thick-2.3]);
            translate([-54.5, 24, 0]) cube([53.5, 8, hack_thick]);
            echo(8-5.3);
        }
        for (h=m25h_holes) {
            translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
        }
        translate([4.2-m25_hole, 21.75-9, -eps]) cube([m25_hole*2, 9, 99]);
    }
}
             
//difference() {
//    union () {
//        // bottom rect joining trim and blank
//        translate([20.2, 0, 0]) cube([99.7, 20.5, 2.3]);
//        // rect joining trim to js above
//        translate([20.2, 0, 0]) cube([60.0, 33, 2.3]);
//        // branch to reach trim center screw
//        translate([0, 20.0, 0]) cube([80.2, 13, 2.3]);
//        // bottom left of warn panel 
//        translate([73.9, 10.5, 0]) cube([46, 10, 3.0]);
//        translate([73.9, 10.5, 0]) cube([7, 78, 3.0]);
//        translate([73.9, 10.5+78-4.8, 0]) cube([46, 4.8, 3.0]);
//        // join to top blank panel
//        translate([73.9, 10.5+78, 0]) cube([46, 8, 2.3]);
//        // join under js pcb mounts
//        translate([64, 0, 0]) cube([11, 96.5, 2.3]);
////        // pcb studs
////        for (x=pcb_screws) {
////            translate([x[0], x[1], -pcb_stud_high]) cylinder(pcb_stud_high, pcb_stud_rad, pcb_stud_rad);
////        }
//    }
//    for (h=m25h_holes) {
//        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
//    }
////    for (h=m2t_holes) {
////        translate([h[0], h[1], -eps]) cylinder(99, m2_thrd, m2_thrd);
////    }
//    for (h=sqkos) {
//        translate([h[0], h[1], -eps]) cube([7, 7, 99]);
//    }
//    // pcb screw holes
//    for (x=pcb_screws) {
//        translate([x[0], x[1], -eps]) cylinder(99, m2_thrd, m2_thrd);
//    }
//}
