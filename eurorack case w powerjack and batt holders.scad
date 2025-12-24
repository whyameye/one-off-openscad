$fn=50;

holeDist = 16;
topHoleLoc = 25;
holeXLoc = [35, 100];

module doPowerJack() {
    translate([18,49,-5])
        cylinder(10, d=8.5);
}

module doBattHolder() {
        translate([70,15,-5])
        cylinder(10, d=3.5);
        translate([70,15+holeDist,-5])
        cylinder(10, d=3.5);
}

module doAll() {
    difference() {
        rotate([0,0,-19.9])
            translate([-16,-221.75,0])
                import( "EuroRack_Case_sidePanel_3.stl");
        doBattHolder();
        doPowerJack();
    }
}
doAll();
//doPowerJack();

