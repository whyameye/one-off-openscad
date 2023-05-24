// sphere in car is 9.75mm
// sphere is 8mm deep

difference() {
    translate([7,0,0])
    sphere(15);
    sphere(10);
for ( i = [0 : 90 : 360] ) {
rotate([i,0,0])
translate([-1,10,0])
cube([10,10,1],center=true);
}
}
translate([20,0,0])
rotate([0,90,0])
cylinder(h=10,r=5);
translate([38,0,0])
sphere(10);