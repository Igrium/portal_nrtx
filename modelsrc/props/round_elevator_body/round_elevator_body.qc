$modelname "props/round_elevator_body.mdl"
// $staticprop

$surfaceprop "metalpanel"

$contents "solid"

$cdmaterials "models/props/round_elevator"

$body body "round_elevator_body.dmx"

$sequence "idle" "round_elevator_body.dmx"

$attachment "statPanel0_bl" "" -38.828308 7.668623 -74.930145 rotate -45 0 90
$attachment "statPanel0_tr" "" -86.613602 75.126396 -7.221797 rotate -45 0 90

$collisionmodel "round_elevator_body_physics.dmx"
{
    $mass 120
    $concave
}
