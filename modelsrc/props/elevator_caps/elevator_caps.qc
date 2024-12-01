$modelname "props\elevator_caps\elevator_caps.mdl"

$staticprop

$body elevator_caps "elevator_caps.smd"

// $bodygroup "elevator_caps"
// {
// 	studio "elevator_caps_reference.smd"
// }

// $lod 100
// {
// 	replacemodel "elevator_caps_reference.smd" "elevator_caps_reference_lod1.smd"
// 	nofacial
// }

$surfaceprop "metal"

$contents "solid"

$illumposition 0 131.153 -4.835

$cdmaterials "models/props/elevator_caps"

// $collisionmodel "elevator_caps_phys.smd"
// {
//     $concave
// }

$sequence "idle" "elevator_caps.smd"

// $cbox 0 0 0 0 0 0

// $bbox -275.822 -132.55 -105.826 11.122 132.55 96.94

// $definebone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


// $sequence "idle" {
// 	"elevator_caps_anims\idle.smd"
// 	activity "ACT_IDLE" 1
// 	fadein 0.2
// 	fadeout 0.2
// 	fps 30
// }



$collisionmodel "elevator_caps_phys.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 19

}
