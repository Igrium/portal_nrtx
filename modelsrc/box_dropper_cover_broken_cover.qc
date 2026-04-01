// Created by Crowbar 0.74

$ModelName "props/Box_dropper_cover_broken_cover.mdl"

$BodyGroup "Body"
{
	studio "dropper_broken_cover.smd"
}


$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0.042 0.189 -0.639

$CDMaterials "models\rtx\props\vactubes\"
$TextureGroup "skinfamilies"
{
	{ "box_dropper_cover" }
	{ "box_dropper_cover_orange" }
	{ "box_dropper_cover_red" }
	{ "box_dropper_cover_off" }
}

$CBox 0 0 0 0 0 0

$BBox -23.416 -23.184 -3.996 23.037 23.269 2.718

$DefineBone "polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"box_dropper_cover_broken_cover_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "box_dropper_cover_broken_cover_physics.smd"
{
	$mass 40
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
		"base" "Metal.small"
	}
}
