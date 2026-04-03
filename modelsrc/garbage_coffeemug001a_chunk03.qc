// Created by Crowbar 0.74

$ModelName "props_junk/garbage_coffeemug001a_chunk03.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "mug_gib03.smd"
}


$SurfaceProp "pottery"

$Contents "solid"

$IllumPosition -1.023 1.172 -0.115

$CDMaterials "models\props_junk\"

$CBox 0 0 0 0 0 0

$BBox -2.697 -3.001 -3.174 0.175 1.023 3.026

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"garbage_coffeemug001a_chunk03_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "garbage_coffeemug001a_chunk03_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$KeyValues
{
	prop_data 
	{
		"base" "pottery.Small"
	}
}
