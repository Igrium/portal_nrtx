$modelname "props_c17/oildrum001.mdl"

$staticprop
$body "body" "oildrum001.dmx"
$surfaceprop "metal_barrel"
$contents "solid"

$cdmaterials "models/props_c17/"

$sequence "idle" "oildrum001.dmx"

$lod 9
{
    replacemodel "oildrum001.dmx" "oildrum001_lod1.dmx"
}

$collisionmodel "oildrum001_physics.dmx"
{
    $mass 30
    $inertia 1
    $damping 0
    $rotdamping 0
}

$keyvalues
{
	prop_data 
	{
		"base" "Metal.Medium"
	}
}