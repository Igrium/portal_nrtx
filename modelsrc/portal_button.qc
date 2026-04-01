// Created by Crowbar 0.74

$ModelName "props/portal_button.mdl"

$BodyGroup "base"
{
	studio "base.smd"
}
$BodyGroup "shell"
{
	studio "shell.smd"
}
$BodyGroup "clamps1"
{
	studio "clamps1.smd"
}
$BodyGroup "clamps2"
{
	studio "clamps2.smd"
}
$BodyGroup "top"
{
	studio "pad.smd"
}

$DefineBone "portal_button_export" "" 0 0 0 0 0 0 0 0 0 0 0 0
$DefineBone "portal_button_root" "portal_button_export" 0 0 0 0 0 0 0 0 0 0 0 0
$DefineBone "portal_button_top" "portal_button_root" 0 14 0 0 0 0 0 0 0 0 0 0

$SurfaceProp "default"

$Contents "solid"

$IllumPosition 0 0 3.141

$CDMaterials "models\rtx\props\button_reference\"

$TextureGroup "skinfamilies"
{
	{ "button_base" }
	{ "button_base_orange" }
	{ "button_base_red" }
	{ "button_base_off" }
}

$CBox 0 0 0 0 0 0

$BBox -64 -64 -8 64 4 16

$Sequence "BindPose" {
	"portal_button_anims\BindPose.smd"
	fadein 0.2
	fadeout 0.2
	fps 25
}

$Sequence "up" {
	"portal_button_anims\up.smd"
	{ event AE_CL_PLAYSOUND 0 "portal1.button_up" }
	fadein 0.2
	fadeout 0.2
	fps 25
}

$Sequence "idledown" {
	"portal_button_anims\idledown.smd"
	fadein 0.2
	fadeout 0.2
	fps 25
}

$Sequence "down" {
	"portal_button_anims\down.smd"
	{ event AE_CL_PLAYSOUND 0 "portal1.button_down" }
	fadein 0.2
	fadeout 0.2
	fps 25
}

$CollisionJoints "portal_button_physics.smd"
{
	$mass 1967.366
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "


}
