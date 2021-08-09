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

dos=[[0,1], [0,2], [1,0], [1,3], [2,3], [3,1], [3,2], [4,0], [5,0], [5,1], [5,2], [5,3]];

module digito(alfa,numero){
  for(coords=numero){
    x=(coords.x-2.5)*(alto_pixel+delta_alto);
    y=(coords.y-1.5)*(ancho_pixel+delta_ancho);
    translate([x,y,-0.01])
      rayo_de_sol(alfa);
  }
}

difference(){
  rotate([-90,0,0])
    semicilindro(150,30,center=true);  
  digito(90,dos);
}