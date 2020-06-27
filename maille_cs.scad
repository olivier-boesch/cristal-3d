/*

    Modèle de maille cubique simple
    Pour impression 3D

    Olivier Boesch - Lycée Saint Exupéry - Marseille - 2020
    License CC-BY-NC-SA

*/

//finesse de rendu
$fn=$preview?50:150;

//tolérance pour impression
// <0 pour que les sphère rentre un peu les unes dans les autres
tolerance=-0.2;

/* rayon atomique d'elements chimiques
Po : 190 pm
*/

Ratome = 190; // pm - rayon réel de l'atome
echelle = 10 / 100; // echelle : 100pm <-> 10 mm
Rayon_atome_echelle = Ratome * echelle; // mm  - rayon à l'échelle

// Nombre de mailles à afficher en x, y et z
Nx=1;
Ny=1;
Nz=1;

//Calcul du paramètre de la maille
function a_maille(Ratome, tol) = 2*(Ratome+tol);

//tracé des atomes d'une maille
module atomes_maille_cs(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = a_maille(Ratome, tol);
    for (i=[0:Nx]){
        for (j=[0:Ny]){
            for (k=[0:Nz]){
                translate([i*(Amaille),j*(Amaille),k*(Amaille)]) sphere(r=Ratome);
            }
        }
    }
}

//tracé de la maille seule
module maille_cs(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = a_maille(Ratome, tol);
    intersection(){
        translate([-Nx*Amaille/2,-Ny*Amaille/2,-Nz*Amaille/2]) atomes_maille_cs(Ratome=Ratome,tol=tol,Nx=Nx, Ny=Ny, Nz=Nz);
        cube([Nx*Amaille,Ny*Amaille,Nz*Amaille], center=true);
    }
}

//tracé du vide de la maille seule
module vide_maille_cs(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = a_maille(Ratome, tol);
    difference(){
        cube([Nx*Amaille-0.05,Ny*Amaille-0.05,Nz*Amaille-0.05], center=true);
        maille_cs(Ratome=Ratome, tol=tol, Nx=Nx, Ny=Ny, Nz=Nz);
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

translate([-50,0,0])demi_atome(Ratome=Rayon_atome_echelle);
translate([-100,0,0]) trois_huitiemes_atome(Ratome=Rayon_atome_echelle);
maille_cs(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);
//translate([50,0,0]) vide_maille_cs(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);