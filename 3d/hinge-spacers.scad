$fn=180;
eps=0.01;

space_wide=0.7;
or=3.50/2;
ir=1.05;

hinge_col_rad=8.50/2;
hinge_pin_rad=4.60/2;

for (x = [0:1]) {
    translate([x*12, 0, 0]) difference() {
        cylinder(space_wide, hinge_col_rad, hinge_col_rad);
        translate([0, 0, -eps]) cylinder(99, hinge_pin_rad, hinge_pin_rad);
    }
}