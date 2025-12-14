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

powAndVolHeight=panelHeight-30;

module doPowerAndVolText() {
    linear_extrude(panelDepth + 0.5) {
        translate([17+5.5/2, powAndVolHeight - 10, 0])
            text(halign = "center", size = 4, "power");
        translate([panelWidth-17-7/2, powAndVolHeight - 10, 0])
            text(halign = "center", size = 4, "volume");
    }
}

module doPowerVolAndLightHoles() {
    translate([17+5.5/2, powAndVolHeight, -5]) {
        //power 
        cylinder(10,d=5.5);
        translate([12,0,0])
            //light
            cylinder(10, d=8);
    }
    translate([panelWidth-17-7/2, powAndVolHeight, -5])
            //vol
            cylinder(10, d=7);
}

module doAmpBosses() {
    translate([0,panelHeight-ampDistFromEdge-5/2, -ampBossLen]) {
        translate([22,0,0])
            cylinder(ampBossLen, d=5);
        translate([55,-47,0])
            cylinder(ampBossLen, d=5);
    }
}

module doAmpMountHoles() {
  translate([0,panelHeight-ampDistFromEdge-5/2, -ampBossLen-5]) {
        translate([22,0,0])
            cylinder(ampBossLen+10, d=2);
        translate([55,-47,0])
            cylinder(ampBossLen+10, d=2);
    }
}

module doSpeakerHole() {
    speakerRadius = speakerDiam / 2.0;
    translate([panelWidth/2,speakerRadius+speakerDistFromEdge,-10])
        cylinder(20, d=50);
}

module doSpeakerBosses() {
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

module doSpeakerMountHoles() {
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

module doAll() {
    difference() {
        cube([panelWidth,panelHeight,panelDepth]);
        doSpeakerHole();
        doPowerVolAndLightHoles();            
    }
    difference() {
        doSpeakerBosses();
        doSpeakerMountHoles();
    }
    difference() {
        doAmpBosses();
        doAmpMountHoles();
    }
    doPowerAndVolText();
}

doAll();
//        powerVolAndLightHoles();            
