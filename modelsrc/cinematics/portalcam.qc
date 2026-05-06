$ModelName "cinematics/portalCam"

$BodyGroup "Body"
{
	studio "portal_cinematics.smd"
}

$CDMaterials "models/"

$DefineBone "cam" "" 0 0 0 0 0 0 0 0 0 0 0 0
$bbox -1 -1 -1 1 1 1
$attachment cam_attach "cam" 0 0 0 rotate 90 90 0

$Sequence "idle" {
	"portal_cinematics.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}
$Sequence "testchmb_a_00" {
	"anims/00.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}
$Sequence "testchmb_a_01" {
	"anims/01.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}
$Sequence "testchmb_a_02" {
	"anims/02.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}
$Sequence "testchmb_a_03" {
	"anims/03.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}
$Sequence "testchmb_a_04" {
	"anims/04.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}
$Sequence "testchmb_a_05" {
	"anims/05.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}
$Sequence "testchmb_a_06" {
	"anims/06.smd"
	fadein 0.0
	fadeout 0.0
	fps 30
}

$Sequence "11" {
	"anims/11.smd"
	fps 24
}
$Sequence "15_turret" {
	"anims/15_turret.smd"
	fps 24
}