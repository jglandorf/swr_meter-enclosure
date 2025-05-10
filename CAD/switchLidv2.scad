
/* [Basic settings] */

// pcb thickness 
pcb_thickness = 1.6;

// width of the enclosure wall
wall_width = 1.1;

// clearance between button cap and hole (each side of cap)
// use ~0.35 for Polaroid translucent purple PLA (low shrinkage)
// use ~0.45 for Inland translucent orange PLA (high shrinkage)
button_cap_clearance = 0.45;

// top of cap brim when button is 'up'; this butts up against the inside top of the enclosure
buttonBrim_Z_up = 13.5; // >>>> test 13mm @ 0.40 clearance <<<<<
// top of cap brim when button is fully 'down', but not yet released
buttonActionZMin = 8.8;
// top of cap brim when button is 'down'
buttonActionZMax = 10.37;
// button height above the bbrim
buttonTopHatHeight = 4.56;
buttonTopHatMinHeight = buttonBrim_Z_up - buttonActionZMin;
echo(buttonTopHatMinHeight=buttonTopHatMinHeight);

show_screws = false;
// Screw diameter 
screw_hole_size = 2.40; //grips threads: 2.35;  // clearance for #2
// Screw head diameter.
screw_head_size = 4;
// Screw (usable) thread length.
screw_length_size = 4;


/* [Advanced settings] */

// How deep screw heads should be recessed.
//recessed_screw_depth = 0;

$fn = 180;

module num2Screw(extendHeadHeight = 0) {
  // #2 sheet metal/self drilling
  color("darkgray", 0.65)
	  translate([0, 0, -0.01])
      cylinder(h=4.02, d=screw_hole_size, center=false);
  color("darkgray", 0.65)
	  translate([0, 0, 4])
      cylinder(h=1.75+extendHeadHeight, d=screw_head_size, center=false);

}

module outerLid() {
  // outer block
  color("green", 0.65)
    translate([0, 0, 0])
      cube([57.36, 18.26, buttonBrim_Z_up + wall_width /*10*/]);
  // mounting ears
  color("darkgreen", 0.65)
	  translate([5, 9.13, 0])
      cylinder(h=screw_length_size - pcb_thickness, r=9.13, center=false);
  color("darkgreen", 0.65)
	  translate([52.36, 9.13, 0])
      cylinder(h=screw_length_size - pcb_thickness, r=9.13, center=false);
}

module lidCutouts(extendHeadHeight = 0) {
  // inner block
  color("green", 0.65)
    translate([wall_width, wall_width, -2.001])
      cube([54.16 + (3.2-2*wall_width), 15.06 + (3.2-2*wall_width), buttonBrim_Z_up + 0.4]);

  // screw holes
  color("red", 0.5)
	  translate([-2.2, 9.13, -4])
      cylinder(h=10,d=screw_hole_size, center=false);
  color("red", 0.5)
	  translate([59.46, 9.13, -4])
      cylinder(h=10,d=screw_hole_size, center=false);
  // screw heads
  color("darkred", 0.5)
	  translate([-2.2, 9.13, 1+1*pcb_thickness])
      cylinder(h=10+extendHeadHeight,d=screw_head_size, center=false);
  color("darkred", 0.5)
	  translate([59.46, 9.13, 1+1*pcb_thickness])
      cylinder(h=10+extendHeadHeight,d=screw_head_size, center=false);

  
  // button holes
  cylH= 2* buttonBrim_Z_up + wall_width;
  color("red", 0.5)
	  translate([28.68, 9.13, -1])
      cylinder(h=cylH,r=5.73 + button_cap_clearance,center=false);
  color("red", 0.5)
	  translate([9.18, 9.13, -1])
      cylinder(h=cylH,r=5.73 + button_cap_clearance,center=false);
  color("red", 0.5)
	  translate([48.25, 9.13, -1])
      cylinder(h=cylH,r=5.73 + button_cap_clearance,center=false);

}


main();

module main() {
  if (show_screws)
  {
    translate([-2.2, 9.13, -pcb_thickness])
      num2Screw(15);
    translate([59.46, 9.13, -pcb_thickness])
      num2Screw(15);
  }
  difference(20)
  {
    hull()
      outerLid();
    lidCutouts();
  }
}