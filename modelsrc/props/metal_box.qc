// Created by Crowbar 0.74

$modelname "props/metal_box.mdl"

$body body "metal_box.smd"
$sequence "idle" "metal_box.smd"

// $bodygroup "Body"
// {
// 	studio "metal_box_reference.smd"
// }

// $lod 15
// {
// 	replacemodel "metal_box_reference.smd" "metal_box_reference_lod1.smd"
// 	nofacial
// }
// $lod 35
// {
// 	replacemodel "metal_box_reference.smd" "metal_box_reference_lod2.smd"
// 	nofacial
// }
// $lod 60
// {
// 	replacemodel "metal_box_reference.smd" "metal_box_reference_lod3.smd"
// 	nofacial
// }
// $lod 80
// {
// 	replacemodel "metal_box_reference.smd" "metal_box_reference_lod4.smd"
// 	nofacial
// }

$surfaceprop "metalpanel"

$contents "solid"

$cdmaterials "models/props/"

// $texturegroup "skinfamilies"
// {
// 	{ "metal_box"         }
// 	{ "metal_box_skin001" }
// }

$collisionmodel "metal_box_phys.smd"
{
	$mass 40
	$inertia 1
	$damping 0.1
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$keyvalues
{
	prop_data 
	{
		"base" "Metal.small"
	}
}
