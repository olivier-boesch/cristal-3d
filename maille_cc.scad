/*

    Modèle de maille cubique centrée
    Pour impression 3D

    Olivier Boesch - Lycée Saint Exupéry - Marseille - 2020
    License CC-BY-NC-SA 4.0

*/

//finesse de rendu
$fn=$preview?60:150;

//tolérance pour impression
// <0 pour que les sphère rentre un peu les unes dans les autres
tolerance=-0.2;

/* rayons d'éléments chimiques
Fe alpha : 140 pm
*/

Ratome = 140; // pm - rayon réel de l'atome
echelle = 10/100; // echelle : 100pm <-> 10 mm
Rayon_atome_echelle = Ratome / 10; // mm  - rayon à l'échelle

// Nombre de mailles en x, y et z
Nx=1;
Ny=1;
Nz=1;

//calcul du paramètre de maille
function a_maille(Ratome, tol) = 4*(Ratome+tol)/sqrt(3);

//tracé des atomes de la maille
module atomes_maille_cc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = a_maille(Ratome, tol);
    for (i=[0:Nx]){
        for (j=[0:Ny]){
            for (k=[0:Nz*2]){
                if(k%2==0){
                    translate([i*(Amaille),j*(Amaille),k/2*(Amaille)]) sphere(r=Ratome);
                }
                else{
                    if((i<Nx)&&(j<Ny)){
                        translate([(i+0.5)*Amaille,(j+0.5)*(Amaille),k/2*(Amaille)]) sphere(r=Ratome);
                    }
                }
            }
        }
    }
}

//tracé de la maille
module maille_cc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = a_maille(Ratome, tol);
    intersection(){
        translate([-Nx*Amaille/2,-Ny*Amaille/2,-Nz*Amaille/2]) atomes_maille_cc(Ratome=Ratome,tol=tol,Nx=Nx, Ny=Ny, Nz=Nz);
        cube([Nx*Amaille,Ny*Amaille,Nz*Amaille], center=true);
    }
}

//tracé du vide de la maille
module vide_maille_cc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = a_maille(Ratome, tol);
    tolerance_decoupe=-0.01;
    difference(){
        cube([Nx*Amaille+tolerance_decoupe,Ny*Amaille+tolerance_decoupe,Nz*Amaille+tolerance_decoupe], center=true);
        maille_cc(Ratome=Ratome, tol=tol, Nx=Nx, Ny=Ny, Nz=Nz);
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

translate([-Rayon_atome_echelle*3,0,0])  demi_atome(Ratome=Rayon_atome_echelle);
translate([-Rayon_atome_echelle*6,0,0])  trois_huitiemes_atome(Ratome=Rayon_atome_echelle);

maille_cc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);

//translate([Rayon_atome_echelle*3,0,0]) vide_maille_cc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);