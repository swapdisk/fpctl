$fn=180;
eps=0.01;

mounting_hole_rad=3.06/2;
mounting_head_rad=4.60/2;
mounting_threads_rad=2.46/2;
mounting_hole_x=26.9;
wire_lead_rad=1.10;
body_hull_rad=3.30;
body_thick=5.30;
x_sw_body=12.00;
y_sw_body=10.80;
x_sw_cavity=6.30;
y_sw_cavity=6.26;
cavity_deep=3.60;
throw_wide=20.50;
throw_deep=1.04;

difference() {
    union() {
        // cross member
        linear_extrude(body_thick) hull() {
            circle(body_hull_rad);
            translate([mounting_hole_x, 0, 0]) circle(body_hull_rad);
        }
        // switch body'
        translate([mounting_hole_x/2-x_sw_body/2, -y_sw_body/2, 0]) 
            cube([x_sw_body, y_sw_body, body_thick]);
    }
    // mounting holes
    translate([0, 0, -eps]) cylinder(99, mounting_hole_rad, mounting_hole_rad);
    translate([0, 0, 2.5-eps]) cylinder(0.6, mounting_head_rad, mounting_hole_rad);
    translate([0, 0, -eps]) cylinder(2.5, mounting_head_rad, mounting_head_rad);
    translate([mounting_hole_x, 0, 0.5]) cylinder(99, mounting_threads_rad, mounting_threads_rad);
    translate([mounting_hole_x, 0, body_thick-1+eps]) cylinder(1, mounting_threads_rad, mounting_threads_rad+0.5);
    // switch area
    translate([0, -1.55 , 0]) {
        // switch cavity
        translate([mounting_hole_x/2-x_sw_cavity/2, -y_sw_cavity/2, body_thick-cavity_deep-throw_deep+eps]) 
                cube([x_sw_cavity, y_sw_cavity, cavity_deep+throw_deep]);
        // wire lead holes
        translate([mounting_hole_x/2-x_sw_cavity/2, -y_sw_cavity/2+wire_lead_rad, -eps])
            cylinder(99, wire_lead_rad, wire_lead_rad);
        translate([mounting_hole_x/2-x_sw_cavity/2, y_sw_cavity/2-wire_lead_rad, -eps])
            cylinder(99, wire_lead_rad, wire_lead_rad);
        translate([mounting_hole_x/2+x_sw_cavity/2, -y_sw_cavity/2+wire_lead_rad, -eps])
            cylinder(99, wire_lead_rad, wire_lead_rad);
        translate([mounting_hole_x/2+x_sw_cavity/2, y_sw_cavity/2-wire_lead_rad, -eps])
            cylinder(99, wire_lead_rad, wire_lead_rad);
    }
    // button throw space
    translate([mounting_hole_x/2-throw_wide/2, -x_sw_body, body_thick-throw_deep])
        cube([throw_wide, x_sw_body*2, 99]);
    // encoder carve out
    translate([mounting_hole_x/2-throw_wide/2, body_hull_rad-1, -eps])
        cube([throw_wide, x_sw_body*2, 99]);
    // Debug
    //translate([0, 0, -eps]) cube(99);
}


// Debug thread rad
//body_thick=4.20;
//difference() {
//    union() {
//        // cross member
//        linear_extrude(body_thick) hull() {
//            circle(body_hull_rad);
//            translate([mounting_hole_x, 0, 0]) circle(body_hull_rad);
//        }
//        for (i = [1:7]) {
//            translate([(i-1)*4.4, 0, 0.5]) cylinder(99, mounting_threads_rad+i*0.01, mounting_threads_rad+i*0.01);
//            translate([(i-1)*4.4, 0, body_thick-1+eps]) cylinder(1, mounting_threads_rad+i*0.01, mounting_threads_rad+i*0.01+0.5);
//            echo ((mounting_threads_rad+i*0.01)*2);
//    }
//}