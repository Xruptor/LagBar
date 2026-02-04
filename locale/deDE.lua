local ADDON_NAME, private = ...

local L = private:NewLocale("deDE")
if not L then return end

L.SlashBG = "hintergrund"
L.SlashBGOn = "LagBar: Hintergrund ist jetzt [|cFF99CC33EINGEBLENDET|r]"
L.SlashBGOff = "LagBar: Hintergrund ist jetzt [|cFF99CC33AUSGEBLENDET|r]"
L.SlashBGInfo = "Fensterhintergrund anzeigen."

L.SlashTT = "tooltip"
L.SlashTTOn = "LagBar: Tooltip beim Überfahren ist jetzt [|cFF99CC33EINGEBLENDET|r]"
L.SlashTTOff = "LagBar: Tooltip beim Überfahren ist jetzt [|cFF99CC33AUSGEBLENDET|r]"
L.SlashTTInfo = "Tooltip beim Überfahren der Daten anzeigen."

L.SlashReset = "reset"
L.SlashResetInfo = "Rahmenposition zurücksetzen."
L.SlashResetAlert = "LagBar: Rahmenposition wurde zurückgesetzt!"

L.SlashScale = "skalierung"
L.SlashScaleSet = "LagBar: Skalierung wurde auf [|cFF20ff20%s|r] gesetzt"
L.SlashScaleSetInvalid = "Skalierung ungültig! Zahl muss zwischen [0.5 - 5] liegen.  (0.5, 1, 3, 4.6, usw.)"
L.SlashScaleInfo = "Skalierung des LagBar-Rahmens einstellen (0.5 - 5)."
L.SlashScaleText = "LagBar Rahmen-Skalierung"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar: FPS ist jetzt [|cFF99CC33AN|r]"
L.SlashFPSOff = "LagBar: FPS ist jetzt [|cFF99CC33AUS|r]"
L.SlashFPSInfo = "FPS-Anzeige umschalten (|cFF99CC33AN/AUS|r)."
L.SlashFPSChkBtn = "FPS-Anzeige anzeigen."

L.SlashHomePing = "heimping"
L.SlashHomePingOn = "LagBar: Heimat-Ping ist jetzt [|cFF99CC33AN|r]"
L.SlashHomePingOff = "LagBar: Heimat-Ping ist jetzt [|cFF99CC33AUS|r]"
L.SlashHomePingInfo = "Heimat-Ping anzeigen umschalten (|cFF99CC33AN/AUS|r)."
L.SlashHomePingChkBtn = "Heimat-Ping anzeigen."

L.SlashWorldPing = "weltping"
L.SlashWorldPingOn = "LagBar: Welt-Ping ist jetzt [|cFF99CC33AN|r]"
L.SlashWorldPingOff = "LagBar: Welt-Ping ist jetzt [|cFF99CC33AUS|r]"
L.SlashWorldPingInfo = "Welt-Ping anzeigen umschalten (|cFF99CC33AN/AUS|r)."
L.SlashWorldPingChkBtn = "Welt-Ping anzeigen."

L.SlashImpDisplay = "verbessert"
L.SlashImpDisplayOn = "LagBar: Verbesserte Ping-Anzeige ist jetzt [|cFF99CC33AN|r]"
L.SlashImpDisplayOff = "LagBar: Verbesserte Ping-Anzeige ist jetzt [|cFF99CC33AUS|r]"
L.SlashImpDisplayInfo = "Verbesserte Ping-Anzeige umschalten (|cFF99CC33AN/AUS|r)."
L.SlashImpDisplayChkBtn = "Verbesserte Ping-Anzeige anzeigen."

L.SlashMetricLabels = "metrisch"
L.SlashMetricLabelsOn = "LagBar: Metrische Beschriftungen sind jetzt [|cFF99CC33AN|r]"
L.SlashMetricLabelsOff = "LagBar: Metrische Beschriftungen sind jetzt [|cFF99CC33AUS|r]"
L.SlashMetricLabelsInfo = "Anzeige metrischer Beschriftungen umschalten (|cFF99CC33AN/AUS|r)."
L.SlashMetricLabelsChkBtn = "Metrische Beschriftungen anzeigen."

L.SlashClampToScreenChkBtn = "LagBar-Rahmen am Bildschirm festklemmen. |cFF99CC33(Verhindert, dass er vom Bildschirm gezogen wird)|r"

L.AddonLoginMsg = "Addon-Ladehinweis beim Login anzeigen."

L.TooltipDragInfo = "[Shift halten und ziehen, um das Fenster zu verschieben.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "H"
L.World = "W"
