$fn=100;

module platformSquare() {
    import("platformSquare.dxf");
}
module platformHolesTr(x=56.55,y=23.75) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])children();
}
module platformHoles(r=2) {
    platformHolesTr()circle(r);
}

//Tensioner
module tensioner() {
     linear_extrude(height=1)difference() {
        square([125,80],center=true);
        platformSquare();
        platformHoles(5);
    }
    intersection(){
        minkowski() {
            linear_extrude(height=6)gasket(.5,0);
            sphere(r=2);
        }
        translate([0,0,20])cube([500,500,40],center=true);
    }
}

//Gasket
module gasket(o1=10,o2=5) {
    difference() {
        offset(r=o1)platformSquare();
        offset(r=o2)platformSquare();
    }
}

//Gasket-Mold
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
   for(i=[-1,1])for(j=[-1,1])translate([i*15,j*15])circle(r=1.5);
   for(i=[-1,1])for(j=[-1,1])translate([i*65,j*45])circle(r=1.5);
}

//PLA-Vat
module pla_vat() {
    rotate([0,180,0])difference() {
        linear_extrude(height=9)square([125,100],center=true);
        linear_extrude(height=1.5)gasket(11,5);
        linear_extrude() {
            holes();
            platformHoles(r=2.5);
            offset(r=4)platformSquare();
        }
    }
}

//Middle
module middle() {
    rotate([0,180,0]){
        linear_extrude(height=3)difference() {
            square([125,100],center=true);
            offset(r=4)platformSquare();
            platformHolesTr()circle(r=5);
            holes(r=3.2,fn=6);
        }
        translate([0,0,3])linear_extrude(height=2)difference() {
            square([125,100],center=true);
            offset(r=4)platformSquare();
            platformHoles(r=2.5);
            holes();
        }
    }
}
module holes(x=57,y=46,r=1.5,tolerance=1.2,fn=$fn) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])circle(r=r*tolerance,$fn=fn);
    for(i=[-1,1])translate([i*x,0])circle(r=r*tolerance,$fn=fn);
    for(i=[-1,1])translate([0,i*y])circle(r=r*tolerance,$fn=fn);
}


tensioner();    
moldTop();
moldBottom();
pla_vat();
middle();

