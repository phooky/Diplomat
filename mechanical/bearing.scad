$fn=26;
kerf = 0.2;

module body() {
	linear_extrude(file="bearing_mount.dxf",height=18,convexity=10,layer="cut");
}

module screw() {
	union() {
		cylinder(r=(3/2)+kerf,h=10,center=true);
		translate([0,0,3]) cylinder(r=(6/2)+kerf,h=5);
	}
}

module bearing() {
	difference() {
		rotate([0,-90,0]) body();
		translate([-3,0,0]) screw();
		translate([-15,0,0]) screw();
	}
}

translate([9,-10,0]) bearing();
translate([9,10,0]) bearing();