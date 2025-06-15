$modelname "props/lab_desk02/lab_desk02.mdl"

$staticprop

$body "body" "lab_desk02.smd"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/lab_desk"

$sequence "idle" "lab_desk02.smd"

$collisionmodel "lab_desk02_physics.smd"
{
    $mass 100
    $concave
}