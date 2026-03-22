// Created by Crowbar 0.74

$ModelName "props/security_camera.mdl"

$BodyGroup "studio"
{
	studio "cam_rtx.smd"
}

$MostlyOpaque

//$LOD 40
//{
//	replacemodel "Security_Camera_reference.smd" "Security_Camera_reference_lod1.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0.741 -18.795 -3.385

$CDMaterials "models/props/security_camera/"

$Attachment "light" "UD_Rot1" -14.25 -5 16.3 rotate 0 -180 90
//$Attachment "light" "UD_Rot1" -4.25 5 15.5 rotate 0 -180 90

$Attachment "Wire1_A" "Root1" 1.5 -6.2 1.5 rotate 0 0 135
$Attachment "Wire2_A" "Root1" -2 -6.2 1.5 rotate 0 0 135
$Attachment "Wire1_B" "UD_Rot1" -4.6 -0.5 -9.5 rotate 0 0 -90
$Attachment "Wire2_B" "UD_Rot1" -4.6 0.5 -9.5 rotate 0 0 -90

$CBox 0 0 0 0 0 0

$BBox -2.112 -8.429 -22.792 40.076 10.275 15.703

$DefineBone "Scene_Root" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0
$DefineBone "Root1" "Scene_Root" 0 3.923015 1.984754 0 0 0 0 0 0 0 0 0
$DefineBone "LR_Rot1" "Root1" 0 7.601521 20.196884 0 0 0 0 0 0 0 0 0
$DefineBone "UD_Rot1" "LR_Rot1" 9.00969 -25.800583 -0.000001 0 0 0 0 0 0 0 0 0


$PoseParameter "aim_yaw" -180 180 loop 0
$PoseParameter "aim_pitch" -170 170 loop 0

$Animation "aim_LR1_corrective_animation" "security_camera_anims\aim_LR1_corrective_animation.smd" {
}

$Animation "aim_LR2_corrective_animation" "security_camera_anims\aim_LR2_corrective_animation.smd" {
}

$Animation "aim_LR3_corrective_animation" "security_camera_anims\aim_LR3_corrective_animation.smd" {
}

$Animation "aim_LR4_corrective_animation" "security_camera_anims\aim_LR4_corrective_animation.smd" {
}

$Animation "aim_LR5_corrective_animation" "security_camera_anims\aim_LR5_corrective_animation.smd" {
}

$Animation "aim_UD1_corrective_animation" "security_camera_anims\aim_UD1_corrective_animation.smd" {
}

$Animation "aim_UD2_corrective_animation" "security_camera_anims\aim_UD2_corrective_animation.smd" {
}

$Animation "aim_UD3_corrective_animation" "security_camera_anims\aim_UD3_corrective_animation.smd" {
}

$Animation "aim_UD4_corrective_animation" "security_camera_anims\aim_UD4_corrective_animation.smd" {
}

$Animation "aim_UD5_corrective_animation" "security_camera_anims\aim_UD5_corrective_animation.smd" {
}

$Animation "aim_UD6_corrective_animation" "security_camera_anims\aim_UD6_corrective_animation.smd" {
}

$Animation "aim_UD7_corrective_animation" "security_camera_anims\aim_UD7_corrective_animation.smd" {
}

$Animation "aim_neutral" "security_camera_anims\aim_neutral.smd" {
	fps 30
}

$Animation "aim_UD1" "security_camera_anims\aim_UD1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_UD1_corrective_animation" 0
}

$Animation "aim_UD2" "security_camera_anims\aim_UD2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_UD2_corrective_animation" 0
}

$Animation "aim_UD3" "security_camera_anims\aim_UD3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_UD3_corrective_animation" 0
}

$Animation "aim_UD4" "security_camera_anims\aim_UD4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_UD4_corrective_animation" 0
}

$Animation "aim_UD5" "security_camera_anims\aim_UD5.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_UD5_corrective_animation" 0
}

$Animation "aim_UD6" "security_camera_anims\aim_UD6.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_UD6_corrective_animation" 0
}

$Animation "aim_UD7" "security_camera_anims\aim_UD7.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_UD7_corrective_animation" 0
}

$Animation "aim_LR1" "security_camera_anims\aim_LR1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_LR1_corrective_animation" 0
}

$Animation "aim_LR2" "security_camera_anims\aim_LR2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_LR2_corrective_animation" 0
}

$Animation "aim_LR3" "security_camera_anims\aim_LR3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_LR3_corrective_animation" 0
}

$Animation "aim_LR4" "security_camera_anims\aim_LR4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_LR4_corrective_animation" 0
}

$Animation "aim_LR5" "security_camera_anims\aim_LR5.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "aim_LR5_corrective_animation" 0
}

$Sequence "idle" {
	"security_camera_anims\idle.smd"
	activity "ACT_SECURITY_CAMERA_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "aim_updown" {
	"security_camera_anims\aim_updown.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "aim_leftright" {
	"security_camera_anims\aim_leftright.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "auto_leftright" {
	"aim_LR1"
	"aim_LR2"
	"aim_LR3"
	"aim_LR4"
	"aim_LR5"
	autoplay
	blend "aim_yaw" -180 180
	blendwidth 5
	delta
	fadein 0.2
	fadeout 0.2
}

$Sequence "auto_updown" {
	"aim_UD1"
	"aim_UD2"
	"aim_UD3"
	"aim_UD4"
	"aim_UD5"
	"aim_UD6"
	"aim_UD7"
	autoplay
	blend "aim_pitch" -170 170
	blendwidth 7
	delta
	fadein 0.2
	fadeout 0.2
}

$CollisionModel "security_camera_physics.smd"
{
	$mass 20
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 10

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.small"
	}
}
