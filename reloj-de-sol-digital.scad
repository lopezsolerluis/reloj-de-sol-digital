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
hemisferio="sur";

function alfa_sur(hora)=270-15*hora; 
function alfa_norte(hora)=15*hora-90;

function alfa(hora)=
  hemisferio=="sur" ? alfa_sur(hora) : alfa_norte(hora);

function truncate(n)=
  n<0 ? ceil(n) : floor(n);

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

digitos = [
[[0, 1 ,1, 0], // cero
 [1, 0, 0, 1],
 [1, 0, 1, 1],
 [1, 1, 0, 1],
 [1, 0, 0, 1],
 [0, 1, 1, 0]],
[[0, 1, 0 ,0], // uno
 [1, 1, 0, 0],
 [0, 1, 0, 0],
 [0, 1, 0, 0],
 [0, 1, 0, 0],
 [1, 1, 1, 0]],
[[0, 1 ,1, 0], // dos
 [1, 0, 0, 1],
 [0, 0, 0, 1],
 [0, 1, 1, 0],
 [1, 0, 0, 0],
 [1, 1, 1, 1]],
[[0, 1 ,1, 0],  // tres
 [1, 0, 0, 1],
 [0, 0, 1, 1],
 [0, 0, 0, 1],
 [1, 0, 0, 1],
 [0, 1, 1, 0]],
[[1, 0 ,0, 1],  //cuatro
 [1, 0, 0, 1],
 [1, 0, 0, 1],
 [1, 1, 1, 1],
 [0, 0, 0, 1],
 [0, 0, 0, 1]],
[[1, 1 ,1, 1],  // cinco
 [1, 0, 0, 0],
 [1, 1, 1, 0],
 [0, 0, 0, 1],
 [0, 0, 0, 1],
 [1, 1, 1, 0]],
[[0, 1 ,1, 0],  // seis
 [1, 0, 0, 0],
 [1, 1, 1, 0],
 [1, 0, 0, 1],
 [1, 0, 0, 1],
 [0, 1, 1, 0]],
[[1, 1 ,1, 0],  // siete
 [0, 0, 1, 0],
 [0, 1, 0, 0],
 [0, 1, 0, 0],
 [0, 1, 0, 0],
 [0, 1, 0, 0]],
[[0, 1 ,1, 0],  // ocho
 [1, 0, 0, 1],
 [0, 1, 1, 0],
 [1, 0, 0, 1],
 [1, 0, 0, 1],
 [0, 1, 1, 0]],
[[0, 1 ,1, 0],  // nueve
 [1, 0, 0, 1],
 [1, 0, 0, 1],
 [0, 1, 1, 1],
 [0, 0, 0, 1],
 [0, 1, 1, 0]]];
 
module digito(alfa,numero){
  for(i=[0:5],j=[0:3]){
    digito=digitos[numero];
    if(digito[i][j]==1){
      x=(i-2.5)*(alto_pixel+delta_alto);
      y=(j-1.5)*(ancho_pixel+delta_ancho);
      translate([x,y,-0.01])
        rayo_de_sol(alfa);
    }
  }
}

module hora_solar(horas,
                  minutos){
  alfa=alfa(horas+minutos/60);
}

difference(){
  rotate([-90,0,0])
    semicilindro(150,30,center=true);  
  digito(90,2);
}