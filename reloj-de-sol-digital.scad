$fn=100;

module semicilindro(h,r,center=false){
  difference(){
    cylinder(h=h,r=r,center=center);
    translate([-2*r,0,-h])
      cube([4*r,2*r,3*h]);
  }
}

alto_pixel = 2;
ancho_pixel = 6;
delta_alto  = 6.5;
delta_ancho = 1.5;
radio_semicilindro = 30;
H = radio_semicilindro+10;

module rayo_de_sol(alfa){
  D=H/tan(alfa);
  vertices=[[-alto_pixel/2,0],
            [D-alto_pixel/2,H],
            [D+alto_pixel/2,H],
            [alto_pixel/2,0]];
  // TODO: medir la duracion de esta solucion
  //       y la de esta otra:
  //       translate([0,ancho_pixel/2,0])
  //       Ojo : borrar 'center=true' abajo
  rotate ([90,0,0])
    linear_extrude(ancho_pixel,center=true)
      polygon(vertices);
}
 
module digito(alfa){
  for(i=[0:5],j=[0:3]){
    x=(i-2.5)*(alto_pixel+delta_alto);
    y=(j-1.5)*(ancho_pixel+delta_ancho);
    translate([x,y,-0.01])
      rayo_de_sol(alfa);
  } 
}

difference(){
  rotate([-90,0,0])
    semicilindro(150,30,center=true);  
  digito(alfa=90);
}