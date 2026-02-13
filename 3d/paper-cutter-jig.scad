$fn=180;
over_hang=0.40;
over_high=0.11;
rad=0.40;
x=4*25.4;
y=24.35;
thick=1.90;
lip_high=1.04;
lip_wide=50;

// recessed base layer
translate([over_hang, over_hang, 0]) cube([x-over_hang*2, y+lip_wide-over_hang*2, over_high]);

// body over cutting edge
translate([0, 0, over_high]) linear_extrude(thick-over_high) hull() {
    translate([0+rad, 0+rad, 0]) circle(rad);
    translate([x-rad, 0+rad, 0]) circle(rad);
    translate([x-rad, y-rad, 0]) circle(rad);
    translate([0+rad, y-rad, 0]) circle(rad);
}

// body over main table
translate([0, 0, over_high]) linear_extrude(thick-over_high-lip_high) hull() {
    translate([0+rad, 0+rad, 0]) circle(rad);
    translate([x-rad, 0+rad, 0]) circle(rad);
    translate([x-rad, y+lip_wide-rad, 0]) circle(rad);
    translate([0+rad, y+lip_wide-rad, 0]) circle(rad);
}




//cube([x, y, thick-over_high]);


//cube([3*25.4, 24.35, 1.50]);