$fn=6;

module thehole(x) {
    difference() {
        cylinder(h=5, d=8);
        cylinder(h=10, d=x);
    }
}

for (i = [0:10:100]) {
    translate([i/1.65,0,0])
        thehole(3+i/100);
}