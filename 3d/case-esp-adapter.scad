$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;
p815_thrd=3.70/2;
p815_hole=4.10/2;
p815_head=11.20/2;
p815_deep=13.50;

// board dims
b_wide=70;
b_deep=30;
b_stud_high=10.0;
b_stud_rad=4.0/2;
b_holes=[[2, 2], [b_wide-2, 2], [2, b_deep-2], [b_wide-2, b_deep-2]];

// adapter plate holes
ap_holes=[[10, 8], [10, 18], [60, 8], [60, 18]];
// ECHO: [[-10, 5], [-10, 15], [-60, 5], [-60, 15], [-10, 35], [-10, 45], [-60, 35], [-60, 45]]

difference() {
    union() {
        // main plate
        translate([b_stud_rad, 0, 0]) cube([b_wide-b_stud_rad*2, b_deep, 2]);
        translate([0, b_stud_rad, 0]) cube([b_wide, b_deep-b_stud_rad*2, 2]);
        
        // studs
        for (h=b_holes) {
            translate([h[0], h[1], 0]) cylinder(b_stud_high, b_stud_rad, b_stud_rad);
        }
    }
    
    // adapter plate holes
    for (h=ap_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
    }
    
    // board stud holes
    for (h=b_holes) {
        translate([h[0], h[1], 5]) cylinder(99, m2_thrd, m2_thrd);
    }
    
    
}