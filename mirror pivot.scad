// sphere in car is 9.75mm
// sphere is 8mm deep

difference() {
    translate([7,0,0])
    sphere(15);
    sphere(10);
for ( i = [0 : 90 : 360] ) {
rotate([i,0,0])
translate([-1,10,0])
cube([10,5,1],center=true);
}
}