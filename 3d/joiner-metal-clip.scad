$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;

m2_holes=[[3.75, 2], [3.75, 32]];

// joiner dims
j_wide=6.75;

// metal bit dims
mb_wide=5.30;
mb_high=1.87;
top_slot=mb_wide-1;

difference() {
    union () {
        cube([j_wide, 34, 3]);
        translate([0, 5, 0]) cube([j_wide, 24, 6]);
    }
    // slot for metal bit
    translate([j_wide/2-mb_wide/2, 0, 3]) cube([mb_wide, 99, mb_high]);
    translate([j_wide/2-top_slot/2, 0, 3+mb_high-eps]) cube([top_slot, 99, mb_high]);
    
    for (h=m2_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m2_hole, m2_hole);
    }
}


