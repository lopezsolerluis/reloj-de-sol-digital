$fn=100;

module semicilindro(h,r){
  difference(){
    cylinder(h=h,r=r);
     #translate([-2*r,0,-h])
      cube([4*r,2*r,3*h]);
  }
}
