$fn=100;

module semicilindro(h,r,center=false){
  difference(){
    cylinder(h=h,r=r,center=center);
    translate([-2*r,0,-h])
      cube([4*r,2*r,3*h]);
  }
}

alto_pixel = 2;
radio_semicilindro = 30;
H = radio_semicilindro+10;

module rayo_de_sol(alfa){
  D=H/tan(alfa);
  vertices=[[-alto_pixel/2,0],
            [D-alto_pixel/2,H],
            [D+alto_pixel/2,H],
            [alto_pixel/2,0]];
  polygon(vertices);
}
 
rayo_de_sol(alfa=60);

