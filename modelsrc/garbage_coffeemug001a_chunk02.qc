// Created by Crowbar 0.74

$ModelName "props_junk/garbage_coffeemug001a_chunk02.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "mug_gib02.smd"
}


$SurfaceProp "pottery"

$Contents "solid"

$IllumPosition -1.619 0.185 -0.115

$CDMaterials "models\rtx/props_junk\"

$CBox 0 0 0 0 0 0

$BBox -2.652 -3.748 -3.229 2.31 0 3.051

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"garbage_coffeemug001a_chunk02_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "garbage_coffeemug001a_chunk02_physics.smd"
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
