// Created by Crowbar 0.74

$ModelName "props/portal_cleanser_1.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "portal_cleanser_1_reference.smd"
}

$LOD 20
{
	replacemodel "portal_cleanser_1_reference.smd" "portal_cleanser_1_reference_lod1.smd"
	NoFacial
}
$LOD 40
{
	replacemodel "portal_cleanser_1_reference.smd" "portal_cleanser_1_reference_lod2.smd"
	NoFacial
}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0.287 0 0.006

$CDMaterials "models\props\"

$CBox 0 0 0 0 0 0

$BBox -12.049 -10.25 -65.865 12.049 10.823 65.865

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
