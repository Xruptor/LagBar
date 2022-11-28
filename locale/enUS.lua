local ADDON_NAME, addon = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true)
if not L then return end

L.SlashBG = "bg"
L.SlashBGOn = "LagBar: Background is now [|cFF99CC33SHOWN|r]"
L.SlashBGOff = "LagBar: Background is now [|cFF99CC33HIDDEN|r]"
L.SlashBGInfo = "Show the window background."

L.SlashTT = "tt"
L.SlashTTOn = "LagBar: Hover Tooltip is now [|cFF99CC33SHOWN|r]"
L.SlashTTOff = "LagBar: Hover Tooltip is now [|cFF99CC33HIDDEN|r]"
L.SlashTTInfo = "Show the Tooltip when hovering over data."

L.SlashReset = "reset"
L.SlashResetInfo = "Reset frame position."
L.SlashResetAlert = "LagBar: Frame position has been reset!"

L.SlashScale = "scale"
L.SlashScaleSet = "LagBar: scale has been set to [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "LagBar: scale invalid or number cannot be greater than 2"
L.SlashScaleInfo = "Set the scale of the LagBar frame (0-200)"
L.SlashScaleText = "LagBar Frame Scale"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar: FPS is now [|cFF99CC33ON|r]"
L.SlashFPSOff = "LagBar: FPS is now [|cFF99CC33OFF|r]"
L.SlashFPSInfo = "Toggles fps display (|cFF99CC33ON/OFF|r)."
L.SlashFPSChkBtn = "Show the fps display."

L.SlashHomePing = "homeping"
L.SlashHomePingOn = "LagBar: HomePing is now [|cFF99CC33ON|r]"
L.SlashHomePingOff = "LagBar: HomePing is now [|cFF99CC33OFF|r]"
L.SlashHomePingInfo = "Toggles home ping display (|cFF99CC33ON/OFF|r)."
L.SlashHomePingChkBtn = "Show the home ping display."

L.SlashWorldPing = "worldping"
L.SlashWorldPingOn = "LagBar: WorldPing is now [|cFF99CC33ON|r]"
L.SlashWorldPingOff = "LagBar: WorldPing is now [|cFF99CC33OFF|r]"
L.SlashWorldPingInfo = "Toggles world ping display (|cFF99CC33ON/OFF|r)."
L.SlashWorldPingChkBtn = "Show the world ping display."

L.SlashImpDisplay = "impdisplay"
L.SlashImpDisplayOn = "LagBar: Improved Ping Display is now [|cFF99CC33ON|r]"
L.SlashImpDisplayOff = "LagBar: Improved Ping Display is now [|cFF99CC33OFF|r]"
L.SlashImpDisplayInfo = "Toggles improved ping display (|cFF99CC33ON/OFF|r)."
L.SlashImpDisplayChkBtn = "Show the improved ping display."

L.SlashMetricLabels = "metric"
L.SlashMetricLabelsOn = "LagBar: Metric labels are now [|cFF99CC33ON|r]"
L.SlashMetricLabelsOff = "LagBar: Metric labels are now [|cFF99CC33OFF|r]"
L.SlashMetricLabelsInfo = "Toggles the display of metric labels (|cFF99CC33ON/OFF|r)."
L.SlashMetricLabelsChkBtn = "Show metric labels in display."

L.TooltipDragInfo = "[Hold Shift and Drag to move window.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "H"
L.World = "W"