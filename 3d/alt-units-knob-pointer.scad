$fn=180;
eps=0.01;

att_high=3.00;
fl_rad=0.3;

// Adhesion plate
//cylinder(1, 4, 4);

// Pointer
for (x=[3]) {
    translate([0, 0, x*att_high+1]) linear_extrude(att_high) offset(r=x*-0.03) hull() {
        translate([0, fl_rad+1.1, 0]) circle(eps);
        translate([1, fl_rad-1.8, 0]) circle(eps);
        translate([-1, fl_rad-1.8, 0]) circle(eps);
    }
}
