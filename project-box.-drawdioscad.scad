
/* [general] */

assemble=false;
show_lid=true;
show_bot=true;

// relevant if holes/enable_cable_stress_relief=true
show_cable_stress_relief_bars=true;

/* [tactical dimensions] */

// total wall thickness
wall_th=1.001;

// floor thickness
flo_th=1.001;

// lid thickness
lid_th=1.001;

// box width
box_w=70.001;

// box length
box_l=110.001;

// box height
box_h=35.001;

// base corner radius
corner_r=1.001;

// measure box dimensions from inside or outside walls
measure_from="int"; // ["int", "ext"]

// if lip_w is very large then pilar may be omitted
enable_lid_pillar=true;

// lid pillar size
lid_pillar_s=9;

// hole diameter of lid
lid_hole_d=3.3;

// tolerance between lid and box
lid_tol_xy=0.3001;

// reduces height of support pillars holding the lid
lid_tol_z=0.2001;

// interior lip to help seal the lid
enable_lip=true;

// width of interior lip
lip_w=3.001;

/* [PCB feet] */

enable_pcb=true;

// hole distance x
pcb_foot_dx=40.001;

// hole distance y
pcb_foot_dy=82.001;

// height
pcb_foot_h=10.001;

// foot diameter
pcb_foot_d=9.001;

// hole diameter
pcb_foot_hole=2.001;

// offset
pcb_offset=[0.001, 0.001];

// measure offset from interior wall or from center
pcb_offset_from="center"; // ["corner", "center"]

/* [holes] */

// turn holes on the walls into octagons
side_hole_printability_help=true;

// cable stress reliefs for front/rear cable holes. uses lid_hole_d.
enable_cable_stress_relief=true;

// set to nonzero to enable front holes
front_hole_count=0;
front_hole_d=12.001;
front_hole_spacing=18.001;

// set to nonzero to enable rear holes
rear_hole_count=0;
rear_hole_d=12.001;
rear_hole_spacing=15.001;

/* [mounting] */

// set to nonzero to enable mounting
mount_flaps_count=0;
mount_flaps_th=2.001;
mount_hole_d=4.601;

/* [detail level] */
$fa=10;
$fs=0.4;

// end params

int_w= measure_from=="int" ? box_w : (box_w - 2*wall_th);
int_l= measure_from=="int" ? box_l : (box_l - 2*wall_th);
int_h= measure_from=="int" ? box_h : (box_h - lid_th - flo_th);
ext_w= int_w + 2*wall_th;
ext_l= int_l + 2*wall_th;
ext_h= int_h + lid_th + flo_th;

module rsquare(dim, r=1, center=false) {
	hull()
	translate(center?[0,0]:dim/2)
	for(p=[[-1,-1],[-1,1],[1,-1],[1,1]]) {
		c=[p[0]/2*dim[0], p[1]/2*dim[1]];
		intersection() {
			translate(c-r*p) circle(r=r);
			translate(c/2) square(dim/2, center=true);
		}
	}
}

module ext_body(d=0, h=ext_h) {
	linear_extrude(height=h, convexity=2)
	translate([-wall_th,-wall_th])
	offset(delta=d)
	rsquare([ext_w, ext_l], r=corner_r + wall_th);
}

module int_body(d=0, h=int_h) {
	translate([0,0,flo_th])
	linear_extrude(height=h, convexity=2)
	offset(delta=d)
	rsquare([int_w, int_l], r=corner_r);
}

module pcb_foot() {
	let(h=0.01 + pcb_foot_h)
	let(d=pcb_foot_d)
	let(a=min(h-0.1, d*0.25)) // base bevel size
	difference() {
		union() {
			cylinder(d=d, h=h);
			cylinder(d1=d + 2*a, d2=d, h=a);
		}
		translate([0,0,-0.01 + h/2])
		cylinder(d=pcb_foot_hole, h=h+10, center=true);
	}
}

