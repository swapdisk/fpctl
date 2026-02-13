$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m2_head=4.20/2;
m2_lg_head=6.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;


// joiner dims
j_wide=24+14;
j_deep=12.5;
j_high=6.75+1.5;

m2_holes=[[3.3, 3.25], [j_wide-3.3, 3.25]];

// magnet dims
mag_wide=20.04;
mag_deep=9.50;
mag_high=2.60;
mag_z=3.75+1.5;

//translate([j_wide, -10, 1.5]) rotate([00, 270, 90]) {
//    include<joiner-mag-left.scad>;
//}

difference() {
    union () {
        cube([j_wide, j_deep, 0.9]);
        translate([7, 0, 0]) cube([j_wide-14, j_deep, j_high]);
    }
    // slot for magnet
    translate([j_wide/2-mag_wide/2, -2, mag_z-mag_high/2]) cube([mag_wide, mag_deep, mag_high]);

    // magnet set screw
    translate([j_wide/2, mag_deep/2, -eps]) cylinder(mag_z, m2_thrd, m2_thrd);
    translate([j_wide/2, mag_deep/2, -eps]) cylinder(mag_z-mag_high/2-2.5, m2_head, m2_head);
    
    for (h=m2_holes) {
        translate([h[0], h[1], -eps]) linear_extrude(99) hull() {
            circle(m2_hole);
            translate([0, 6, 0]) circle(m2_hole);
        }
    }
}


