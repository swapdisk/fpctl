$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;
p815_thrd=3.70/2;
p815_hole=4.10/2;
p815_head=11.20/2;
p815_deep=13.50;

// case bottom left dims
base_long=187.436;
base_wide=143.5;
base_thick=4.0;
base_rad=12.0;

// wall mating dims
wm_high=p815_deep-2;
wm_wide=12;
wm_holes=[[19, 5], [68.75, 5], [128.5, 5],
    [5, 18.215], [5, 68.215], [5, 118.215], [5, 168.215],
    [19, base_long-5], [68.75, base_long-5], [128.5, base_long-5],
    ];
    
// base sides mating dims
bs_high=p815_head*2+3;
bs_wide=bs_high;
bs_thick=4;
bs_y=[16:47:157];

// speaker dims
spk_wide=102.50;
spk_hoff=9.4;
spk_holes=[[spk_hoff, spk_hoff], [spk_hoff, spk_wide-spk_hoff], [spk_wide-spk_hoff, spk_hoff], [spk_wide-spk_hoff, spk_wide-spk_hoff]];
spk_stud_high=10.00;
spk_stud_rad=p815_head;

// Debug projection
//projection(cut=true) translate([0, 0, 35]) rotate([0, 90, 0]) {
union() {

// debug wall section
//translate([base_wide, -6, wm_high]) rotate([070, 0, 180]) {
//    include<case-front-panel-left.scad>;
//}
//translate([-6, -17.785-6, wm_high]) rotate([90, 0, 90]) {
//    include<case-side-left-panel.scad>;
//}

difference() {
    union() {
        // base pan
        cube([base_wide, base_long, base_thick]);
        
        // wall mating ridges
        cube([base_wide, wm_wide, wm_high]);
        cube([wm_wide, base_long, wm_high]);
        translate([0, base_long-wm_wide, 0]) cube([base_wide, wm_wide, wm_high]);
    
        // side mating bits and support
        for (y=bs_y) {
            // screw side
            //translate([base_wide-bs_thick, y+bs_wide/2, base_thick+bs_wide/2]) 
            //    rotate([0, 90, 0]) cylinder(bs_thick, bs_wide/2, bs_wide/2);
            // threads side
            translate([base_wide-p815_deep, y+bs_wide/2, base_thick+bs_wide/2]) 
                rotate([0, 90, 0]) cylinder(p815_deep, bs_wide/2, bs_wide/2);
            translate([base_wide-p815_deep, y, 0]) 
                cube([p815_deep, bs_wide, base_thick+bs_wide/2]);
        }
        translate([base_wide-bs_thick, 0, 0]) cube([bs_thick, base_long, wm_high]);
        
        // speaker
        translate([base_wide/2-spk_wide/2, wm_wide+5, base_thick]) {
            for (h=spk_holes) {
                translate([h[0], h[1], 0]) cylinder(spk_stud_high, spk_stud_rad, spk_stud_rad);
            }
        }
    }
    // round corners
    translate([0, 0, -eps]) difference() {
        translate([0, 0, eps]) cube([base_rad, base_rad, 99]);
        translate([base_rad, base_rad, 0]) cylinder(99, base_rad, base_rad);
    }
    translate([0, base_long, -eps]) difference() {
        translate([0, -base_rad, eps]) cube([base_rad, base_rad, 99]);
        translate([base_rad, -base_rad, 0]) cylinder(99, base_rad, base_rad);
    }
    
    // wall mounting holes
    for (h=wm_holes) {
        translate([h[0], h[1], 1]) cylinder(p815_deep-2, p815_thrd, p815_thrd);
        // vents
        if (h[0]>5 && h[0]<100) {
            translate([h[0]+6, h[1]-8, 7]) cube([38, 16, 99]);
        }
        if (h[0]==5 && h[1]<120) {
            translate([h[0]-8, h[1]+5, 7]) cube([16, 40, 99]);
        }
    }
    
    // side mating holes
    for (y=bs_y) {
        // screw side
        //translate([base_wide-bs_thick-eps, y+bs_wide/2, base_thick+bs_wide/2]) 
        //    rotate([0, 90, 0]) cylinder(99, p815_hole, p815_hole);
        //translate([base_wide-bs_thick-eps, y+bs_wide/2, base_thick+bs_wide/2]) 
        //    rotate([0, 90, 0]) cylinder(bs_thick/2, p815_head, p815_head);
        // threads side
        translate([base_wide-p815_deep+1, y+bs_wide/2, base_thick+bs_wide/2]) 
            rotate([0, 90, 0]) cylinder(99, p815_thrd, p815_thrd);
    }
    
    // speaker
    translate([base_wide/2-spk_wide/2, wm_wide+5, base_thick]) {
        // screws
        for (h=spk_holes) {
            translate([h[0], h[1], -base_thick+1]) cylinder(99, p815_thrd, p815_thrd);
        }
        
        // shave studs
        translate([spk_wide/2, spk_wide/2, 0]) cylinder(11, spk_wide/2+4, spk_wide/2+4);

        // speaker cone circle
        translate([spk_wide/2, spk_wide/2, -base_thick+2]) cylinder(99, spk_wide/2-4, spk_wide/2-4);
        
        // grille
        hex=6;
        offx=30;
        offy=70;
        numx=4;
        numy=7;
        thick=1.3;
        rad=3;
        a=sqrt(hex/2)/2*rad;
        for (x = [0:numx-1]) {
            for (y = [0:numy-1]) {
                translate([offx+x*rad*3+x*thick*a/rad*2, offy-y*a*2-y*thick, -9])
                    cylinder(99, rad, rad, $fn=hex);
                translate([offx+(x*2+1)*rad*1.5+(x*2+1)*thick*a/rad, offy+(-y*a*2-y*thick)+a+thick/2, -9])
                    cylinder(99, rad, rad, $fn=hex);
            }
        }
    }

}
} // projection