module at_corners(s=[int_w,int_l]) {
	for(i=[0,1]) for(j=[0,1]) translate([i*s[0], j*s[1]])
	mirror([i,0]) mirror([0,j]) children();
}

module pcb_feet() {
	let(s=[pcb_foot_dx, pcb_foot_dy])
	translate(pcb_offset_from == "corner" ? [0,0] : [int_w,int_l]/2 - s/2)
	translate([0,0,flo_th])
	translate(pcb_offset)
	at_corners(s)
	pcb_foot();
}

module lid_support_pillar_2d() {
	let(s=lid_pillar_s)
	let(r=min(corner_r, s/2))
	let(a=s+r)
	let(f=wall_th/3)
	difference() {
		translate(-[f,f])
		union() {
			rsquare([s, s] + [f,f], r=r);
			square([s, s]/2 + [f,f]);
			square([a, r] + [f,f]);
			square([r, a] + [f,f]);
		}
		translate([a, r]) circle(r=r+.01);
		translate([r, a]) circle(r=r+.01);
	}
}

module lip(s, r) {
	for(y=[0,s[1]])
	translate([0,y])
	rotate(90, [0,1,0])
	cylinder(h=s[0], r=r, $fn=4);

	for(x=[0,s[0]])
	translate([x,0])
	rotate(90, [-1,0,0])
	cylinder(h=s[1], r=r, $fn=4);
}

module lid_holes() {
	at_corners([int_w, int_l])
	translate([.5,.5]*lid_pillar_s)
	circle(d=lid_hole_d);
    
    // JOHN ADD START
    translate([int_w/2,int_l/2,0])
	translate([.5,.5]*[int_w,int_l])
	circle(d=55);
    
    translate([(int_w-60)/2,(int_l-60)/2,0])
    at_corners([60, 60])
	translate([.5,.5]*lid_pillar_s)
	circle(d=lid_hole_d);
    // JOHN ADD END
}

module spaced_items(n, dx) {
	if (n ==1) children();
	else if (n>0)
	translate([(n-1)*dx/-2, 0])
	for(i=[0:n-1])
	translate([i*dx,0])
	children();
}

module cable_stress_relief(hole_count, hole_spacing, hole_d) {
	let(g=lid_pillar_s)
	let(a=wall_th/3)
	let(s=[2*a+int_w, a+g, ext_h/2 - hole_d/2])
	difference() {
		translate([-a, -a])
		cube(s);

		translate([int_w/2, g/2, -5])
		spaced_items(hole_count, hole_spacing)
		spaced_items(2, hole_d + 4 + lid_hole_d)
		cylinder(d=lid_hole_d, h=s[2] + 10);
	}
}

module cable_stress_relief_bar(hole_d) {
	let(dx=hole_d + 4 + lid_hole_d)
	linear_extrude(height=2, convexity=4)
	difference() {
		rsquare([dx+10, lid_pillar_s-0.6], corner_r, center=true);

		spaced_items(2, dx)
		circle(d=lid_hole_d);
	}
}

module parts_clipped_inside() {
	if (enable_pcb) {
		color("orange")
		pcb_feet();
	}

	if (enable_lid_pillar || enable_lip)
	color("pink")
	difference() {
		union() {
			if (enable_lid_pillar)
			linear_extrude(height=int_h - lid_tol_z, convexity=8)
			at_corners([int_w, int_l])
			lid_support_pillar_2d();

			if (enable_lip)
			intersection() {
				translate([0,0,int_h - lid_tol_z])
				mirror([0,0,1])
				lip([int_w, int_l], lip_w);

				linear_extrude(height=int_h - lid_tol_z, convexity=2)
				offset(delta=wall_th/3)
				square([int_w,int_l]);
			}
		}

		translate([0,0,-5])
		linear_extrude(height=int_h + 10, convexity=4)
		lid_holes();
	}

