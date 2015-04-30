$fn=50;
tolerance = 1.2;

module platformSquare() {
    import("platformSquare.dxf");
}
module platformHolesTr(x=56.55,y=23.75) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])children();
}
module platformHoles() {
    platformHolesTr()circle(r=2);
}

//Tensioner
module tensioner() {
     linear_extrude(height=1)difference() {
        square([125,80],center=true);
        platformSquare();
        platformHoles();
    }
    intersection(){
        minkowski() {
            linear_extrude(height=12)gasket(.5,0);
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
   for(i=[-1,1])for(j=[-1,1])translate([i*5,j*5])circle(r=1.5);
   for(i=[-1,1])for(j=[-1,1])translate([i*65,j*45])circle(r=1.5);
}

//PLA-Vat
module pla_vat() {
    rotate([0,180,0])difference() {
        linear_extrude(height=9)square([125,100],center=true);
        linear_extrude(height=1.5)gasket(11,5);
        linear_extrude() {
            holes();
            platformHoles();
            offset(r=4)platformSquare();
        }
    }
}

//Middle
module middle() {
    difference() {
        square([125,100],center=true);
        offset(r=4)platformSquare();
        platformHoles();
        holes();
    }
}
module holes(x=57,y=46) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])circle(r=1.5*tolerance);
    for(i=[-1,1])translate([i*x,0])circle(r=1.5*tolerance);
    for(i=[-1,1])translate([0,i*y])circle(r=1.5*tolerance);
}


tensioner();    
moldTop();
moldBottom();
pla_vat();
middle();

