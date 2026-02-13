$fn=120;

// Params C2 mate
c2_width=3.90;
base_high=0.8;
spline_high=3.90;
spline_t=1.2;

for (i = [0, 120, 240]) {
    translate([0, 0, base_high+spline_high/2]) rotate([0, 0, i]) {
        cube([x_width, spline_t, spline_high], center=true); 
    } 
}

// translate([0, 0, base_high/2]) cube([x_width+1, x_width+1, base_high], center=true);
