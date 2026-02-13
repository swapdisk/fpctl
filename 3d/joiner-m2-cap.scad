$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m2_head=4.20/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;
p815_thrd=3.70/2;
p815_hole=4.10/2;
p815_head=11.20/2;
p815_deep=13.50;

cap_high=2.5;
cap_deep=1.2;

difference() {
    cylinder(cap_high, m2_head, m2_head);
    translate([0, 0, cap_high-cap_deep]) cylinder(99, m2_thrd, m2_thrd);
}
