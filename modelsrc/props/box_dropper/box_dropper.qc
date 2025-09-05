$modelname "props/box_dropper.mdl"
$staticprop

$body "body" "box_dropper.dmx"

$surfaceprop "metalpanel"
$contents "solid"

$cdmaterials "models/props/"

$sequence "idle" "box_dropper.dmx"

$collisionmodel "box_dropper_physics.dmx"
{
    $mass 120
    $concave
}

$lod 11
{
    replacemodel "box_dropper.dmx" "box_dropper_lod1.dmx"
}