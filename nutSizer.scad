difference() {
    translate([-12,-10,0])

cube([200,20,7]);
for (i=[0:10:100]) {
    
        translate([i*1.75,0,0])
            cylinder(7,(14.5+i/100)/2,(14+i/100)/2,$fn=6);
    
}
}