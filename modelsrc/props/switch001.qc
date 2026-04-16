// Created by Crowbar 0.74

$ModelName "props/switch001.mdl"

$BodyGroup "Body"
{
	studio "switch001.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 0 23.543

$CDMaterials "models\props\switch\"

$TextureGroup "skinfamilies"
{
	{ "switch"              "switch_top"       }
	{ "switch_dirty"        "switch_dirty_top" }
	{ "switch_orange"       "switch_top"       }
	{ "switch_dirty_orange" "switch_dirty_top" }
}

$CBox 0 0 0 0 0 0

$BBox -12 -12 -0.255 12 12 47.086

$DefineBone "Root" "" 0 0 0 0 0 89.999975 0 0 0 0 0 0
$DefineBone "Button" "Root" 0 41.874077 0 0 0 31.101464 0 0 0 0 0 0


$Sequence "idle" {
	"switch001_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "down" {
	"switch001_anims\down.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "up" {
	"switch001_anims\up.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "idle_down" {
	"switch001_anims\idle_down.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "switch001_physics.smd"
{
    $mass 120
    $concave
}
