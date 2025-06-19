$modelname "props/lab_desk04/lab_desk04.mdl"

$staticprop

$body "body" "lab_desk04.smd"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/lab_desk04"

$sequence "idle" "lab_desk04.smd"

$collisionmodel "lab_desk04_physics.smd"
{
    $mass 100
    $concave
}