/*

    Modèle de maille cubique face centrée
    Pour impression 3D

    Olivier Boesch - Lycée Saint Exupéry - Marseille - 2020
    License CC-BY-NC-SA

*/

//finesse de rendu
$fn=$preview?50:200;

//quoi exporter
export = "demi-maille"; // "demi-maille", "vide-maille", "demi-atome", "trois-huitiemes-atome"

//rendu pour impression
// la moité de la maille s'affiche
impression=$preview?0:1;

//tolérance pour impression
// <0 pour que les sphère rentre un peu les unes dans les autres
tolerance=-0.1;

Rayon_atome_echelle = 20;

// Nombre de mailles en x, y et z
Nx=1;
Ny=1;
Nz=1;

//Calcul du paramètre de maille
function a_maille(Ratome, tol) = 2*(Ratome+tol) / sqrt(2);

// tracé des atomes de la maille
module atomes_maille_cfc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1){
    Amaille = a_maille(Ratome, tol);
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
module maille_cfc(Ratome=10, tol=0, Nx=1, Ny=1, Nz=1, impression=0){
    Amaille = a_maille(Ratome, tol);
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
    Amaille = a_maille(Ratome, tol);
    difference(){
        cube([2*Nx*Amaille-0.01,2*Ny*Amaille-0.01,2*Nz*Amaille-0.01], center=true);
        maille_cfc(Ratome=Ratome, tol=tol, Nx=Nx, Ny=Ny, Nz=Nz, impression=0);
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

if($preview){
	translate([-Rayon_atome_echelle*3,0,0]) demi_atome(Ratome=Rayon_atome_echelle);
	translate([-Rayon_atome_echelle*6,0,0]) trois_huitiemes_atome(Ratome=Rayon_atome_echelle);

	maille_cfc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz, impression=impression);
	translate([Rayon_atome_echelle*4,0,0]) vide_maille_cfc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);
}
else{
	if(export == "demi-atome") rotate([180,0,0]) demi_atome(Ratome=Rayon_atome_echelle);
	if(export == "trois-huitiemes-atome")  rotate([180,0,0]) trois_huitiemes_atome(Ratome=Rayon_atome_echelle);
	if(export == "demi-maille") maille_cfc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz, impression=1);
	if(export == "vide-maille") vide_maille_cfc(Ratome=Rayon_atome_echelle, tol=tolerance, Nx=Nx, Ny=Ny, Nz=Nz);
}