local ADDON_NAME, addon = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true)
if not L then return end

L.SlashBG = "bg"
L.SlashBGOn = "LagBar: Background is now [|cFF99CC33SHOWN|r]"
L.SlashBGOff = "LagBar: Background is now [|cFF99CC33HIDDEN|r]"
L.SlashBGInfo = "Show the window background."

L.SlashReset = "reset"
L.SlashResetInfo = "Reset frame position."
L.SlashResetAlert = "LagBar: Frame position has been reset!"

L.SlashScale = "scale"
L.SlashScaleSet = "LagBar: scale has been set to [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "LagBar: scale invalid or number cannot be greater than 2"
L.SlashScaleInfo = "Set the scale of the LagBar frame (0-200)"
L.SlashScaleText = "LagBar Frame Scale"

L.SlashWorldPing = "worldping"
L.SlashWorldPingOn = "LagBar: WorldPing is now [|cFF99CC33ON|r]"
L.SlashWorldPingOff = "LagBar: WorldPing is now [|cFF99CC33OFF|r]"
L.SlashWorldPingInfo = "Toggles world ping display (|cFF99CC33ON/OFF|r)."
L.SlashWorldPingChkBtn = "Show the world ping display."

L.SlashImpDisplay = "impdisplay"
L.SlashImpDisplayOn = "LagBar: Improved WorldPing is now [|cFF99CC33ON|r]"
L.SlashImpDisplayOff = "LagBar: Improved WorldPing is now [|cFF99CC33OFF|r]"
L.SlashImpDisplayInfo = "Toggles improved world ping display (|cFF99CC33ON/OFF|r)."
L.SlashImpDisplayChkBtn = "Show the improved world ping display."

L.TooltipDragInfo = "[Hold Shift and Drag to move window.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "H"
L.World = "W"