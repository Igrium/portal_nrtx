$modelname "props/panel_hinge.mdl"

$body "body" "panel_hinge.dmx"
$contents "solid"
$staticprop

$cdmaterials "models/props"

$sequence "idle" "panel_hinge.dmx"

$collisionmodel "panel_hinge_phys.dmx"
{
    $mass 100
    $concave
}