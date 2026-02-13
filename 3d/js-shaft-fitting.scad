$fn=360;
eps=0.01;

high=27.34;
orad=4.40/2;
irad=3.20/2;

difference() {
    cylinder(high, orad, orad);
    translate([0, 0, -eps]) cylinder(99, irad, irad);
}