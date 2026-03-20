$fn=30;
include <threads.scad>

/* [things to do] */
makeTheHub = true;
makeTheCap = true;

/* [thread] */
threadLen = 10; 

/* [hub] */
cdDiam=14.5;
hubShaftLen=25-threadLen;
motorShaftDiam=2.3; // [2.3, 3.5]
motorShaftLen=6;
motorShaftShape = "circle"; // [circle, hexagon]

cdEps=.25;

/* [backing] */
backWidth=5;
backDiam=40;

/* [misc] */
hexSize = 6.05;

/* [Hidden] */
cdRadius = cdDiam/2.0;
motorShaftRadius = motorShaftDiam/2.0;
backRadius = backDiam / 2.0;

module makeHubShaft() {
    myfn = (motorShaftShape == "circle" ? $fn : 6);

    difference() {
        union() {
            translate([0,0,backWidth])
            cylinder(hubShaftLen, cdRadius+cdEps, cdRadius-cdEps);
            cylinder(backWidth, backRadius, backRadius);
            translate([0,0,backWidth+hubShaftLen])
        RodStart(20, 0, thread_len=threadLen, thread_diam=cdDiam-2*cdEps);
        }
        cylinder(motorShaftLen, motorShaftRadius, motorShaftRadius, $fn = myfn);
        translate([0,0,20-threadLen])
            cylinder(20,hexSize/2,hexSize/2,$fn=6);
    }
}

module makeCap() {
        //translate([0,0,backWidth+hubShaftLen])
    moreEps = 0.5; // empty space in non-threaded area (prevent binding)

    RodEnd(threadLen+10, 9, thread_len=20,thread_diam=cdDiam-2*cdEps);
    
    translate([0,0,9])
        difference() {
            union() {
                translate([0,0,-9])
                cylinder(hubShaftLen-backWidth+threadLen, threadLen/2+9, threadLen/2+9, $fn=6);
                translate([0,0,hubShaftLen-backWidth])
                    cylinder(backWidth, backRadius, backRadius);
            } translate([0,0,-threadLen+1])
            cylinder(hubShaftLen+backWidth+threadLen, cdRadius+cdEps+moreEps, cdRadius+cdEps+moreEps);
        }
        
}

if (makeTheHub) {
    makeHubShaft();
}


//module RodStart(diameter, height, thread_len=0, thread_diam=0, thread_pitch=0) {
//module RodEnd(diameter, height, thread_len=0, thread_diam=0, thread_pitch=0) {

if (makeTheCap) {
 //   translate([50,0,9+hubShaftLen+backWidth]) {
    translate([50,0,9+hubShaftLen]) {

        rotate([180,0,0])
        makeCap(); 
    }
}
