$modelname "props/round_elevator_body.mdl"

$surfaceprop "metalpanel"

$contents "solid"
$illumposition 0.078 0.078 69.542

$cdmaterials "models/props/"

$body frame "round_elevator_frame.smd"
$body exterior "round_elevator_exterior.smd"
$body interior "round_elevator_interior.smd"

$sequence "idle" "round_elevator_frame.smd"

$collisionmodel "round_elevator_physics.smd"
{
    $mass 120
    $concave
    $maxconvexpieces 21
}
