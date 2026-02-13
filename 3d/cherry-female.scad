$fn=180;
eps=0.01;

// Params Cherry mate
cherry_thick1=1.16;
cherry_thick2=1.40;
cherry_wide=4.00;
cherry_high=3.90;
//shaft_high=5.00;
shaft_high=cherry_high+0.3;
shaft_wide=6.80;
shaft_deep=5.20;
fudge_high=0.30;
fudge_plus=0.40;

// Cherry mate
difference() {
    // base body
    translate([0, 0, shaft_high/2]) cube([shaft_wide, shaft_deep, shaft_high], center=true);
    // cherry splines
    translate([0, 0, cherry_high/2-eps]) 
        cube([cherry_thick1, cherry_wide, cherry_high], center=true); 
    translate([0, 0, cherry_high/2-eps]) 
        cube([cherry_wide, cherry_thick2, cherry_high], center=true); 
    // fudge bottom layer
    translate([0, 0, fudge_high/2-eps]) 
        cube([cherry_thick1+fudge_plus, cherry_wide+fudge_plus, fudge_high], center=true); 
    translate([0, 0, fudge_high/2-eps]) 
        cube([cherry_wide+fudge_plus, cherry_thick2+fudge_plus, fudge_high], center=true);
    
    
    // debug
    //translate([0, 0, -0.01]) cube(90);
}
