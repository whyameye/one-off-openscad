$fn=25;

module PCB_brace() {
difference() {
    cube([9+45,28+9,3]);
    translate([9,0,0]) cube([45-9,28,3]);
    translate([9/2,9/2,0]) cylinder(10,d=3);
    translate([9/2,28+9/2,0]) cylinder(10,d=3);
    translate([45+9/2,9/2,0]) cylinder(10,d=3);
    translate([45+9/2,28+9/2,0]) cylinder(10,d=3);
}
}

//PCB_brace();

module makeBoss() {
    difference() {
        cylinder(9,d=10);
        cylinder(9,d=4);
    }
}

module speaker_brace() {
    difference() {
        cylinder(4.5,d=81);
        cylinder(4.5,d=52);
    }
    translate([60/2, 60/2, -4.5]) makeBoss();
    translate([60/2, -60/2, -4.5]) makeBoss();
    translate([-60/2, -60/2, -4.5]) makeBoss();
    translate([-60/2, 60/2, -4.5]) makeBoss();
}

speaker_brace();
translate([45,-20,1.5]) PCB_brace();