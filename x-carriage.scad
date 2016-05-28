// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Průša <josefprusa@me.com>
// Václav 'ax' Hůla <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/josefprusa/Prusa3
// ***********************************
// Modification by: Swift Geek
// Inspired by: https://www.thingiverse.com/thing:886421/


// ThingDoc entry
/**
 * @id xCarriage
 * @name X Axis Extruder Carriage
 * @category Printed
 */

include <configuration.scad>
use <bushing.scad>
// mounting plate
use <extras/groovemount.scad>
use <belt-holder.scad>


//Use 30 for single extruder, 50 for wades, 80 for dual extruders (moved to config file)
//carriage_l_base = 80;
//check if we need to extend carriage to fit bearings
carriage_l_adjusted = max(adjust_bushing_len(bushing_xy, carriage_l_base, layer_height * 9), adjust_bushing_len(bushing_carriage, carriage_l_base, layer_height * 9));
//For bearings 30mm long or shorter enforce double len
carriage_l_real = max((bushing_xy[2] > 30 ? carriage_l_adjusted : (2 * bushing_xy[2] + 6)), carriage_l_adjusted);
// if the carriage was extended, we want to increase carriage_hole_to_side
carriage_hole_to_side = max(3, ((carriage_l_real - carriage_l_base) / 2));
echo(carriage_hole_to_side);
carriage_l = carriage_l_base + 2 * carriage_hole_to_side;


bushing_carriage_len = adjust_bushing_len(bushing_carriage, 21, layer_height * 9);

module x_carriage(){
    mirror([1,0,0]) {
        difference() {
            union() {
                //upper bearing
                rotate([0, 0, 90]) linear(bushing_carriage);
                //lower bearing
                translate([xaxis_rod_distance,0,0]) rotate([0, 0, 90]) linear(bushing_xy, carriage_l);

                //This block moves with varying bearing thickness to ensure the front side is flat
                translate([0, -bushing_foot_len(bushing_xy), 0]) {
                    // main plate
                    translate([4, -1, 0]) cube_fillet([xaxis_rod_distance + 4, 6, carriage_l], radius=2);
                    translate([-8, -1, 0]) cube_fillet([xaxis_rod_distance + 16, 6, bushing_carriage_len + 3], radius=2);
                }
                

                translate([45/2+13/2,0,0]){
                    translate([-2.5, -1, carriage_l/2]) cube_fillet([8+13, 16, carriage_l], vertical = [2, 2, 0, 0], center = true);
                }             
            }
            // Remove belt area
            rotate ([90,90,180]) translate ([-33,-34.7,-5.4]) inverted_holder();
            //Ensure upper bearing can be inserted cleanly
            rotate([0, 0, 90]) {
                linear_negative(bushing_carriage, carriage_l);
            }
            //Same for lower bearing
            translate([xaxis_rod_distance, 0, 0]) rotate([0, 0, 90]) {
                linear_negative(bushing_xy, carriage_l);
            }
            // extruder mounts
            translate([21, -2, carriage_hole_to_side]) {
                rotate([90, 0, 0]) cylinder(r=1.8, h=32, center=true,$fn=small_hole_segments);
                translate([0, 7, 0]) rotate([90, 60, 0]) cylinder(r=3.4, h=5, $fn=6, center=true);
            }
            translate([21, -2, carriage_hole_to_side + 30]) {
                rotate([90, 0, 0]) cylinder(r=1.8, h=32, center=true,$fn=small_hole_segments);
                translate([0, 7, 0]) rotate([90, 60, 0]) cylinder(r=3.4, h=5, $fn=6, center=true);
            }
            if (carriage_l >= 50 + 2 * carriage_hole_to_side) {
                translate([21, -2, carriage_hole_to_side + 30 + 20]) {
                    rotate([90, 0, 0]) cylinder(r=1.8, h=32, center=true,$fn=small_hole_segments);
                    translate([0, 7, 0]) rotate([90, 60, 0]) cylinder(r=3.4, h=5, $fn=6, center=true);
                }
            }
            if (carriage_l >= 80 + 2 * carriage_hole_to_side) {
                translate([21, -2, carriage_hole_to_side + 30 + 20 + 30]) {
                    rotate([90, 0, 0]) cylinder(r=1.8, h=32, center=true,$fn=small_hole_segments);
                    translate([0, 7, 0]) rotate([90, 60, 0]) cylinder(r=3.4, h=5, $fn=6, center=true);
                }
            }

        }
    }
}

x_carriage();
