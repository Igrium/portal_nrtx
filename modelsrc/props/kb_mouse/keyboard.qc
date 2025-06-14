$modelname "props/kb_mouse/keyboard.mdl"

$staticprop
$body "body" "keyboard.smd"

$surfaceprop "plastic"
$contents "solid"

$cdmaterials "models/props/kb_mouse/"

$sequence "idle" "keyboard.smd"

$collisionmodel "keyboard_physics"
{
    $mass 3
}

$keyvalues
{
	prop_data 
	{
		"base" "Plastic.Medium"
	}
}
