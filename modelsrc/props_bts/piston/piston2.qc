$modelname "props_bts/piston/piston2.mdl"

$staticprop

$body "Body" "piston2_reference.smd"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_bts/piston/"

$sequence "idle" "piston2_reference.smd"

$collisionmodel "piston2_phys.smd"