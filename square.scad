module platformSquares(){
      scale([25.4/90, -25.4/90, 1])hull() {
        translate([144.921262,-93.188985],[127.204719,-110.905524])square(0.01,center=true);
        translate([127.204719,-110.905524],[-127.204723,-110.905524])square(0.01,center=true);
        translate([144.921262,93.188986],[144.921262,-93.188985])square(0.01,center=true);
        translate([127.204719,110.905524],[144.921262,93.188986])square(0.01,center=true);
        translate([-127.204723,110.905524],[127.204719,110.905524])square(0.01,center=true);
        translate([-144.921262,93.188986],[-127.204723,110.905524])square(0.01,center=true);
        translate([-144.921262,-93.188985],[-144.921262,93.188986])square(0.01,center=true);
        translate([-127.204723,-110.905524],[-144.921262,-93.188985])square(0.01,center=true);
    }
}
