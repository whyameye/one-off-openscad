boxDepth=8;
boxLReduct=10;
translate([37.6,0,0]) {
    import("Arduino_uno_R3_clip_Base_Rv_02.stl");
    difference() {
        translate([-37.6,-26.9,-boxDepth])
            cube([110-boxLReduct,53.3,boxDepth]);
        translate([92-37.6-boxLReduct,15,-boxDepth])
            cube([30,30,boxDepth]);
        translate([92-37.6-boxLReduct,-15-30,-boxDepth])
            cube([30,30,boxDepth]);
        translate([85-37.6-boxLReduct,-10,-boxDepth])
            cube([25,20,boxDepth]);
        translate([10-37.6+14.25/2,0,-boxDepth])
            cylinder(h=7,d=14.25,$fn=6);
    }
}