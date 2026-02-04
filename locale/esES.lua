local ADDON_NAME, private = ...

local L = private:NewLocale("esES")
if not L then return end

L.SlashBG = "fondo"
L.SlashBGOn = "LagBar: El fondo ahora está [|cFF99CC33MOSTRADO|r]"
L.SlashBGOff = "LagBar: El fondo ahora está [|cFF99CC33OCULTO|r]"
L.SlashBGInfo = "Mostrar el fondo de la ventana."

L.SlashTT = "tooltip"
L.SlashTTOn = "LagBar: El tooltip al pasar el ratón ahora está [|cFF99CC33MOSTRADO|r]"
L.SlashTTOff = "LagBar: El tooltip al pasar el ratón ahora está [|cFF99CC33OCULTO|r]"
L.SlashTTInfo = "Mostrar el tooltip al pasar el ratón sobre los datos."

L.SlashReset = "reiniciar"
L.SlashResetInfo = "Restablecer la posición del marco."
L.SlashResetAlert = "LagBar: ¡La posición del marco se ha restablecido!"

L.SlashScale = "escala"
L.SlashScaleSet = "LagBar: la escala se ha establecido en [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "¡Escala inválida! El número debe estar entre [0.5 - 5].  (0.5, 1, 3, 4.6, etc.)"
L.SlashScaleInfo = "Establecer la escala del marco de LagBar (0.5 - 5)."
L.SlashScaleText = "Escala del marco de LagBar"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar: FPS ahora [|cFF99CC33ACTIVADO|r]"
L.SlashFPSOff = "LagBar: FPS ahora [|cFF99CC33DESACTIVADO|r]"
L.SlashFPSInfo = "Alterna la visualización de FPS (|cFF99CC33ACT/DES|r)."
L.SlashFPSChkBtn = "Mostrar la visualización de FPS."

L.SlashHomePing = "pinglocal"
L.SlashHomePingOn = "LagBar: Ping local ahora [|cFF99CC33ACTIVADO|r]"
L.SlashHomePingOff = "LagBar: Ping local ahora [|cFF99CC33DESACTIVADO|r]"
L.SlashHomePingInfo = "Alterna la visualización del ping local (|cFF99CC33ACT/DES|r)."
L.SlashHomePingChkBtn = "Mostrar el ping local."

L.SlashWorldPing = "pingmundo"
L.SlashWorldPingOn = "LagBar: Ping mundial ahora [|cFF99CC33ACTIVADO|r]"
L.SlashWorldPingOff = "LagBar: Ping mundial ahora [|cFF99CC33DESACTIVADO|r]"
L.SlashWorldPingInfo = "Alterna la visualización del ping mundial (|cFF99CC33ACT/DES|r)."
L.SlashWorldPingChkBtn = "Mostrar el ping mundial."

L.SlashImpDisplay = "mejorado"
L.SlashImpDisplayOn = "LagBar: Pantalla de ping mejorada ahora [|cFF99CC33ACTIVADA|r]"
L.SlashImpDisplayOff = "LagBar: Pantalla de ping mejorada ahora [|cFF99CC33DESACTIVADA|r]"
L.SlashImpDisplayInfo = "Alterna la pantalla de ping mejorada (|cFF99CC33ACT/DES|r)."
L.SlashImpDisplayChkBtn = "Mostrar la pantalla de ping mejorada."

L.SlashMetricLabels = "metricas"
L.SlashMetricLabelsOn = "LagBar: Etiquetas métricas ahora [|cFF99CC33ACTIVADAS|r]"
L.SlashMetricLabelsOff = "LagBar: Etiquetas métricas ahora [|cFF99CC33DESACTIVADAS|r]"
L.SlashMetricLabelsInfo = "Alterna la visualización de etiquetas métricas (|cFF99CC33ACT/DES|r)."
L.SlashMetricLabelsChkBtn = "Mostrar etiquetas métricas en la pantalla."

L.SlashClampToScreenChkBtn = "Fijar el marco de LagBar a la pantalla. |cFF99CC33(Evita que se arrastre fuera de la pantalla)|r"

L.AddonLoginMsg = "Mostrar anuncio de carga del addon al iniciar sesión."

L.TooltipDragInfo = "[Mantén Shift y arrastra para mover la ventana.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "C"
L.World = "M"
