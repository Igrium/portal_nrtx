// Created by Crowbar 0.74

$ModelName "props_bts_rtx/Glados_Aperturedoor.mdl"

$BodyGroup "Body"
{
	studio "Collection.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 1.784 0 -57.418

$CDMaterials "models\props_bts_rtx\"

$CBox 0 0 0 0 0 0

$BBox -101.886 -92.193 -161.579 101.886 95.761 46.743

$DefineBone "Aperture_Door" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0
$DefineBone "Scene_Root" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0
$DefineBone "Root" "Scene_Root" 1.196254 0.624548 0 0 24.999981 0 0 0 0 0 0 0
$DefineBone "cube1" "Root" 18.066898 -2.068864 55.60556 12.000005 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube2" "Root" 47.301071 -2.068865 34.343189 -23.320679 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube3" "Root" 47.34885 -2.068863 -34.414268 -6.407477 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube5" "Root" -18.072645 -2.068864 -55.646927 12.000005 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube6" "Root" -47.325806 -2.068864 -34.397007 -24.76887 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube7" "Root" -58.483028 -2.068864 -0.005009 29.576498 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube8" "Root" -47.304958 -2.068865 34.323246 -6.064738 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube9" "Root" -18.054792 -2.068864 55.621166 47.238726 -180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube10" "Root" 58.501446 -2.068866 -0.014459 29.228312 180.000005 180.000005 0 0 0 0 0 0
$DefineBone "cube4" "Root" 18.039114 -2.068864 -55.672504 -41.71285 -180.000005 180.000005 0 0 0 0 0 0


$Sequence "idle" {
	"glados_aperturedoor_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "open" {
	"glados_aperturedoor_anims\open.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "close" {
	"glados_aperturedoor_anims\close.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}
