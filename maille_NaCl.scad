/*

    Modèle de maille de chlorure de sodium
    Pour impression 3D

    Olivier Boesch - Lycée Saint Exupéry - Marseille - 2020
    License CC-BY-NC-SA

*/

echelle = 1; //cm <-> 1ang

//finesse de rendu
$fn=$preview?50:120;

//Rayon des atomes
// Sodium
RNa = 9.9 * echelle;
//Chlore
RCl = 18.1 * echelle;

//tolérance pour impression
// <0 pour que les sphère rentre un peu les unes dans les autres
tol=-0.2;

// Nombre de mailles à afficher en x, y et z
Nx=1;
Ny=1;
Nz=1;

//tracé des atomes d'une maille
module atomes_maille_NaCl(){
    for (i=[0:Nx*2]){
        for (j=[0:Ny*2]){
            for (k=[0:Nz*2]){
                if( (i+j+k)%2 == 0){
                    color("grey") translate([i*(RNa+RCl+tol),j*(RNa+RCl+tol),k*(RNa+RCl+tol)]) sphere(r=RNa);
                }
                else{
                    color("green") translate([i*(RNa+RCl+tol),j*(RNa+RCl+tol),k*(RNa+RCl+tol)]) sphere(r=RCl);
                }
            }
        }
    }
}

//tracé d'une maille
module maille_NaCl(){
    intersection(){
        translate([-Nx*(RCl+RNa),-Ny*(RCl+RNa),-Nz*(RCl+RNa)]) atomes_maille_NaCl();
        cube([Nx*2*(RCl+RNa),Ny*2*(RCl+RNa),Nz*2*(RCl+RNa)], center=true);
    }
}

//tracé du vide d'une maille
module vide_maille_NaCl(){
    difference(){
        cube([Nx*2*(RCl+RNa)-0.01,Ny*2*(RCl+RNa)-0.01,Nz*2*(RCl+RNa)-0.01], center=true);
        maille_NaCl();
    }
}

module demi_atome(Ratome=10){
    difference(){
        sphere(Ratome);
        translate([-Ratome-0.5,-Ratome-0.5,0]) cube(2*Ratome+1);
    }
}

module trois_huitiemes_atome(Ratome=10){
    difference(){
        demi_atome(Ratome=Ratome);
        translate([0,-Ratome-1,-Ratome-0.5]) cube(Ratome+1);
    }
}

module quart_atome(Ratome=10){
    difference(){
        demi_atome(Ratome=Ratome);
        translate([-Ratome-0.5,0,-Ratome-1]) cube(2*Ratome+1);
    }
}

maille_NaCl();
//translate([80,0,0]) vide_maille_NaCl();
translate([-50,0,0]) color("grey") demi_atome(Ratome=RNa);
translate([-75,0,0]) color("grey") trois_huitiemes_atome(Ratome=RNa);
translate([-110,0,0]) color("green") demi_atome(Ratome=RCl);
translate([-150,0,0]) color("green") quart_atome(Ratome=RCl);
