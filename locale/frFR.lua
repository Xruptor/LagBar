local ADDON_NAME, private = ...

local L = private:NewLocale("frFR")
if not L then return end

L.SlashBG = "fond"
L.SlashBGOn = "LagBar : L'arriere-plan est maintenant [|cFF99CC33AFFICHE|r]"
L.SlashBGOff = "LagBar : L'arriere-plan est maintenant [|cFF99CC33MASQUE|r]"
L.SlashBGInfo = "Afficher l'arriere-plan de la fenetre."

L.SlashTT = "infobulle"
L.SlashTTOn = "LagBar : L'infobulle au survol est maintenant [|cFF99CC33AFFICHEE|r]"
L.SlashTTOff = "LagBar : L'infobulle au survol est maintenant [|cFF99CC33MASQUEE|r]"
L.SlashTTInfo = "Afficher l'infobulle au survol des donnees."

L.SlashReset = "reinit"
L.SlashResetInfo = "Reinitialiser la position du cadre."
L.SlashResetAlert = "LagBar : La position du cadre a ete reinitialisee !"

L.SlashScale = "echelle"
L.SlashScaleSet = "LagBar : l'echelle a ete definie sur [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Echelle invalide ! Le nombre doit etre entre [0.5 - 5].  (0.5, 1, 3, 4.6, etc.)"
L.SlashScaleInfo = "Definir l'echelle du cadre LagBar (0.5 - 5)."
L.SlashScaleText = "Echelle du cadre LagBar"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar : FPS est maintenant [|cFF99CC33ACTIVE|r]"
L.SlashFPSOff = "LagBar : FPS est maintenant [|cFF99CC33DESACTIVE|r]"
L.SlashFPSInfo = "Basculer l'affichage des FPS (|cFF99CC33ACT/DES|r)."
L.SlashFPSChkBtn = "Afficher les FPS."

L.SlashHomePing = "pingdom"
L.SlashHomePingOn = "LagBar : Ping domicile est maintenant [|cFF99CC33ACTIVE|r]"
L.SlashHomePingOff = "LagBar : Ping domicile est maintenant [|cFF99CC33DESACTIVE|r]"
L.SlashHomePingInfo = "Basculer l'affichage du ping domicile (|cFF99CC33ACT/DES|r)."
L.SlashHomePingChkBtn = "Afficher le ping domicile."

L.SlashWorldPing = "pingmonde"
L.SlashWorldPingOn = "LagBar : Ping monde est maintenant [|cFF99CC33ACTIVE|r]"
L.SlashWorldPingOff = "LagBar : Ping monde est maintenant [|cFF99CC33DESACTIVE|r]"
L.SlashWorldPingInfo = "Basculer l'affichage du ping monde (|cFF99CC33ACT/DES|r)."
L.SlashWorldPingChkBtn = "Afficher le ping monde."

L.SlashImpDisplay = "ameliore"
L.SlashImpDisplayOn = "LagBar : Affichage ping ameliore est maintenant [|cFF99CC33ACTIVE|r]"
L.SlashImpDisplayOff = "LagBar : Affichage ping ameliore est maintenant [|cFF99CC33DESACTIVE|r]"
L.SlashImpDisplayInfo = "Basculer l'affichage ping ameliore (|cFF99CC33ACT/DES|r)."
L.SlashImpDisplayChkBtn = "Afficher l'affichage ping ameliore."

L.SlashMetricLabels = "metrique"
L.SlashMetricLabelsOn = "LagBar : Les etiquettes metriques sont maintenant [|cFF99CC33ACTIVEES|r]"
L.SlashMetricLabelsOff = "LagBar : Les etiquettes metriques sont maintenant [|cFF99CC33DESACTIVEES|r]"
L.SlashMetricLabelsInfo = "Basculer l'affichage des etiquettes metriques (|cFF99CC33ACT/DES|r)."
L.SlashMetricLabelsChkBtn = "Afficher les etiquettes metriques."

L.SlashClampToScreenChkBtn = "Attacher le cadre LagBar a l'ecran. |cFF99CC33(Evite qu'il soit deplace hors ecran)|r"

L.AddonLoginMsg = "Afficher l'annonce de chargement de l'addon a la connexion."

L.TooltipDragInfo = "[Maintenez Shift et faites glisser pour deplacer la fenetre.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "D"
L.World = "M"
