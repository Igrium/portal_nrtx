$modelname "props_pipes/pipeSet32d_bend256u_001a.mdl"

$staticprop

$body "body" "pipeSet32d_bend256u_001a.dmx"

$lod 19
{
    replacemodel "pipeSet32d_bend256u_001a.dmx" "pipeSet32d_bend256u_001a_lod1.dmx"
}

$surfaceprop metal
$contents solid

$cdmaterials "models/props_pipes"

$sequence "idle" "pipeSet32d_bend256u_001a.dmx"

$collisionmodel "pipeSet32d_bend256u_001a_physics.dmx"
{
    $mass 444
    $concave
}