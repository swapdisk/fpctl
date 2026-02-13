$fn=360;
eps=0.01;

// inserts of varying sizes to find perfect fit
// arrow pos
for (x=[-3.0:0.5:-2.0]) {
    translate([x*19-10, 0, 0]) linear_extrude(0.5) offset(r=-0.1-x*0.1) import("fcu-p1-vs-arrows.svg");
}

// div lines
for (x=[-1.38, -1.25]) {
    translate([x*20, 0, 0]) linear_extrude(0.5) offset(r=-0.1-x*0.1) hull() {
        circle(0.4);
        translate([0, 38.4, 0]) circle(0.4);
    }
    translate([x*20+10, 0, 0]) linear_extrude(0.5) offset(r=-0.1-x*0.1) hull() {
        circle(0.4);
        translate([0, 38.4, 0]) circle(0.4);
    }
}

// cirlces
or=5.84;
ir=5.34;
for (n=[0:2]) {
    translate([0, n*15, 0]) difference() {
        cylinder(0.7, or, or);
        translate([0, 0, -eps]) cylinder(99, ir, ir);
    }
}