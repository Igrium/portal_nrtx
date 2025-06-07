$modelname "props_bts/piston/piston_head.mdl"

$staticprop

$body "Body" "piston_head_reference.smd"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_bts/piston/"

$sequence "idle" "piston_head_reference.smd"

$collisionmodel "piston_head_phys.smd"