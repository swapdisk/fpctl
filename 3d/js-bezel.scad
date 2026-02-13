$fn=360;
eps=0.01;

// Sphere
dome_thick=1.0;
dome_rad=18.885+0.5+dome_thick;
dome_y=3.00;

// Bezel dims
bez_xy=37.00;
bez_rad=5.00/2;
bez_high=13.00;
bez_thick=2.50;
bez_cone=24.00;

// Alignment tabs
at_rad=2.00;
at_high=2.00;
at_pos=14.24;

difference() {
    union() {
        // bezel
        difference() {
            // bezel body
            linear_extrude(bez_high) hull() {
                translate([bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
                translate([-bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
                translate([bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
                translate([-bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
            }
            // bezel cone
            translate([0, 0, -dome_y]) cylinder(dome_rad, 0, bez_cone);
        }
    }
    // subtract alignment tab cavities
    translate([at_pos, at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
    translate([at_pos, -at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
    translate([-at_pos, at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
    translate([-at_pos, -at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
    
    // subtract below bezel
    translate([-49, -bez_xy/2-99, -eps]) cube([99, 99, bez_high-bez_thick]);
    translate([-bez_xy/2-99, -49, -eps]) cube([99, 99, bez_high-bez_thick]);
    translate([-49, bez_xy/2, -eps]) cube([99, 99, bez_high-bez_thick]);
    translate([bez_xy/2, -49, -eps]) cube([99, 99, bez_high-bez_thick]);
    
    // subtract inner sphere
    translate([0, 0, -dome_y-1]) sphere(dome_rad);

    // subtract bottom
    translate([-49, -49, -99]) cube(99);
    
    // Debug
    //translate([0, -99, -eps]) cube(99);
    //rotate([0, 0, 45]) translate([0, -99, -eps]) cube(99);
}

// Debug cone width
//q=37.67;
//translate([0, -q/2, -eps]) cube([eps, q, 20]);

// Debug cone opening
//o_xy=21.26;
//translate([-o_xy/2, -o_xy/2, 0]) cube([o_xy, o_xy, 20]);
