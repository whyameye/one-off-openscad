// ball in mirror frame is 9.75mm
// ball is 8mm deep
// socket in mirror plate is 6mm deep

$fn=100;

// socket for mirror frame assembly to snap into
difference() {
    translate([2,0,0])
        scale([.9,1.1,1.1])
            sphere(d=12);
    scale([1.1,1,1])
        sphere(d=10);
    for ( i = [0 : 90 : 360] ) {
        rotate([i,0,0])
            translate([-5,5,0])
                cube([15,10,1],center=true);
    }
}

// ball for mirror plate to clip into
translate([6,0,0])
    rotate([0,90,0])
        cylinder(h=8,d=6); // 5 broke
translate([11,0,0]) // 12
    sphere(d=10);

// circle for debugging size of socket opening
//translate([-5,0,0])
    //rotate([0,90,0])
        //circle(d=8);
