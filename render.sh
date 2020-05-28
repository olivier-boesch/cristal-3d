echo "cubique simple"
openscad -o maille_cs.stl maille_cs.scad
echo "cubique centré"
openscad -o maille_cc.stl maille_cc.scad
echo "cubique face centrée"
openscad -o maille_cfc.stl maille_cfc.scad
echo "NaCl"
openscad -o maille_NaCl.stl maille_NaCl.scad

