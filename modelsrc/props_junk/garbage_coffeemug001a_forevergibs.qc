// Created by Crowbar 0.74

$ModelName "props_junk/garbage_coffeemug001a_forevergibs.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "mug.smd"
}

$SurfaceProp "pottery"

$Contents "solid"

$IllumPosition 0.048 0 -0.115

$CDMaterials "models\props_junk\"

$CBox 0 0 0 0 0 0

$BBox -2.639 -3.463 -3.08 2.639 3.568 2.918

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"garbage_coffeemug001a_forevergibs_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "garbage_coffeemug001a_forevergibs_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 3

}

$CollisionText
{
	break 
	{
		"model" "props_junk/garbage_coffeemug001a_chunk01"
		"health" "10"
		"fadetime" "0"
	}
	break 
	{
		"model" "props_junk/garbage_coffeemug001a_chunk02"
		"health" "10"
		"fadetime" "0"
	}
	break 
	{
		"model" "props_junk/garbage_coffeemug001a_chunk03"
		"health" "10"
		"fadetime" "0"
	}
}

$KeyValues
{
	prop_data 
	{
		"base" "pottery.Small"
	}
}
