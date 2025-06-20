$modelname "props/lab_desk03/lab_desk03.mdl"

$staticprop

$body "body" "lab_desk03.smd"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/lab_desk03"

$sequence "idle" "lab_desk03.smd"

$collisionmodel "lab_desk03_physics.smd"
{
    $mass 100
    $concave
}