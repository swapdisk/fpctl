$fn=90;
// height
h=8;
// outside rad top
ort=14.24/2;
// outside rad bottom
orb=14.12/2;
// inside rad top
irt=ort-2.4;
// inside rad bottom
irb=orb-2.0;

difference() {
    cylinder(h, orb,  ort);
    translate([0, 0, -0.01]) {
        cylinder(h+0.02, irb,  irt);
        rotate([0, 0, 30]) cube(99);
        rotate([0, 0, -50]) cube(99);
        rotate([0, 0, -120]) cube(99);
    }
}

translate([-irb-1, -1.5, 0]) cube([1, 3, 20]);

echo(h);