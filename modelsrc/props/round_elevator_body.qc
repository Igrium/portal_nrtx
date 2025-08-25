$modelname "props/round_elevator_body.mdl"
$staticprop

$surfaceprop "metalpanel"

$contents "solid"

$cdmaterials "models/props/"

$body frame "round_elevator_frame.smd"
$body exterior "round_elevator_exterior.smd"
$body interior "round_elevator_interior.smd"

$sequence "idle" "round_elevator_exterior.smd"

// $attachment "statPanel0_bl" "Screen_BL" 0 8 0 rotate -45 0 0
// $attachment "statPanel0_tr" "Screen_TR" 0 -8 0 rotate -45 0 0

// $definebone "Scene_Root" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0
// $definebone "Root" "Scene_Root" 0 0 0 0 0 0 0 0 0 0 0 0
// $definebone "Screen_TR" "Root" 75.126396 94.613602 -7.221797 0 0 0 0 0 0 0 0 0
// $definebone "Screen_BL" "Root" 7.668623 30.828308 -74.930145 0 0 0 0 0 0 0 0 0

// $collisionmodel "round_elevator_physics.smd"
// {
//     $mass 120
//     $concave
//     $maxconvexpieces 21
//     $rootbone " "
// }
