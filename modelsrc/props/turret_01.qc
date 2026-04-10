// Created by Crowbar 0.74

$ModelName "props\Turret_01.mdl"

$BodyGroup "studio"
{
	studio "Turret_01_reference.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition -0.008 -1.223 34.069

$EyePosition 0 0 64

$CDMaterials "models\props\"

$TextureGroup "skinfamilies"
{
	{ "Turret_01"          }
	{ "Turret_01_inactive" }
}

$Attachment "eyes" "Aim_UD" 0 -0.1 13 rotate -90 -90 0
$Attachment "light" "Base" 0 18 13 rotate -90 -90 0
$Attachment "LFT_Gun1_Muzzle" "LFT_Gun1" 0 0 1 rotate -90 -90 0
$Attachment "LFT_Gun2_Muzzle" "LFT_Gun2" 0 0 3 rotate -90 -90 0
$Attachment "RT_Gun1_Muzzle" "RT_Gun1" 0 0 1 rotate -90 -90 0
$Attachment "RT_Gun2_Muzzle" "RT_Gun2" 0 0 3 rotate -90 -90 0
$Attachment "Wire1_start" "Base" -3 20 2 rotate -90 -90 0
$Attachment "Wire2_start" "Base" -2.3 23 9 rotate -90 -90 0
$Attachment "Wire3_start" "Base" 2.5 24 1 rotate -90 -90 0
$Attachment "Wire4_start" "Base" 2.5 14 4 rotate -90 -90 0
$Attachment "Wire1_end" "LFT_Wing" 7 2 -3 rotate -90 -90 0
$Attachment "Wire2_end" "LFT_Wing" 7 -2 2.5 rotate -90 -90 0
$Attachment "Wire3_end" "RT_Wing" -7 2 -3 rotate -90 -90 0
$Attachment "Wire4_end" "RT_Wing" -7 0 3 rotate -90 -90 0

$CBox 0 0 0 0 0 0

$BBox -16 -16 0 16 16 64

$DefineBone "Base" "" 0 -0.000001 18.707941 0 0 89.999982 0 0 0 0 0 0
$DefineBone "Aim_LR" "Base" 0 18.046322 5.566185 0 0 0 0 0 0 0 0 0
$DefineBone "Aim_UD" "Aim_LR" 0 -0.000002 0 0 0 0 0 0 0 0 0 0
$DefineBone "LFT_Wing" "Aim_UD" -14.150279 -0.000002 0 0 0 0 0 0 0 0 0 0
$DefineBone "LFT_Gun1" "LFT_Wing" 5.452318 1.799003 7.001915 0 0 0 0 0 0 0 0 0
$DefineBone "LFT_Gun2" "LFT_Wing" 5.45221 -2.218407 7.001915 0 0 0 0 0 0 0 0 0
$DefineBone "RT_Wing" "Aim_UD" 14.133805 -0.000002 0 0 0 0 0 0 0 0 0 0
$DefineBone "RT_Gun1" "RT_Wing" -5.278988 1.800285 7.001915 0 0 0 0 0 0 0 0 0
$DefineBone "RT_Gun2" "RT_Wing" -5.278988 -2.218407 7.001915 0 0 0 0 0 0 0 0 0


$PoseParameter "aim_yaw" -60 60 loop 0
$PoseParameter "aim_pitch" -15 15 loop 0

$Animation "aim_right_corrective_animation" "turret_01_anims\aim_right_corrective_animation.smd" {
}

$Animation "aim_left_corrective_animation" "turret_01_anims\aim_left_corrective_animation.smd" {
}

$Animation "aim_up_corrective_animation" "turret_01_anims\aim_up_corrective_animation.smd" {
}

$Animation "aim_down_corrective_animation" "turret_01_anims\aim_down_corrective_animation.smd" {
}

$Animation "aim_neutral" "turret_01_anims\aim_neutral.smd" {
	fps 30
}

$Animation "aim_up" "turret_01_anims\aim_up.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_up_corrective_animation" 0
}

$Animation "aim_down" "turret_01_anims\aim_down.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_down_corrective_animation" 0
}

$Animation "aim_right" "turret_01_anims\aim_right.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_right_corrective_animation" 0
}

$Animation "aim_left" "turret_01_anims\aim_left.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_left_corrective_animation" 0
}

$Sequence "idle" {
	"turret_01_anims\idle.smd"
	activity "ACT_FLOOR_TURRET_CLOSED_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "deploy" {
	"turret_01_anims\deploy.smd"
	activity "ACT_FLOOR_TURRET_OPEN" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "idlealert" {
	"turret_01_anims\idlealert.smd"
	activity "ACT_FLOOR_TURRET_OPEN_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 10
	loop
}

$Sequence "fire" {
	"turret_01_anims\fire.smd"
	activity "ACT_FLOOR_TURRET_FIRE" 1
	{ event AE_NPC_MUZZLEFLASH 0 "COMBINE LFT_Gun1_muzzle" }
	{ event AE_NPC_MUZZLEFLASH 0 "COMBINE RT_Gun1_muzzle" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "fire2" {
	"turret_01_anims\fire2.smd"
	activity "ACT_FLOOR_TURRET_FIRE2" 1
	{ event AE_NPC_MUZZLEFLASH 0 "COMBINE LFT_Gun2_muzzle" }
	{ event AE_NPC_MUZZLEFLASH 0 "COMBINE RT_Gun2_muzzle" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "retract" {
	"turret_01_anims\retract.smd"
	activity "ACT_FLOOR_TURRET_CLOSE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "aim_updown" {
	"turret_01_anims\aim_updown.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "aim_leftright" {
	"turret_01_anims\aim_leftright.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "auto_leftright" {
	"aim_right"
	"aim_left"
	autoplay
	blend "aim_yaw" -60 60
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
}

$Sequence "auto_updown" {
	"aim_up"
	"aim_down"
	autoplay
	blend "aim_pitch" -15 15
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
}

$Sequence "carry_pose" {
	"turret_01_anims\carry_pose.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "turret_01_physics.smd"
{
	$mass 100
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 8

}
