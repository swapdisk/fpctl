$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
cr_hole=3.40/2;
cr_head=6.20/2;

base_wide=32;
base_high=30;
base_thick=4.4;
mount_holes_xy=[[base_wide/2-12, 6.5], [base_wide/2+12, 6.5]] ;
clamp_wide=9;
clamp_high=22;
tube_rad=4.20/2; // actual is 4.00 mm
slot_wide=1;
slot_deep=2.3;
slot_dig=clamp_wide/2-slot_wide/2-2.5;
//slot_rad=2.5;
shaft_rad=4.10/2;
shaft_sq=3.82;
sq_deep=1.74;

difference() {
    union() {
        // main base
        cube([base_wide, base_high, base_thick]);
        // clamp section
        translate([base_wide/2-clamp_wide/2, 0, base_thick]) cube([clamp_wide, base_high, clamp_high]);
    }
    // mounting holes
    for (h=mount_holes_xy) {
        translate([h[0], h[1], -eps]) {
            cylinder(99, cr_hole, cr_hole);
            translate([0, 0, 2.9]) cylinder(99, cr_head, cr_head);
        }
    }
    // tube
    rotate([270, 0, 0]) translate([base_wide/2, -10, -eps]) cylinder(99, tube_rad, tube_rad);
    rotate([270, 0, 0]) translate([base_wide/2, -10, -eps]) cylinder(1, tube_rad+0.5, tube_rad);
    rotate([270, 0, 0]) translate([base_wide/2, -10, base_high-1+eps]) cylinder(1, tube_rad, tube_rad+0.5);
    
    // slots
    translate([base_wide/2-slot_wide/2, -eps, base_thick-slot_deep]) cube([slot_wide, 99, 99]);
    // slot angle
    translate([base_wide/2-slot_wide/2, -eps, base_thick-slot_deep+3.5]) 
        rotate([0, -2.4, 0]) cube([slot_wide, 99, 99]);
    translate([base_wide/2-slot_wide/2, -eps, base_thick-slot_deep+3.55]) 
        rotate([0, 2.4, 0]) cube([slot_wide, 99, 99]);

    // slot dig trench
    translate([base_wide/2-clamp_wide/2-slot_wide, -eps, base_thick-slot_deep]) 
        cube([slot_wide+slot_dig, 99, slot_deep+slot_dig]);
    translate([base_wide/2+clamp_wide/2-slot_dig, -eps, base_thick-slot_deep]) 
        cube([slot_wide+slot_dig, 99, slot_deep+slot_dig]);
//    rotate([270, 0, 0]) translate([base_wide/2+clamp_wide/2, -base_thick, -eps]) 
//        cylinder(99, slot_rad, slot_rad);
//    rotate([270, 0, 0]) translate([base_wide/2+clamp_wide/2, -base_thick, -eps]) 
//        cylinder(99, slot_rad, slot_rad);
    // clamp knob shaft
    rotate([0, 90, 0]) translate([-base_thick-clamp_high*3/4, base_high/2, 0]) 
        cylinder(base_wide/2+clamp_wide/2-sq_deep, shaft_rad, shaft_rad);
    // clamp knob square
    translate([base_wide/2+clamp_wide/2-sq_deep, base_high/2, base_thick+clamp_high*3/4]) 
        rotate([45, 0, 0]) translate([0, -shaft_sq/2, -shaft_sq/2]) cube(shaft_sq);
    echo(clamp_high*2/3, clamp_high*3/4);
}

//rotate([0, 90, 0]) translate([-base_thick-clamp_high*3/4, base_high/2, 0]) cylinder(13, 4, 4);
//rotate([0, 90, 0]) translate([-base_thick-clamp_high*3/4, base_high/2, 0]) cylinder(7.38, 10, 10);