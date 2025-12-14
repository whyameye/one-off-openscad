// things to check:
// size of holes in bosses
// make the panel thinner when testing


$fn=50;

panelHeight = 130.5;
panelWidth = 81.5;
panelDepth = 3;

bossDiam = 6;
bossHoleDiam = 2.25;

speakerDiam = 50;
speakerDistFromEdge = 11;

speakerBossLen = 7;

ampBossLen = 31;
ampDistFromEdge=14;

powAndVolHeight=panelHeight-32;

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
            cylinder(10, d=9);
    }
    translate([panelWidth-17-8/2, powAndVolHeight, -5])
            //vol
            cylinder(10, d=8);
}

module doAmpBosses() {
    translate([0,panelHeight-ampDistFromEdge-bossDiam/2, -ampBossLen]) {
        translate([21.5,1,0])
            cylinder(ampBossLen, d=bossDiam);
        translate([54.5,-48,-3])
            cylinder(ampBossLen+3, d=bossDiam);
    }
}

module doAmpMountHoles() {
  translate([0,panelHeight-ampDistFromEdge-bossDiam/2, -ampBossLen-5]) {
        translate([21.5,1,0])
            cylinder(ampBossLen+10, d=bossHoleDiam);
        translate([54.5,-48,0])
            cylinder(ampBossLen+10, d=bossHoleDiam);
    }
}

module doSpeakerHole() {
    speakerRadius = speakerDiam / 2.0;
    translate([panelWidth/2,speakerRadius+speakerDistFromEdge,-10])
        cylinder(20, d=speakerDiam);
}

module doSpeakerBosses() {
    translate([panelWidth/2-45/2,speakerDistFromEdge+bossDiam/2,-8]) {
        cylinder(speakerBossLen, d=bossDiam);
        translate([45,0,0])
            cylinder(speakerBossLen, d=bossDiam);
        translate([0,45,0])
            cylinder(speakerBossLen, d=bossDiam);
        translate([45,45,0])
            cylinder(speakerBossLen, d=bossDiam);
    }
}

module doSpeakerMountHoles() {
    translate([panelWidth/2-45/2,speakerDistFromEdge+bossDiam/2,-10]) {
          cylinder(18, d=bossHoleDiam);
        translate([45,0,0])
            cylinder(18, d=bossHoleDiam);
        translate([0,45,0])
            cylinder(18, d=bossHoleDiam);
        translate([45,45,0])
            cylinder(18, d=bossHoleDiam);
    }   
}

module makeSlot(x,y) {
    hull() {
        translate([x+4/2,y+4/2,-10]) {
            cylinder(18,d=4);
            translate([6,0,0])
                cylinder(18,d=4);
        }
    }
}

module doMountHoles() {
    makeSlot(5,1);
    makeSlot(panelWidth-5-8-4/2,1);
    makeSlot(5,panelHeight-1-4);
    makeSlot(panelWidth-5-8-4/2,panelHeight-1-4);

}

module doAll() {
    difference() {
        cube([panelWidth,panelHeight,panelDepth]);
        doSpeakerHole();
        doPowerVolAndLightHoles();
        doMountHoles();
    }
    difference() {
        doSpeakerBosses();
        doSpeakerMountHoles();
    }
    difference() {
        doAmpBosses();
        doAmpMountHoles();
    }
    //doPowerAndVolText();
}

doAll();
//        powerVolAndLightHoles();            
