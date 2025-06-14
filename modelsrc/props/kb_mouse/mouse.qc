$modelname "props/kb_mouse/mouse.mdl"

$staticprop
$body "body" "mouse.smd"

$surfaceprop "plastic"
$contents "solid"

$cdmaterials "models/props/kb_mouse/"

$sequence "idle" "mouse.smd"

$collisionmodel "mouse_physics"
{
    $mass 1
}

$keyvalues
{
	prop_data 
	{
		"base" "Plastic.Medium"
	}
}
