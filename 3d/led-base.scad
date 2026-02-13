$fn=180;
eps=0.01;

rad=5.50/2;
pin=1.15/2;
thick=1.4;
for (x=[0:5]) {
    translate([x*10, 0, 0]) difference() {
        cylinder(thick, rad, rad);
        translate([rad-0.35, -49, -49]) cube(99);
        translate([2.54/2, 0, -thick-eps]) cylinder(99, pin, pin);
        translate([-2.54/2, 0, -thick-eps]) cylinder(99, pin, pin);
    }
}