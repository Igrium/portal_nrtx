$modelname "props_c17/substation_transformer01b.mdl"

$body "body" "substation_transformer01b_reference.smd"
$staticprop 

$surfaceprop "metal"
$contents "solid"
$cdmaterials "models/props_c17"

$sequence "idle" "substation_transformer01b_reference.smd"

$collisionmodel "substation_transformer01b_physics.smd"
{
    $mass 460
    $concave
}