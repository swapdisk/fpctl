$fn=360;
eps=0.01;

off=-0.25; // i.e., x=1.5

// triangle
//for (x=1.5) {   // [0:0.5:3]) {
//    echo(-0.1-x*0.1);
//    translate([x*19, 0, 0]) linear_extrude(0.5) offset(r=-0.1-x*0.1) import("knob-hdg-triangle.svg");
//}
// circle
for (x=[0:0.5:3]) {
    echo(-0.1-x*0.1);
    translate([x*32, 0, 0]) linear_extrude(0.5) offset(r=-0.1-x*0.1) import("knob-spd-circle.svg");
    translate([x*32+8, 15, 0]) linear_extrude(0.5) offset(r=-0.1-x*0.1) import("knob-spd-circle.svg");
}
// translate([0, 0.3, 0]) color("grey") cube([4, 0.4, 0.4]);