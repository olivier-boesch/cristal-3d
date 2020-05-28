/*

    Modèle de maille cubique face centrée
    Pour impression 3D

    Olivier Boesch - Lycée Saint Exupéry - Marseille - 2020
    License CC-BY-NC-SA

*/

//finesse de rendu
$fn=100;

//rendu pour impression
// la moité de la maille s'affiche
impression=$preview?0:1;

//tolérance pour impression
// <0 pour que les sphère rentre un peu les unes dans les autres
tolerance=-0.1;

/* rayon d'éléments chimiques
Fe gamma : 140pm
*/

Ratome = 140; // pm - rayon réel de l'atome
echelle = 10/100; //echelle : 100pm <-> 10 mm
Rayon_atome_echelle = Ratome * echelle; // mm  - rayon à l'échelle

// Nombre de mailles en x, y et z
Nx=1;
Ny=1;
Nz=1;

// tracé des atomes de la maille
module atomes_maille_cfc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = 2*(Ratome+tol) / sqrt(2);
    for (i=[0:2*Nx]){
        for (j=[0:2*Ny]){
            for (k=[0:2*Nz]){
                if( (i+j+k)%2 == 0){
                    translate([i*(Amaille),j*(Amaille),k*(Amaille)]) sphere(r=Ratome);
                }
            }
        }
    }
}

// tracé de la maille
module maille_cfc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = 2*(Ratome+tol) / sqrt(2);
    intersection(){
        translate([-Nx*Amaille,-Ny*Amaille,-Nz*Amaille]) atomes_maille_cfc(Ratome=Ratome,tol=tol,Nx=Nx, Ny=Ny, Nz=Nz);
        if (impression==1){
            translate([0,0,-Nz*Amaille/2]) cube([2*Nx*Amaille,2*Ny*Amaille,Nz*Amaille], center=true);
        }
        else{
            cube([2*Nx*Amaille,2*Ny*Amaille,2*Nz*Amaille], center=true);
        }
    }
}

// tracé du vide de la maille
module vide_maille_cfc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = 2*(Ratome+tol) / sqrt(2);
    difference(){
        cube([2*Nx*Amaille-0.01,2*Ny*Amaille-0.01,2*Nz*Amaille-0.01], center=true);
        maille_cfc(Ratome=Ratome, tol=tol, Nx=Nx, Ny=Ny, Nz=Nz);
    }
}

maille_cfc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);

translate([Rayon_atome_echelle*4,0,0]) vide_maille_cfc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);