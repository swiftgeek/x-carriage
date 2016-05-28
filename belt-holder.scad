//Author: Swift Geek
//Inspired by: https://www.thingiverse.com/thing:886421
//Disclaimer: This module is heavily hardcoded for GT2
//To make it work with other cables change scaling factor - in (8+1.7*2)/8 change 1.7 to thickness of single belt
//And change thickness (in gt2 case 2) of cube in inverted_holder to thickness of two belts locked together by their teeth

module drop(){
rotate ([0,0,-30]) hull () {
    translate([-4,0,0]) cylinder (h=30, r=4); // a bit more $fn could be useful
    cylinder (h=30, r=4, $fn=3);  // should be h=8 in end product
}
}

module inverted_drop() {
difference () {
    //calculate scale factor (8+1.7*2)/8
    translate ([-0.49+(2*1.7/sqrt(3)),0.85-1.7]) scale([1.425,1.425]) drop();
    drop();
}
}

module inverted_holder () {
    translate ([9.41+1,3.7])inverted_drop();
    translate ([15,0]) cube ([30,2,30]);
    mirror ([1,0,0]) translate ([9.41+1,3.7])inverted_drop();
    mirror ([1,0,0]) translate ([15,0]) cube ([30,2,30]);
    // Ridge for easier belt insertion 
    translate ([-50,0,6]) intersection() {
            rotate ([45,0,0]) cube ([100,100,100]);
            cube ([100,11,30]);
    }
}
//inverted_drop();
inverted_holder ();

