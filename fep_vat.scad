$fn=50;
use<square.scad>;
use<holes.scad>;

module tensionerBase() {
    linear_extrude(height=1.5)difference() {
        square([125,80],center=true);
        platformSquares();
        platformHoles();
    }
}
module tensionerExtrusion() {
    intersection(){
        minkowski() {
            linear_extrude(height=4)gasket();
            sphere(r=2,$fn=20);
        }
        translate([0,0,20])cube([500,500,40],center=true);
    }
}
module tensioner() {
    tensionerBase();
    tensionerExtrusion();
}
module gasket(o1=2.5,o2=2) {
    difference() {
        offset(r=o1)platformSquares();
        offset(r=o2)platformSquares();
    }
}
module gasketMold() {
    difference() {
        translate([0,0,-2])linear_extrude(height=4)hull()gasket(12,11);
        linear_extrude()gasket(8,5);
        translate([0,0,-5])linear_extrude()hull()gasket(1,0);
    }
}
module pla_vat() {
    linear_extrude(height=15)gasket(7,5);
    linear_extrude(height=0.5)difference() {
        gasket(15,5);
        holes();
    }
}
module top() {
    difference() {
        square([125,100],center=true);
        hull()gasket(7.2,5);
        platformHoles();
        holes();
    }
}
module holes(x=57,y=44) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])circle(r=1.5);
    for(i=[-1,1])translate([i*x,0])circle(r=1.5);
    for(i=[-1,1])translate([0,i*y])circle(r=1.5);
}

tensioner();    
gasketMold();
pla_vat();
top();
