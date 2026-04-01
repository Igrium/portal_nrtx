// Created by Crowbar 0.74

$ModelName "props/round_elevator_doors.mdl"

$BodyGroup "Body"
{
	studio "rtx_elevator_doors.smd"
}


$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 31.899 31.898 52.023

$CDMaterials "models\rtx\props\round_elevator\"

$CBox 0 0 0 0 0 0

$BBox -109.477 -45.679 -0.446 45.68 109.476 161.956

$DefineBone "Scene_Root" "" 0 0 0 0 0 89.999975 0 0 0 0 0 0
$DefineBone "Root" "Scene_Root" 0 0 0 0 0 0 0 0 0 0 0 0
$DefineBone "Door_Left" "Root" 0 45.053329 0 38.999974 0 0 0 0 0 0 0 0
$DefineBone "Door_Right" "Root" 0 54.462692 0 -38.999974 0 0 0 0 0 0 0 0


$Sequence "idle_closed" {
	"round_elevator_doors_anims\idle_closed.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "open" {
	"round_elevator_doors_anims\open.smd"
	{ event AE_CL_PLAYSOUND 2 "novaprospekt.combinedoor_move_1" }
	{ event AE_CL_PLAYSOUND 15 "novaprospekt.combinedoor_close_1" }
	{ event AE_CL_PLAYSOUND 16 "novaprospekt.combinedoor_close_1" }
	{ event AE_CL_STOPSOUND 18 "novaprospekt.combinedoor_move_1" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "close" {
	"round_elevator_doors_anims\close.smd"
	{ event AE_CL_PLAYSOUND 2 "novaprospekt.combinedoor_move_1" }
	{ event AE_CL_PLAYSOUND 7 "novaprospekt.combinedoor_close_1" }
	{ event AE_CL_STOPSOUND 18 "novaprospekt.combinedoor_move_1" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "round_elevator_doors_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone "Root"
	$concave
}
