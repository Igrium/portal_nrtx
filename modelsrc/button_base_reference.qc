// Created by Crowbar 0.74

$ModelName "props/button_base_reference.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "base.smd"
}
$BodyGroup "clamped1"
{
	studio "shell.smd"
}
$BodyGroup "clamped2"
{
	studio "clamps1.smd"
}
$BodyGroup "clamped3"
{
	studio "clamps2.smd"
}
$SurfaceProp "metal"

$Contents "solid"

$IllumPosition -0.006 0.032 4.528

$CDMaterials "models\props\button_reference\"

$TextureGroup "skinfamilies"
{
	{ "button_base"        }
	{ "button_base_orange" }
	{ "button_base_red"    }
	{ "button_base_off"    }
}

$CBox 0 0 0 0 0 0

$BBox -60.727 -60.773 -0.258 61.314 60.993 10.056

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"button_base_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "button_base_reference_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone "static_prop"
	$concave	
}
