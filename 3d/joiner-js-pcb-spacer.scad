$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m2_nip=1.88/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Panel dims
pan_x=216;
pan_y=28.5;
pan_thick=3.4;
pan_rad=2;
                    
// PCB dims
pcb_x=80;
pcb_y=20;
pcb_thick=1.6;

// PCB screws
pcb_stud_rad=4.00/2;
pcb_screws=[[0, 0], [0, 16]];

// Spacer dims
spacer_high=10.00;

difference() {
    union() {
        // spacer studs
        for (x=pcb_screws) {
            translate([x[0], x[1], 0]) cylinder(spacer_high, pcb_stud_rad, pcb_stud_rad);
        }
        // nips
        for (x=pcb_screws) {
            translate([x[0], x[1], 0]) cylinder(spacer_high+2, m2_nip, m2_nip);
        }
        // support
        translate([pcb_stud_rad-0.8, 0, 0]) cube([0.8, 16, 4]);
    }
    // spacer screw holes
    for (x=pcb_screws) {
        translate([x[0], x[1], -eps]) cylinder(spacer_high-2, m2_thrd, m2_thrd);
    }
}
