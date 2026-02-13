$fn=180;
eps=0.01;

total_rad=51/2;
collar_rad=10.88/2;
screw_rad=6.9/2;
adj=-13.15+8;

thick=19.05+adj;
num="7";

difference() {
    cylinder(thick, total_rad, total_rad);
    translate([0, 0, -eps]) cylinder(99, screw_rad, screw_rad);
    translate([0, 0, 5]) cylinder(99, collar_rad, collar_rad);
    translate([0, -total_rad+5, thick-0.4])
        linear_extrude(height=99)
        text(num, size=8, 
            font="Routed Gothic:style=Regular", halign="center");
}