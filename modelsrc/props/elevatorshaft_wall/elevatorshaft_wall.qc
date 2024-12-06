$modelname "props/elevatorshaft_wall/elevatorshaft_wall.mdl"

$staticprop

$body "body" "elevatorshaft_wall.smd"

$surfaceprop "metal"
$contents "solid"

$illumposition 0.021 159.589 0

$cdmaterials "models/props/elevatorshaft_wall/"

$sequence "idle" "elevatorshaft_wall.smd"

$collisionmodel "elevatorshaft_wall_physics.smd"
{
    $mass 1
    $concave
}