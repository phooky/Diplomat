d_shaft = 4.00;
kerf = 0.15;

$fn=20;
module shaft() {
	rotate([0,90,0]) cylinder(r=(d_shaft/2)+kerf,h=50,center=true);
}

module bolthole() {
	translate([0,0,-5])
	union() {
		cylinder(r=1.5+kerf,h=10);
		translate([0,0,8]) cylinder(r=2.5+kerf,h=4);
	}
}

difference() {
translate([-5,-15,0]) rotate([90,0,90]) linear_extrude(file="support.dxf",height=10,convexity=10);
translate([0,-8,0]) bolthole();
translate([0,8,0]) bolthole();
translate([0,0,22]) shaft();
translate([0,0,67]) shaft();
}