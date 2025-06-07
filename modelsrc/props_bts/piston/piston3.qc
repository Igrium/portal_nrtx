$modelname "props_bts/piston/piston3.mdl"

$staticprop

$body "Body" "piston3_reference.smd"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_bts/piston/"

$sequence "idle" "piston3_reference.smd"

$collisionmodel "piston3_phys.smd"