$modelname "props/lab_desk05/lab_desk05.mdl"

$staticprop

$body "body" "lab_desk05.smd"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/lab_desk"

$sequence "idle" "lab_desk05.smd"

$collisionmodel "lab_desk05_physics.smd"
{
    $mass 100
    $concave
}