$fn=50;
use<square.scad>;
use<holes.scad>;

tolerance = 1.2;

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
            linear_extrude(height=12)gasket(.5,0);
            sphere(r=2);
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
        translate([0,0,-1])linear_extrude(height=2)hull()gasket(12,11);
        linear_extrude()gasket(8,5);
        translate([0,0,-5])linear_extrude()hull()gasket(1,0);
    }
}
module moldTop() {
    difference() {
        hull()gasket(30,11);
        gasket(8,5);
        moldHoles();
    }
}
module moldBottom() {
    difference() {
        hull()gasket(30,11);
        moldHoles();
    }
}
module moldHoles() {
   for(i=[-1,1])for(j=[-1,1])translate([i*5,j*5])circle(r=1.5);
   for(i=[-1,1])for(j=[-1,1])translate([i*65,j*32])circle(r=1.5);
}
module pla_vat() {
    linear_extrude(height=15)gasket(7,4);
    translate([0,0,-1])linear_extrude(height=2)gasket(5,4);
    difference() {
        translate([0,0,6])linear_extrude(height=9)square([125,100],center=true);
        linear_extrude() {
            holes();
            platformHoles();
            hull()gasket(4,1);
        }
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
module middle() {
    difference() {
        square([125,100],center=true);
        hull()gasket(5,4);
        platformHoles();
        holes();
    }
}
module holes(x=57,y=44) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])circle(r=1.5*tolerance);
    for(i=[-1,1])translate([i*x,0])circle(r=1.5*tolerance);
    for(i=[-1,1])translate([0,i*y])circle(r=1.5*tolerance);
}

!tensioner();    
gasketMold();
rotate([0,180,0])pla_vat();
top();
middle();
moldTop();
moldBottom();