difference() {
    cylinder(d=12, 10);
    translate([0,0,2])
        cylinder(d=8, 10);
    translate([-2,-2,0])
    cube([4,12,12]);
}
