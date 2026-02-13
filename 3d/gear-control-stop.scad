$fn=180;
eps=0.01;

stop_high=8.50;
stop_screw_high=4.50;
stop_rad=5.50/2;
stop_hole_rad=3.06/2;
stop_head_rad=4.60/2;

difference() {
    cylinder(stop_high, stop_rad, stop_rad);
    translate([0, 0, -eps]) cylinder(99, stop_hole_rad, stop_hole_rad);
    translate([0, 0, stop_screw_high]) cylinder(99, stop_head_rad, stop_head_rad);
    
    // Debug
    //translate([0, 0, -eps]) cube(99);
}