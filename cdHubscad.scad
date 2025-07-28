$fn=30;
include <threads.scad>

/* [thread] */
threadLen = 10; 

/* [hub] */
cdDiam=15;
hubShaftLen=25-threadLen;
motorShaftDiam=1.5;
motorShaftLen=6;
cdEps=.5;

/* [backing] */
backWidth=5;
backDiam=40;

/* [Hidden] */
cdRadius = cdDiam/2.0;
motorShaftRadius = motorShaftDiam/2.0;
backRadius = backDiam / 2.0;

module makeHubShaft() {
    difference() {
        union() {
            translate([0,0,backWidth])
            cylinder(hubShaftLen, cdRadius+cdEps, cdRadius-cdEps);
            cylinder(backWidth, backRadius, backRadius);
        }
        cylinder(motorShaftLen, motorShaftRadius, motorShaftRadius);
    }
    translate([0,0,backWidth+hubShaftLen])
        RodStart(20, 0, thread_len=threadLen, thread_diam=cdDiam-2*cdEps);
}

module makeCap() {
        //translate([0,0,backWidth+hubShaftLen])
    

    RodEnd(threadLen+10, 9, thread_len=20,thread_diam=cdDiam-2*cdEps);
    
    translate([0,0,9])
        difference() {
            union() {
                cylinder(hubShaftLen, threadLen/2+5, threadLen/2+5);
                translate([0,0,hubShaftLen])
                    cylinder(backWidth, backRadius, backRadius);
            }
            cylinder(hubShaftLen+backWidth, cdRadius+cdEps, cdRadius+cdEps);
        }
        
}

makeHubShaft();
//module RodStart(diameter, height, thread_len=0, thread_diam=0, thread_pitch=0) {
//module RodEnd(diameter, height, thread_len=0, thread_diam=0, thread_pitch=0) {

translate([50,0,9+hubShaftLen+backWidth]) {
        rotate([180,0,0])
        makeCap(); 
}