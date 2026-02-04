local ADDON_NAME, private = ...

local L = private:NewLocale("itIT")
if not L then return end

L.SlashBG = "sfondo"
L.SlashBGOn = "LagBar: Lo sfondo ora e [|cFF99CC33VISIBILE|r]"
L.SlashBGOff = "LagBar: Lo sfondo ora e [|cFF99CC33NASCOSTO|r]"
L.SlashBGInfo = "Mostra lo sfondo della finestra."

L.SlashTT = "tooltip"
L.SlashTTOn = "LagBar: Il tooltip al passaggio e ora [|cFF99CC33VISIBILE|r]"
L.SlashTTOff = "LagBar: Il tooltip al passaggio e ora [|cFF99CC33NASCOSTO|r]"
L.SlashTTInfo = "Mostra il tooltip quando il mouse passa sui dati."

L.SlashReset = "reimposta"
L.SlashResetInfo = "Reimposta la posizione del frame."
L.SlashResetAlert = "LagBar: La posizione del frame e stata reimpostata!"

L.SlashScale = "scala"
L.SlashScaleSet = "LagBar: la scala e stata impostata su [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Scala non valida! Il numero deve essere tra [0.5 - 5].  (0.5, 1, 3, 4.6, ecc.)"
L.SlashScaleInfo = "Imposta la scala del frame LagBar (0.5 - 5)."
L.SlashScaleText = "Scala del frame LagBar"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar: FPS ora [|cFF99CC33ATTIVATO|r]"
L.SlashFPSOff = "LagBar: FPS ora [|cFF99CC33DISATTIVATO|r]"
L.SlashFPSInfo = "Attiva/disattiva la visualizzazione FPS (|cFF99CC33ON/OFF|r)."
L.SlashFPSChkBtn = "Mostra la visualizzazione FPS."

L.SlashHomePing = "pingcasa"
L.SlashHomePingOn = "LagBar: Ping casa ora [|cFF99CC33ATTIVATO|r]"
L.SlashHomePingOff = "LagBar: Ping casa ora [|cFF99CC33DISATTIVATO|r]"
L.SlashHomePingInfo = "Attiva/disattiva la visualizzazione del ping casa (|cFF99CC33ON/OFF|r)."
L.SlashHomePingChkBtn = "Mostra il ping casa."

L.SlashWorldPing = "pingmondo"
L.SlashWorldPingOn = "LagBar: Ping mondo ora [|cFF99CC33ATTIVATO|r]"
L.SlashWorldPingOff = "LagBar: Ping mondo ora [|cFF99CC33DISATTIVATO|r]"
L.SlashWorldPingInfo = "Attiva/disattiva la visualizzazione del ping mondo (|cFF99CC33ON/OFF|r)."
L.SlashWorldPingChkBtn = "Mostra il ping mondo."

L.SlashImpDisplay = "migliorato"
L.SlashImpDisplayOn = "LagBar: Visualizzazione ping migliorata ora [|cFF99CC33ATTIVATA|r]"
L.SlashImpDisplayOff = "LagBar: Visualizzazione ping migliorata ora [|cFF99CC33DISATTIVATA|r]"
L.SlashImpDisplayInfo = "Attiva/disattiva la visualizzazione ping migliorata (|cFF99CC33ON/OFF|r)."
L.SlashImpDisplayChkBtn = "Mostra la visualizzazione ping migliorata."

L.SlashMetricLabels = "metriche"
L.SlashMetricLabelsOn = "LagBar: Etichette metriche ora [|cFF99CC33ATTIVATE|r]"
L.SlashMetricLabelsOff = "LagBar: Etichette metriche ora [|cFF99CC33DISATTIVATE|r]"
L.SlashMetricLabelsInfo = "Attiva/disattiva la visualizzazione delle etichette metriche (|cFF99CC33ON/OFF|r)."
L.SlashMetricLabelsChkBtn = "Mostra le etichette metriche nella visualizzazione."

L.SlashClampToScreenChkBtn = "Blocca il frame LagBar allo schermo. |cFF99CC33(Impedisce che venga trascinato fuori dallo schermo)|r"

L.AddonLoginMsg = "Mostra l'annuncio di caricamento dell'addon al login."

L.TooltipDragInfo = "[Tieni premuto Shift e trascina per spostare la finestra.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "C"
L.World = "M"
