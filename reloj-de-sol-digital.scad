$fn=100;

module semicilindro(h,r,center=false){
  difference(){
    cylinder(h=h,r=r,center=center);
    translate([-2*r,0,-h])
      cube([4*r,2*r,3*h]);
  }
}

hemisferio="sur";
alto_pixel = 2;
ancho_pixel = 6;
delta_alto  = 6.5;
delta_ancho = 1.5;
borde = 10;
radio_semicilindro = 30;
H = radio_semicilindro+10;
largo_reloj = 21*ancho_pixel + 20*delta_ancho + 2*borde;

function alfa_sur(hora)=270-15*hora; 
function alfa_norte(hora)=15*hora-90;

function alfa(hora)=
  hemisferio=="sur" ? alfa_sur(hora) : alfa_norte(hora);

function truncate(n)=
  n<0 ? ceil(n) : floor(n);

// p es la posicion del digito a obtener: 
// 0 para las unidades, 1 para las decenas, etc.
function n_a_digito(n,p)= 
  truncate(n/pow(10,p))%10;

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
  hora=horas+minutos/60;
  assert(hora!=6 && hora!=18,"La hora no debe ser las 6:00 ni las 18:00.");
  alfa=alfa(hora);
  hora_decenas=n_a_digito(horas,1);
  hora_unidades=n_a_digito(horas,0);
  minuto_decenas=n_a_digito(minutos,1);
  minuto_unidades=n_a_digito(minutos,0);

  delta_y=ancho_pixel+delta_ancho;
   // horas         
  if (hora_decenas != 0)
    translate([0,-8.5*delta_y,0])
      digito(alfa,hora_decenas);
  translate([0,-3.5*delta_y,0])
    digito(alfa,hora_unidades);  
  // minutos
  translate([0,3.5*delta_y,0])
    digito(alfa,minuto_decenas);
  translate([0,8.5*delta_y,0])
    digito(alfa,minuto_unidades);        
  // separador
  separador(horas,minutos);
}

module separador(horas,minutos){
  alfa=alfa(horas+minutos/60);
  for(i=[-1,1])
    translate([i*0.5*(alto_pixel+delta_alto), 0,-.01])
      rayo_de_sol(alfa);
}
 
module cuerpo(largo){
  rotate([-90,0,0])
    semicilindro(largo, radio_semicilindro, center=true);  
}

module reloj_de_sol(){
  difference(){
    cuerpo(largo_reloj);
    hora_solar(18,0);
  }
}

reloj_de_sol();
