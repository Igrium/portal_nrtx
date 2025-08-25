$modelname "props/security_camera.mdl"

$body "body" "security_camera.dmx"
// $body "body" "security_camera_reference.smd"

$lod 6
{
    replacemodel "security_camera.dmx" "security_camera_lod1.dmx"
}

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/"

$attachment "light" "UD_Rot1" -14.25 5 16.3 rotate 0 -180 90
$attachment "Wire1_A" "Root1" 1.5 -6.2 1.5 rotate 0 0 135
$attachment "Wire2_A" "Root1" -2 -6.2 1.5 rotate 0 0 135
$attachment "Wire1_B" "UD_Rot1" -4.6 -0.5 -9.5 rotate 0 0 -90
$attachment "Wire2_B" "UD_Rot1" -4.6 0.5 -9.5 rotate 0 0 -90

$poseparameter "aim_yaw" -180 180 loop 0
$poseparameter "aim_pitch" -170 170 loop 0


// TODO: Rewrite this to not be a decompiled shitshow
$animation "aim_LR1_corrective_animation" "security_camera_anims\aim_LR1_corrective_animation.smd" {
}

$animation "aim_LR2_corrective_animation" "security_camera_anims\aim_LR2_corrective_animation.smd" {
}

$animation "aim_LR3_corrective_animation" "security_camera_anims\aim_LR3_corrective_animation.smd" {
}

$animation "aim_LR4_corrective_animation" "security_camera_anims\aim_LR4_corrective_animation.smd" {
}

$animation "aim_LR5_corrective_animation" "security_camera_anims\aim_LR5_corrective_animation.smd" {
}

$animation "aim_UD1_corrective_animation" "security_camera_anims\aim_UD1_corrective_animation.smd" {
}

$animation "aim_UD2_corrective_animation" "security_camera_anims\aim_UD2_corrective_animation.smd" {
}

$animation "aim_UD3_corrective_animation" "security_camera_anims\aim_UD3_corrective_animation.smd" {
}

$animation "aim_UD4_corrective_animation" "security_camera_anims\aim_UD4_corrective_animation.smd" {
}

$animation "aim_UD5_corrective_animation" "security_camera_anims\aim_UD5_corrective_animation.smd" {
}

$animation "aim_UD6_corrective_animation" "security_camera_anims\aim_UD6_corrective_animation.smd" {
}

$animation "aim_UD7_corrective_animation" "security_camera_anims\aim_UD7_corrective_animation.smd" {
}

$animation "aim_neutral" "security_camera_anims\aim_neutral.smd" {
    fps 30
}

$animation "aim_UD1" "security_camera_anims\aim_UD1.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_UD1_corrective_animation" 0
}

$animation "aim_UD2" "security_camera_anims\aim_UD2.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_UD2_corrective_animation" 0
}

$animation "aim_UD3" "security_camera_anims\aim_UD3.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_UD3_corrective_animation" 0
}

$animation "aim_UD4" "security_camera_anims\aim_UD4.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_UD4_corrective_animation" 0
}

$animation "aim_UD5" "security_camera_anims\aim_UD5.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_UD5_corrective_animation" 0
}

$animation "aim_UD6" "security_camera_anims\aim_UD6.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_UD6_corrective_animation" 0
}

$animation "aim_UD7" "security_camera_anims\aim_UD7.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_UD7_corrective_animation" 0
}

$animation "aim_LR1" "security_camera_anims\aim_LR1.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_LR1_corrective_animation" 0
}

$animation "aim_LR2" "security_camera_anims\aim_LR2.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_LR2_corrective_animation" 0
}

$animation "aim_LR3" "security_camera_anims\aim_LR3.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_LR3_corrective_animation" 0
}

$animation "aim_LR4" "security_camera_anims\aim_LR4.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_LR4_corrective_animation" 0
}

$animation "aim_LR5" "security_camera_anims\aim_LR5.smd" {
    fps 30
    // Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
    subtract "aim_LR5_corrective_animation" 0
}

$sequence "idle" {
    "security_camera_anims\idle.smd"
    activity "ACT_SECURITY_CAMERA_IDLE" 1
    fadein 0.2
    fadeout 0.2
    fps 30
    loop
}

$sequence "aim_updown" {
    "security_camera_anims\aim_updown.smd"
    fadein 0.2
    fadeout 0.2
    fps 30
}

$sequence "aim_leftright" {
    "security_camera_anims\aim_leftright.smd"
    fadein 0.2
    fadeout 0.2
    fps 30
}

$sequence "auto_leftright" {
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

$sequence "auto_updown" {
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

$collisionmodel "security_camera_physics.dmx"
{
    $mass 20
    $concave
}

$keyvalues
{
    prop_data 
    {
        "base" "Metal.small"
    }
}
