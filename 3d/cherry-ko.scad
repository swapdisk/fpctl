$fn=120;

// Params Cherry knock out
cko_width=14.00;
cko_high=14.00;
cko_thick=1.50;
cko_frame=8.00;

// Cherry knock out
difference() {
    cube([cko_width+cko_frame, cko_high+cko_frame, cko_thick]);
    translate([cko_frame/2,cko_frame/2, -0.01]) cube([cko_width, cko_high, cko_thick+1]); 

    // debug
    //translate([0, 0, -0.01]) cube(90);
}

//// Small round buttons
//smbut_rad=5.04;
//smbut_x=[6.00];
//smbut_y=6.00;
//
//// Example small round button studs
//for (i = smbut_x) {
//    translate([i, smbut_y, 0]) cylinder(8, 2, 2);
//    translate([i+smbut_rad*2, smbut_y, 0]) cylinder(8, 2, 2);
//    translate([i, smbut_y+smbut_rad*2, 0]) cylinder(8, 2, 2);
//    translate([i+smbut_rad*2, smbut_y+smbut_rad*2, 0]) cylinder(8, 2, 2);
//    // Example switch
////    translate([smbut_rad+i, smbut_rad+smbut_y, 25]) color("pink") union() {
////        cube([14.57, 14.57, 18], center=true);
////        translate([0, 0, -21]) cylinder(12.3, 2.55, 2.55);
////    }
//}
