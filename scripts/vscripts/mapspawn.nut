// Script created by Rip Rip Rip (https://youtube.com/@Rip-Rip-Rip) for the P2CE Door Replacement addon (https://steamcommunity.com/sharedfiles/filedetails/?id=3523648265)
// adapted by TwoKrazy (https://www.youtube.com/@TwoKrazy2002) for this RTX Button
const BUTTON_MDL = "models/props/switch001.mdl"
const BUTTON_SKIN_CLEAN_OFF = "0"
const BUTTON_SKIN_CLEAN_ON = "2"
const BUTTON_SKIN_DESTROYED_OFF = "1"
const BUTTON_SKIN_DESTROYED_ON = "3"


const FLOOR_BUTTON_MDL = "models/props/portal_button.mdl"
const FLOOR_BUTTON_TRIGGER_WIDTH = 48
const FLOOR_BUTTON_TRIGGER_HEIGHT = 15

const BALL_LAUNCHER_MDL = "models/props/combine_ball_launcher"
const BALL_CATCHER_MDL = "models/props/combine_ball_catcher"

function ScriptInit() {
    local canStartTimer = CreateEntityByName("logic_timer", {   // check every tick if entities have actually spawned in yet
        targetname = "newbutton_canstarttimer"
        RefireTime = 0.01
    })
    canStartTimer.ConnectOutput("OnTimer", "ScriptInit_CheckForStart")
    EntFire("newbutton_canstarttimer", "Enable")
}
function ScriptInit_CheckForStart() {   // if player exists, doors (probably) also exist, therefore swap doors
    if(GetPlayer() != null) {
        EntFire("newbutton_canstarttimer", "Kill")
        InitButtonSkins();
        InitFloorButtons();
        //InitBalls();
        //InitPortalCams();
    }
}
function InitButtonSkins() {
    for(local button = null; button = Entities.FindByModel(button, BUTTON_MDL);) {
        if(button.GetKeyValueInt("skin") == 1) {
            button.__KeyValueFromString("OnPressed", "!self,Skin," + BUTTON_SKIN_DESTROYED_ON)
            button.__KeyValueFromString("OnButtonReset", "!self,Skin," + BUTTON_SKIN_DESTROYED_OFF)
        } else {
            button.__KeyValueFromString("OnPressed", "!self,Skin," + BUTTON_SKIN_CLEAN_ON)
            button.__KeyValueFromString("OnButtonReset", "!self,Skin," + BUTTON_SKIN_CLEAN_OFF)
        }
    }
}
function InitFloorButtons() {
    for(local fbutton = null; fbutton = Entities.FindByModel(fbutton, FLOOR_BUTTON_MDL);) {

        local trig = Entities.FindByClassnameWithin(null, "trigger_portal_button", fbutton.GetOrigin(), 16);
        if (trig == null)
        {
           printl("ERROR! Failed to find trigger!");
            return
        }
        local halfWidth = FLOOR_BUTTON_TRIGGER_WIDTH / 2
     trig.SetSize(
        //original: (-20, -20, 0), (20, 20, 14)
        Vector(-halfWidth, -halfWidth, 0),
        Vector(halfWidth,  halfWidth, FLOOR_BUTTON_TRIGGER_HEIGHT)
    );
        
    printl("Successfully resized prop_floor_button")
    }
}
/*function InitBalls() {
    for(local launcher = null; launcher = Entities.FindByModel(launcher, FLOOR_BUTTON_MDL);) {

        local ball = Entities.FindByClassnameWithin(null, "point_energy_ball_launcher", launcher.GetOrigin(), 96);
        if (ball == null)
        {
           printl("ERROR! Failed to find ball launcher!");
            return
        }
        ball.__KeyValueFromString("OnPostSpawnBall",launcher.getName(),Skin,1)
        ball.__KeyValueFromString("OnPostSpawnBall",launcher.getName(),Skin,0,1.00)
        
    printl("Successfully added ball launcher skins")
    }
}*/
ScriptInit()
return