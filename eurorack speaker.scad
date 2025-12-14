// things to check:
// size of holes in bosses
// make the panel thinner when testing


$fn=50;

panelHeight = 128.5;
panelWidth = 81;
panelDepth = 1.5;
speakerDiam = 50;
speakerDistFromEdge = 11;

ampBossLen = 31;
ampDistFromEdge=12;


module powerVolAndLightHoles() {
    translate([17+5.5/2, panelHeight-30, -5]) {
        //power 
        cylinder(10,d=5.5);
        translate([12,0,0])
            //light
            cylinder(10, d=8);
    }
    translate([panelWidth-17-7/2, panelHeight-30, -5])
            //vol
            cylinder(10, d=7);
}

module ampBosses() {
    translate([0,panelHeight-ampDistFromEdge-5/2, -ampBossLen]) {
        translate([22,0,0])
            cylinder(ampBossLen, d=5);
        translate([55,-47,0])
            cylinder(ampBossLen, d=5);
    }
}

module ampMountHoles() {
  translate([0,panelHeight-ampDistFromEdge-5/2, -ampBossLen-5]) {
        translate([22,0,0])
            cylinder(ampBossLen+10, d=2);
        translate([55,-47,0])
            cylinder(ampBossLen+10, d=2);
    }
}

module speakerHole() {
    speakerRadius = speakerDiam / 2.0;
    translate([panelWidth/2,speakerRadius+speakerDistFromEdge,-10])
        cylinder(20, d=50);
}

module speakerBosses() {
    translate([panelWidth/2-45/2,speakerDistFromEdge+5/2,-8]) {
        cylinder(8, d=5);
        translate([45,0,0])
            cylinder(8, d=5);
        translate([0,45,0])
            cylinder(8, d=5);
        translate([45,45,0])
            cylinder(8, d=5);
    }
}

module speakerMountHoles() {
    translate([panelWidth/2-45/2,speakerDistFromEdge+5/2,-10]) {
          cylinder(18, d=2);
        translate([45,0,0])
            cylinder(18, d=2);
        translate([0,45,0])
            cylinder(18, d=2);
        translate([45,45,0])
            cylinder(18, d=2);
    }   
}

module all() {
    difference() {
        cube([panelWidth,panelHeight,panelDepth]);
        speakerHole();
        powerVolAndLightHoles();            
    }
    difference() {
        speakerBosses();
        speakerMountHoles();
    }
    difference() {
        ampBosses();
        ampMountHoles();
    }
}

all();
//        powerVolAndLightHoles();            
