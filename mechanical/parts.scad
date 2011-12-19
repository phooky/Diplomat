d_bearing = 8.00;
d_shaft = 4.00;
l_bearing = 12.00;
kerf = 0.6;
w_platform = 40.00;
w_block = 14.00;
h_platform=60;
t_platform = 5;

$fn=10;
module bearing() {
	height = l_bearing+2*kerf;
	rotate([0,90,0])
	union() {
		cylinder(r=(d_bearing/2)+kerf,height, center=true);
		translate([0,0,height/2]) cylinder(r1=(d_bearing/2)+kerf,r2=0,h=5);
		mirror([0,0,1]) translate([0,0,height/2]) cylinder(r1=(d_bearing/2)+kerf,r2=0,h=5);		
		cylinder(r=3.0, h=100, center=true);
	}
}

module bearing_block() {
	difference() {
		union() {
			translate([0,-(d_bearing+3)/2,0]) cube(size=[w_block,d_bearing+2.10,d_bearing+5], center=true);
			rotate([0,90,0]) cylinder(r=(d_bearing+8)/2,h=w_block,center=true);
		}
		translate([0,(d_bearing+2.1)/2,0]) cube(size=[w_block+1,d_bearing+2.1,d_bearing-3.5], center=true);
		rotate([17,0,0])  translate([0,(d_bearing+2.1)/2,0]) cube(size=[w_block+1,d_bearing+2.1,d_bearing-3.5], center=true);
		rotate([-17,0,0])  translate([0,(d_bearing+2.1)/2,0]) cube(size=[w_block+1,d_bearing+2.1,d_bearing-3.5], center=true);
		bearing();
	}
}

module m2hole() {rotate([90,0,0]) cylinder(r=1+kerf,h=20,center=true); }

module vertholes() {	
	sep=21.59;
	translate([0,0,sep]) m2hole();
	m2hole();
}

module mountholes() {
	hsep = 19.58;
	translate([hsep/2,0,0]) vertholes();
	translate([-hsep/2,0,0]) vertholes();
}

module printhead_platform() {
	difference() {
		translate([0,0,h_platform/2]) cube([w_platform, t_platform, h_platform],center=true);
		translate([0,0,15])
			mountholes();		
	}	
}

module belt_clamp() {
	difference() {
		union() {
			translate([-4,0,1.5]) cube([8,15,2]);
			translate([-4,0,-1.5]) cube([8,15,2]);
		}
		translate([0,10,-4]) cylinder(h=10,r=1.5);
	}
}

union() {
translate([0,10,10]) bearing_block();
translate([0,10,50]) bearing_block();
translate([0,0,0]) printhead_platform();
translate([16,0,30]) belt_clamp();
translate([-16,0,30]) belt_clamp();
}