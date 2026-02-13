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
base_wide=136.0;
base_thick=4.0;
base_rad=12.0;

// wall mating dims
wm_high=p815_deep-2;
wm_wide=12;
wm_holes=[[19, 5], [65, 5], [121, 5],
    [5, 18.215], [5, 68.215], [5, 118.215], [5, 168.215],
    [19, base_long-5], [65, base_long-5], [121, base_long-5],
    ];
    
// base sides mating dims
bs_high=p815_head*2+3;
bs_wide=bs_high;
bs_thick=4;
bs_y=[16:47:157];

// usb dims
usb_x=60;
usb_stud_high=1.0;
usb_stud_rad=3.5;
usb_holes=[[usb_x-3.5, 140+34-12], [usb_x-3.5-38, 140+34-12]];

// ESP board dims
esp_x=128;
esp_y=85;
esp_holes=[[esp_x-10, esp_y+5], [esp_x-10, esp_y+15], [esp_x-60, esp_y+5], [esp_x-60, esp_y+15],
        [esp_x-10, esp_y+35], [esp_x-10, esp_y+45], [esp_x-60, esp_y+35], [esp_x-60, esp_y+45]];

// connector board dims
cn_x=128;
cn_y=30;
cn_stud_high=10.0;
cn_stud_rad=4.0/2;
cn_holes=[[cn_x-2, cn_y+2], [cn_x-2, cn_y+48], [cn_x-68, cn_y+2], [cn_x-68, cn_y+48]];

// Debug projection
//projection(cut=true) translate([0, 0, 35]) rotate([0, 90, 0]) {
union() {

// debug wall section
translate([6, -6, wm_high]) rotate([070, 0, 180]) {
   include<case-front-panel-right.scad>;
}
//translate([-6, -17.785-6, wm_high]) rotate([90, 0, 90]) {
//    include<case-side-right-panel.scad>;
//}

// Debug USB board
//translate([-usb_x, 141, 5.0]) difference() {
//    union() {    
//        color("grey") cube([46, 34, 1.6]);
//        color("lightgrey") translate([9, 26.00, 1.6]) cube([9, 7.46, 3]);
//    }
//    translate([3.5, 21, -eps]) cylinder(99, 3.31/2, 3.31/2);
//    translate([3.5+38, 21, -eps]) cylinder(99, 3.31/2, 3.31/2);
//}

// Debug connector board
//translate([-cn_x, cn_y, 14.0]) difference() {
//    union() {    
//        color("grey") cube([70, 50, 1.6]);
//    }
//    translate([2, 2, -eps]) cylinder(99, m2_hole, m2_hole);
//    translate([2, 48, -eps]) cylinder(99, m2_hole, m2_hole);
//    translate([68, 2, -eps]) cylinder(99, m2_hole, m2_hole);
//    translate([68, 48, -eps]) cylinder(99, m2_hole, m2_hole);
//}

// Debug ESP board
translate([-128, 82, 4.0]) difference() {
    union() {    
        //color("grey") cube([70, 25.5, 1.6]);
        include<case-esp-adapter.scad>;
    }
}

mirror([1, 0, 0]) difference() {
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
            translate([base_wide-bs_thick, y+bs_wide/2, base_thick+bs_wide/2]) 
                rotate([0, 90, 0]) cylinder(bs_thick, bs_wide/2, bs_wide/2);
            // threads side
            //translate([base_wide-p815_deep, y+bs_wide/2, base_thick+bs_wide/2]) 
            //    rotate([0, 90, 0]) cylinder(p815_deep, bs_wide/2, bs_wide/2);
            //translate([base_wide-p815_deep, y, 0]) 
            //    cube([p815_deep, bs_wide, base_thick+bs_wide/2]);
        }
        translate([base_wide-bs_thick, 0, 0]) cube([bs_thick, base_long, wm_high]);
        
        // usb studs
        for (h=usb_holes) {
            translate([h[0], h[1], base_thick]) cylinder(usb_stud_high, usb_stud_rad, usb_stud_rad);
        }

        // conn studs
        for (h=cn_holes) {
            translate([h[0], h[1], base_thick]) cylinder(cn_stud_high, cn_stud_rad, cn_stud_rad);
            if (h[1]<40) {
                translate([h[0]-0.4, h[1], base_thick])
                    cube([0.8, 46, 5]);
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
        if (h[0]>5 && h[0]<100 && h[1]==5) {
            translate([h[0]+6, h[1]-8, 7]) cube([35, 16, 99]);
        }
        if (h[0]==5 && h[1]<120) {
            translate([h[0]-8, h[1]+5, 7]) cube([16, 40, 99]);
        }
    }
    
    // side mating holes
    for (y=bs_y) {
        // screw side
        translate([base_wide-bs_thick-eps, y+bs_wide/2, base_thick+bs_wide/2]) 
            rotate([0, 90, 0]) cylinder(99, p815_hole, p815_hole);
        translate([base_wide-bs_thick-eps, y+bs_wide/2, base_thick+bs_wide/2]) 
            rotate([0, 90, 0]) cylinder(bs_thick/2, p815_head, p815_head);
        // threads side
        //translate([base_wide-p815_deep+1, y+bs_wide/2, base_thick+bs_wide/2]) 
        //    rotate([0, 90, 0]) cylinder(99, p815_thrd, p815_thrd);
    }
    
    // usb board
    translate([usb_x-26.5, base_long-11, -eps]) {
        cube([26, 99, 99]);
        translate([13/2, -2, base_thick+1]) cube([13, 99, 7]);
    }
    for (h=usb_holes) {
        translate([h[0], h[1], 1]) cylinder(99, m25_thrd, m25_thrd);
    }

    // ESP board
    for (h=esp_holes) {
        translate([h[0], h[1], 1]) cylinder(99, m25_thrd, m25_thrd);
    }
    
    // conn board
    for (h=cn_holes) {
        translate([h[0], h[1], base_thick+cn_stud_high-4]) cylinder(99, m2_thrd, m2_thrd);
    }
}
} // projection
