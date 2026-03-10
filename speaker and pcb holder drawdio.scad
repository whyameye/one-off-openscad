$fn=25;

module PCB_brace() {
difference() {
    a = 4;
    cube([9+45,28+9,3]);
    translate([9,0,0]) cube([45-9,28,3]);
    translate([9/2,9/2,0]) cylinder(10,d=a);
    translate([9/2,28+9/2,0]) cylinder(10,d=a);
    translate([45+9/2,9/2,0]) cylinder(10,d=a);
    translate([45+9/2,28+9/2,0]) cylinder(10,d=a);
}
}

//PCB_brace();

module makeBoss() {
    difference() {
        cylinder(11,d=10);
        cylinder(11,d=4);
    }
}

module speaker_brace() {
    x = 1; // sqrt(2)/2;
    y = 51;
    z = 9;
    difference() {
        union() {
            cylinder(4.5,d=65);
            translate([y/2*x, y/2*x, -4.5]) cylinder(z,d=12);
            translate([y/2*x, -y/2*x, -4.5]) cylinder(z,d=12);
            translate([-y/2*x, -y/2*x, -4.5]) cylinder(z,d=12);
            translate([-y/2*x, y/2*x, -4.5]) cylinder(z,d=12);
        }
        cylinder(4.5,d=52);
        translate([y/2*x, y/2*x, -4.5]) cylinder(z,d=4);
        translate([y/2*x, -y/2*x, -4.5]) cylinder(z,d=4);
        translate([-y/2*x, -y/2*x, -4.5]) cylinder(z,d=4);
        translate([-y/2*x, y/2*x, -4.5]) cylinder(z,d=4);
    }
}

rotate([180,0,0]) {
speaker_brace();
translate([45,-20,1.5]) PCB_brace();
}