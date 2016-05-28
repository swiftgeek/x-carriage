//Author: Swift Geek
//Inspired by: https://www.thingiverse.com/thing:886421
//Disclaimer: This module is tested for GT2
//To make it work with other cables change:
// belt_single, belt_double
//Change drop_distance to better fit design

belt_single=1.7; // single timing belt thickness
belt_double=2; // thickness of two timing belts locked together by their teeth
drop_distance=2; //distance between inverted drops
scale_factor=(8+belt_single*2)/8; // do not change

module drop(){
    rotate ([0,0,-30]) hull () {
        translate([-4,0,0]) cylinder (h=30, r=4); // a bit more $fn could be useful
        cylinder (h=30, r=4, $fn=3);  // should be h=8 in end product
    }
}

module inverted_drop() {
    difference () {
        translate ([-(belt_single/2/sqrt(3))+(2*belt_single/sqrt(3)),
            belt_single/2-belt_single])
            scale([scale_factor,scale_factor]) drop();
        drop();
    }
}

module inverted_holder () {
    translate ([7.47+belt_single+drop_distance/2,2+belt_single])inverted_drop();
    translate ([14+drop_distance/2,0]) cube ([30,belt_double,30]);
    mirror ([1,0,0]) translate ([7.47+belt_single+drop_distance/2,2+belt_single])
        inverted_drop();
    mirror ([1,0,0]) translate ([14+drop_distance/2,0]) cube ([30,belt_double,30]);
    // Ridge for easier belt insertion 
    translate ([-50,0,6]) intersection() {
            rotate ([45,0,0]) cube ([100,100,100]);
            cube ([100,11,30]);
    }
}
//inverted_drop();
inverted_holder();