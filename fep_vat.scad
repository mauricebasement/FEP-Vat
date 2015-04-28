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
module gasket(o1=10,o2=5) {
    difference() {
        offset(r=o1)platformSquares();
        offset(r=o2)platformSquares();
    }
}
module gasketMold() {
    difference() {
        translate([0,0,-1])linear_extrude(height=2)offset(r=12)platformSquares();
        linear_extrude()gasket();
        translate([0,0,-5])linear_extrude()offset(r=1)platformSquares();
    }
}
module moldTop() {
    difference() {
        square([140,100],center=true);
        gasket();
        moldHoles();
    }
}
module moldBottom() {
    difference() {
        square([140,100],center=true);
        moldHoles();
    }
}
module moldHoles() {
   for(i=[-1,1])for(j=[-1,1])translate([i*5,j*5])circle(r=1.5);
   for(i=[-1,1])for(j=[-1,1])translate([i*65,j*45])circle(r=1.5);
}
module pla_vat() {
    difference() {
        linear_extrude(height=9)square([125,100],center=true);
        linear_extrude(height=1.5)gasket(10,5);
        linear_extrude() {
            holes();
            platformHoles();
            offset(r=4)platformSquares();
        }
    }
}
module middle() {
    difference() {
        square([125,100],center=true);
        offset(r=4)platformSquares();
        platformHoles();
        holes();
    }
}
module holes(x=57,y=44) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])circle(r=1.5*tolerance);
    for(i=[-1,1])translate([i*x,0])circle(r=1.5*tolerance);
    for(i=[-1,1])translate([0,i*y])circle(r=1.5*tolerance);
}

tensioner();    
gasketMold();
moldTop();
!moldBottom();
rotate([0,180,0])pla_vat();
middle();
