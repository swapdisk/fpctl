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

stop_wide=259.5;
stop_off=103;

// tab carve outs
bw_x=[26-12, 68-12, 110-12, 164+18, 206+18, 248+18];

// screws
screw_holes=[-78, -36, 6, 60, 102, 144];

// carve outs for OLED mounting screws and venting
oled_carve=[[-92, 30], [-49, 23], [22, 18], [72, 53], [137, 29]];

rotate([90, 0, 0])
color("lightgrey") {
    difference() {
        union() {
            translate([-stop_off, -2, -2]) cube([stop_wide, 10.844, 8]);
            translate([-stop_off, 10, 0]) rotate([-30, 0, 0]) 
                translate([0, -6, -2.309]) cube([stop_wide, 6, 15.169]);
            translate([20, -2, -2]) cube([22, 10, 10]);
        }
        // screw holes
        for (x=screw_holes) {
            translate([x, 5.669, -2-eps]) cylinder(99, m25_hole, m25_hole);
            translate([x, 5.669, 3]) cylinder(99, m25_head+1, m25_head+1);
        }
        
        // carve out for back mating screw
        translate([22, 2.6, -2-eps]) cube([18, 99, 6]);
        //translate([22, 2.6, -2-eps]) cube([18, 99, 99]);

        // carve out for back support rib
        translate([27.5, -2-eps, -2-eps]) cube([11, 6, 2.2]);
        
        // carve outs for OLED mounting screws and venting
        for (h=oled_carve) {
            translate([h[0], 6, 6]) cube([h[1], 12, 99]);
        }
        
        // carve outs for vent panel tabs
        for (x=bw_x) {
            difference() {
                translate([x-118, -2-eps, -2-eps]) cube([14, 99, 2.2]);
                translate([x-111, 5.66, -0.1]) cylinder(0.3, m25_thrd, m25_thrd);
                translate([x-111, 5.66, -0.1]) sphere(m25_thrd); // cylinder(1, m25_thrd, m25_thrd);
            }
        }
        
        // carve out for fcu p3 panel
        translate([-stop_off-eps, -2-eps, 2]) cube([11.5, 99, 99]);
        translate([-stop_off-eps, -2-eps, -eps]) cube([4.5, 99, 99]);
        translate([-stop_off-eps, -17.37, -eps]) rotate([0, 0, 45]) cube([19, 19, 19]);
        
        // Debug print
        //translate([-99, -10, -10]) cube(99+10);
        //translate([80, -10, -10]) cube(99+10);
    }
}
