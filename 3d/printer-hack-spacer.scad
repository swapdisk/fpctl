$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
cr_hole=3.40/2;
cr_head=6.20/2;

spacer_ir=4.10/2;
spacer_or=8.05/2;
spacer_thick=3.10;

difference() {
    union() {
        cylinder(0.1, spacer_or+0.80, spacer_or+0.80);
        translate([0, 0, 0.1]) cylinder(spacer_thick, spacer_or+1, spacer_or);
    }
    translate([0, 0, -eps]) cylinder(99, spacer_ir, spacer_ir);
}    