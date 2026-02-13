$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

m25h_holes=[[3, 3.75], [199, 3.75], [41.19, 3.75], [108, 3.75], [168.39, 3.75],
            [3, 12.75], [199, 12.75], [108, 12.75]];
m2t_holes=[[41.19, 13.26], [168.39, 13.26]];
sqkos=[[112, -3], [187, -3], [43.5, 11], [110.5, 11], [156.5, 11], [189, 11]];

difference() {
    union () {
        cube([202, 16.0, 2.3]);
        cube([202, 7.5, 3.0]);
    }
    for (h=m25h_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
    }
    for (h=m2t_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m2_thrd, m2_thrd);
    }
    for (h=sqkos) {
        translate([h[0], h[1], -eps]) cube([7, 7, 99]);
    }
}
