#!/usr/bin/bash

echo "* maille cubique simple"

echo "** maille cubique simple (maille)"
openscad -D 'export="maille"' -o stl/maille_cs.stl scad/maille_cs.scad
echo "** maille cubique simple (vide)"
openscad -D 'export="vide-maille"' -o stl/maille_cs_vide.stl scad/maille_cs.scad
echo "** maille cubique simple (demi-atome)"
openscad -D 'export="demi-atome"' -o stl/maille_cs_demi-atome.stl scad/maille_cs.scad
echo "** maille cubique simple (trois-huitièmes d'atome)"
openscad -D 'export="trois-huitiemes-atome"' -o stl/maille_cs_trois-huitiemes-atome.stl scad/maille_cs.scad

echo "* maille cubique centrée"

echo "** maille cubique centrée (maille)"
openscad -D 'export="maille"' -o stl/maille_cc.stl scad/maille_cc.scad
echo "** maille cubique centrée (vide)"
openscad -D 'export="vide-maille"' -o stl/maille_cc_vide.stl scad/maille_cc.scad
echo "** maille cubique centrée (demi-atome)"
openscad -D 'export="demi-atome"' -o stl/maille_cc_demi-atome.stl scad/maille_cc.scad
echo "** maille cubique centrée (trois-huitièmes d'atome)"
openscad -D 'export="trois-huitiemes-atome"' -o stl/maille_cc_trois-huitiemes-atome.stl scad/maille_cc.scad

echo "* maille cubique face centrée"

echo "** maille cubique face centrée (demi-maille)"
openscad -D 'export="demi-maille"' -o stl/maille_cfc.stl scad/maille_cfc.scad
echo "** maille cubique face centrée (vide)"
openscad -D 'export="vide-maille"' -o stl/maille_cfc_vide.stl scad/maille_cfc.scad
echo "** maille cubique face centrée (demi-atome)"
openscad -D 'export="demi-atome"' -o stl/maille_cfc_demi-atome.stl scad/maille_cfc.scad
echo "** maille cubique face centrée (trois-huitièmes d'atome)"
openscad -D 'export="trois-huitiemes-atome"' -o stl/maille_cfc_trois-huitiemes-atome.stl scad/maille_cfc.scad

echo "done."
