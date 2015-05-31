$fn=200;

module platformSquare() {
    import("platformSquare.dxf");
}
module platformHolesTr(x=56.55,y=23.75) {
    for(i=[-1,1])for(j=[-1,1])translate([i*x,j*y])children();
}
module platformHoles(r=2) {
    platformHolesTr()circle(r);
}

//TensionerVAT
module tensionerVat() {
     linear_extrude(height=3)difference() {
        square([125,108],center=true);
        platformSquare();
        platformHoles(2.75);
    }
    difference() {
        intersection(){
            minkowski() {
                linear_extrude(height=23.2)ring(1,0);
                scale([1,1,1])sphere(r=6);
            }
            translate([0,0,20])cube([500,500,40],center=true);
        }
        linear_extrude(height=40)platformSquare();
        linear_extrude(height=40)ring(20,6);
    }
    translate([0,0,3])linear_extrude(height=5)sheetTop();
}
module ring(o1=10,o2=5) {
    difference() {
        offset(r=o1)platformSquare();
        offset(r=o2)platformSquare();
    }
}

//ClampTop
module clampTop() {
    rotate([0,180,0])difference() {
        linear_extrude(height=5)square([125,108],center=true);
        linear_extrude() {
            holes();
            platformHoles(r=2.75);
            offset(r=11)platformSquare();
        }
    }
    translate([0,0,0])linear_extrude(height=.6)press();
}
module top() {
    difference() {
        offset(r=0){
            difference() {
                square([125,108],center=true);
                offset(r=11)platformSquare();
            }
        }
        offset(r=0){
            holes();
            platformHoles(r=2.75);
        }
    }
}
module press() {
    intersection() {
        rotate([0,0,45])support_raw(x=200,y=200,d=4,t=0.6);
        top();
    }
}
module support_raw(x=20,y=20,d=1.1,t=0.15) {
    for(i=[-1,1])for(j=[0:d:x/2])translate([i*j,0])square([t,y],center=true);
    for(i=[-1,1])for(j=[0:d:x/2])translate([0,i*j])square([x,t],center=true);
}

//Clamp Bottom
module clampBottom() {
    rotate([0,0,0]){
        linear_extrude(height=3)difference() {
            square([125,108],center=true);
            offset(r=11)platformSquare();
            platformHolesTr()circle(r=2.75);
            holes(r=3.4,tolerance=1,fn=6);
        }
        translate([0,0,3])linear_extrude(height=2)difference() {
            square([125,108],center=true);
            offset(r=11)platformSquare();
            platformHoles(r=2.75);
            holes();
        }
        translate([0,0,5])linear_extrude(height=.6)difference() {
            square([125,108],center=true);
            offset(r=.4)press();
            offset(r=11)platformSquare();
            offset(r=0){
                holes();
                platformHoles(r=2.75);
            }
        }
    }
}
module holes(x=57,y=48,r=1.5,tolerance=1.2,fn=$fn) {
    for(i=[-1,1])for(j=[-1,1]){
        translate([i*x,j*y])circle(r=r*tolerance,$fn=fn);
        translate([i*x/2,j*y])circle(r=r*tolerance,$fn=fn);
        //translate([i*x,j*y/2-j*9])circle(r=r*tolerance,$fn=fn);
    }
    for(i=[-1,1]){
        translate([0,i*y])circle(r=r*tolerance,$fn=fn);
        translate([i*x,0])circle(r=r*tolerance,$fn=fn);
    }
}

//FEP-Film
module fepFilm() {
    difference(){
        square([125,108],center=true);
        holes();
        platformHoles(r=2.75);
    }
}

//Sheets
module sheetBottom() {
    difference() {
        difference(){
            square([125,108],center=true);
            platformHoles(r=4.5);
        }
        offset(r=9)platformSquare();
    }
}
module sheetMiddle() {
    difference() {
        difference(){
            square([125,108],center=true);
            platformHoles(r=2.75);
        }
        offset(r=9)platformSquare();
    }
}
module sheetTop() {
    difference() {
        difference(){
            square([125,108],center=true);
            holes(r=3.5,tolerance=1);
            platformHoles(r=2.75);
        }
        offset(r=5)platformSquare();
    }
}
module assembly() {
    linear_extrude(height=5)sheetBottom();
    translate([0,0,5.1])linear_extrude(height=5)sheetMiddle();
    translate([0,0,10.2])clampBottom();
    *translate([0,0,15.8])linear_extrude(height=0.127)fepFilm();
    translate([0,0,16])rotate(a=[180,0,0])clampTop(); 
    translate([0,0,29.1])rotate(a=[180,0,0])tensionerVat();  
}

*assembly();
sheetBottom();
sheetMiddle();
clampBottom();
fepFilm();
clampTop();
tensionerVat();    



