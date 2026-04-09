// Created by Crowbar 0.74

$ModelName "rtx/props/round_elevator_body.mdl"

$BodyGroup "ext"
{
	studio "exterior.smd"
}
$BodyGroup "frm"
{
	studio "frame.smd"
}
$BodyGroup "int"
{
	studio "interior.smd"
}
$BodyGroup "int2"
{
	studio "interior2.smd"
}
$BodyGroup "scr"
{
	studio "screws.smd"
}
$BodyGroup "hrl"
{
	studio "handrail.smd"
}
$BodyGroup "wnd"
{
	studio "windows.smd"
}


$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0.078 0.078 69.542

$MostlyOpaque

$CDMaterials "models\rtx\props\round_elevator\"
$texturegroup skinfamilies
{
	{ "round_elevator_sheet00"     "round_elevator_sheet01"     "round_elevator_sheet02"     "round_elevator_sheet03"     "round_elevator_sheet04"     "round_elevator_glow" }
	{ "round_elevator_sheet00_off" "round_elevator_sheet01_off" "round_elevator_sheet02_off" "round_elevator_sheet03_off" "round_elevator_sheet04_off" "round_elevator_glow_off" }
}

$Attachment "statPanel0_bl" "Screen_BL" 0 8 0 rotate -45 0 0
$Attachment "statPanel0_tr" "Screen_TR" 0 -8 0 rotate -45 0 0

$CBox 0 0 0 0 0 0

$BBox -98.586 -100.309 -1.722 103.408 99.686 142.949

$DefineBone "Scene_Root" "" 0 0 0 0 0 89.999975 0 0 0 0 0 0
$DefineBone "Root" "Scene_Root" 0 0 0 0 0 0 0 0 0 0 0 0
$DefineBone "Screen_TR" "Root" 75.126396 94.613602 -7.221797 0 0 0 0 0 0 0 0 0
$DefineBone "Screen_BL" "Root" 7.668623 30.828308 -74.930145 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"round_elevator_body_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "round_elevator_body_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	//$maxconvexpieces 1

}
