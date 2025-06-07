$modelname "props_bts/piston/piston1.mdl"

$staticprop

$body "Body" "piston1_reference.smd"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_bts/piston/"

$sequence "idle" "piston1_reference.smd"

$collisionmodel "piston1_phys.smd"