$modelname "props/lab_desk01/lab_desk01.mdl"

$staticprop

$body "body" "lab_desk01.smd"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/lab_desk"

$sequence "idle" "lab_desk01.smd"

$collisionmodel "lab_desk01_physics.smd"
{
    $mass 100
    $concave
}