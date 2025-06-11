$modelname "props/water_bottle/water_bottle.mdl"

$staticprop

$body "body" "water_bottle_reference.smd"

$surfaceprop "plastic_barrel"
$contents "solid"

$cdmaterials "models/props/water_bottle"

$sequence "idle" "water_bottle_reference.smd"

$collisionmodel "water_bottle_physics.smd"

$keyvalues
{
	prop_data 
	{
		"base" "Plastic.Medium"
	}
}
