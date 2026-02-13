$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

m25h_holes=[[-2.75-1.5, 2.75],
            [-2.75-1.5, 2.75-13.25+49.5],
            [-2.75-1.5, 2.75-13.25+85.75],
            [-2.75-1.5, -2.75-1.5],
            [87.6+8-43.25, -2.75-1.5],
            [87.6+8-2.75, -2.75-1.5],
            [-2.75-1.5, 2.75-13.25+85.75+1.5+2.75*2],
            [87.6+8-43.25, 2.75-13.25+85.75+1.5+2.75*2],
            [87.6+8-2.75, 2.75-13.25+85.75+1.5+2.75*2]];
m25t_holes=[
            [3.05+0.1, 3.05], 
            [3.05+0.1, 71-3.05],
            [87.5+8-3.05+0.1, 3.05], 
            [87.5+8-3.05+0.1, 71-3.05],
            [87.5+8-3.75, 73],
            [87.5+8-3.75, 8]
];
sqkos=[[-11, 2.75-13.25+27.5],
        [-11, 2.75-13.25+52.5],
        [-11, 2.75-13.25+76.7]];

color("darkgrey") difference() {
    union () {
        // under flaps control
        translate([-1.5, -1.5, 0]) cube([9.5, 81, 2.3]);
        translate([87.5, -1.5, 0]) cube([8.0, 81, 2.3]);
        translate([-1.5, -1.5, 0]) cube([90, 5, 2.3]);
        translate([-1.5, 74.5, 0]) cube([90, 5, 2.3]);
        // under joiner-js-trim-warn
        translate([-8.5, -1.5-6.5, 0]) cube([7.0, 81+13, 2.4]);
        translate([-8.5, 11, 0]) cube([7.0, 61, 5.4]);
        // under bottom blank panel
        translate([0, -1.5-6.5, 0]) cube([95.5, 6.5, 4.7]);
        // under top blank panel
        translate([0, 79.5, 0]) cube([95.5, 6.5, 4.7]);;
        // fill little gaps
        translate([-1.5, -1.5-6.5, 0]) cube([1.5, 6.5, 2.4]);
        translate([-1.5, 79.5, 0]) cube([1.5, 6.5, 2.4]);
    }
    for (h=m25h_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_hole, m25_hole);
    }
    for (h=m25t_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, m25_thrd, m25_thrd);
    }
    for (h=sqkos) {
        translate([h[0], h[1], -eps]) cube([7, 7, 99]);
    }
}

// Debug flaps location
//translate([-eps, 0, 6.5+2.3]) {
//    import("flaps-control-mockup-0.stl");
//}

echo(28.5-7, 28.5-7-3.75, 28.5-7-3.75+1.5+3.75+3.75, 26.75-3.75+41.75);