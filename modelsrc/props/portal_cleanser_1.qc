// Created by Crowbar 0.74

$ModelName "props/portal_cleanser_1.mdl"

$StaticProp

$MostlyOpaque

$BodyGroup "Body"
{
	studio "FizzleGate.smd"
}
$BodyGroup "Glass"
{
	studio "FizzleGate_Glass.smd"
}

//$LOD 40
//{
//	replacemodel "portal_cleanser_1_reference.smd" "portal_cleanser_1_reference_lod1.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0.287 0 0.006

$CDMaterials "models\props\portal_cleanser"

$texturegroup skinfamilies
{
	{ "portal_cleanser" }
	{ "portal_cleanser_red" }
}

$CBox 0 0 0 0 0 0

$BBox -11.923 -10.098 -64.818 11.923 10.578 64.83

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"portal_cleanser_1_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "portal_cleanser_1_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