	if (enable_cable_stress_relief) {
		if (front_hole_count > 0) {
			cable_stress_relief(front_hole_count, front_hole_spacing, front_hole_d);
		}
		if (rear_hole_count > 0) {
			translate([0,int_l]) mirror([0,1])
			cable_stress_relief(rear_hole_count, rear_hole_spacing, rear_hole_d);
		}
	}

	// join the floor and walls with a nice bevel 
	translate([0,0,flo_th])
	lip([int_w, int_l], min(corner_r,2.5));
}

function ngon_circumcircle_radius(Ri,theta) = Ri / cos(theta/2);

module side_hole(r,h,center=false) {
	if (side_hole_printability_help) {
		rotate(360/8/2, [0,0,1])
		cylinder(r=ngon_circumcircle_radius(r, 360/8), h=h, center=center, $fn=8);
	} else {
		cylinder(r=r,h=h,center=center);
	}
}

module extra_holes() {
	translate([int_w/2, -wall_th/2, ext_h/2])
	spaced_items(front_hole_count, front_hole_spacing)
	rotate(90, [1,0,0])
	side_hole(r=front_hole_d/2, h=wall_th+.02, center=true);

	translate([int_w/2, int_l+wall_th/2, ext_h/2])
	spaced_items(rear_hole_count, rear_hole_spacing)
	rotate(90, [1,0,0])
	side_hole(r=rear_hole_d/2, h=wall_th+.02, center=true);
}

module mount_flaps() {
	for(i=[0,1]) translate([ext_w*i,0]) mirror([i,0])
	linear_extrude(height=mount_flaps_th, convexity=2)
	let(s=max(10,min(mount_hole_d*3,mount_hole_d+14)))
	translate([0, ext_l/2 - wall_th])
	rotate(90,[0,0,1])
	spaced_items(mount_flaps_count, (ext_l-s)/(mount_flaps_count-1))
	difference() {
		translate([-s/2,-s]) rsquare([s, 2*s], corner_r*2);
		translate([0,s/2]) circle(d=mount_hole_d);
	}
}

module the_box() {
	translate(measure_from == "int" ? [0,0] : [wall_th,wall_th])
	difference(convexity=10) {
		union() {
			ext_body();
			mount_flaps();
		}
		difference(convexity=10) {
			int_body(h=ext_h);
			parts_clipped_inside();
		}
		extra_holes();
	}
}

module the_lid() {
	translate(measure_from == "int" ? [0,0] : [wall_th,wall_th])
	linear_extrude(height=lid_th, convexity=2)
	difference() {
		translate([1,1] * lid_tol_xy)
		rsquare([int_w, int_l] - [2,2]*lid_tol_xy, corner_r - lid_tol_xy);
		offset(delta=0.5)
		lid_holes();
	}
}

module main() {
	if (assemble) {
		if (show_bot)
		the_box();

		if (show_lid)
		translate([0,0,ext_h - lid_th])
		%the_lid();

		if (enable_cable_stress_relief && show_cable_stress_relief_bars) {
			if (front_hole_count > 0)
			translate([int_w/2, lid_pillar_s/2, ext_h/2 + front_hole_d/2])
			cable_stress_relief_bar(front_hole_d);

			if (rear_hole_count > 0)
			translate([0, int_l])
			translate([int_w/2, -lid_pillar_s/2, ext_h/2 + rear_hole_d/2])
			cable_stress_relief_bar(rear_hole_d);
		}
	} else {
		if (show_bot)
		the_box();

		if (show_lid)
		translate([-ext_w - 25,0,0])
		the_lid();

		if (enable_cable_stress_relief && show_cable_stress_relief_bars) {
			if (front_hole_count > 0)
			translate([0, -lid_pillar_s - 10])
			cable_stress_relief_bar(front_hole_d);

			if (rear_hole_count > 0)
			translate([0, -2*lid_pillar_s - 20])
			cable_stress_relief_bar(rear_hole_d);
		}
	}
}
main();


