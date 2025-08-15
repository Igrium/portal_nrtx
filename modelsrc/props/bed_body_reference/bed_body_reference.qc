$modelname "props/bed_body_reference.mdl"
$staticprop

$body "body" "bed_body_reference.dmx"

$surfaceprop "metalpanel"
$contents "solid"

$cdmaterials "models/props"

$sequence "idle" "bed_body_reference.dmx"

$collisionmodel "bed_body_reference_physics.dmx"
{
    $mass 120
    $concave
}