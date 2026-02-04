local ADDON_NAME, private = ...

local L = private:NewLocale("ptBR")
if not L then return end

L.SlashBG = "fundo"
L.SlashBGOn = "LagBar: O fundo agora esta [|cFF99CC33MOSTRADO|r]"
L.SlashBGOff = "LagBar: O fundo agora esta [|cFF99CC33OCULTO|r]"
L.SlashBGInfo = "Mostrar o fundo da janela."

L.SlashTT = "tooltip"
L.SlashTTOn = "LagBar: O tooltip ao passar o mouse agora esta [|cFF99CC33MOSTRADO|r]"
L.SlashTTOff = "LagBar: O tooltip ao passar o mouse agora esta [|cFF99CC33OCULTO|r]"
L.SlashTTInfo = "Mostrar o tooltip ao passar o mouse sobre os dados."

L.SlashReset = "redefinir"
L.SlashResetInfo = "Redefinir a posicao do quadro."
L.SlashResetAlert = "LagBar: A posicao do quadro foi redefinida!"

L.SlashScale = "escala"
L.SlashScaleSet = "LagBar: a escala foi definida para [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Escala invalida! O numero deve ser entre [0.5 - 5].  (0.5, 1, 3, 4.6, etc.)"
L.SlashScaleInfo = "Definir a escala do quadro LagBar (0.5 - 5)."
L.SlashScaleText = "Escala do quadro LagBar"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar: FPS agora [|cFF99CC33ATIVADO|r]"
L.SlashFPSOff = "LagBar: FPS agora [|cFF99CC33DESATIVADO|r]"
L.SlashFPSInfo = "Alterna a exibicao de FPS (|cFF99CC33ATIV/DESAT|r)."
L.SlashFPSChkBtn = "Mostrar a exibicao de FPS."

L.SlashHomePing = "pingcasa"
L.SlashHomePingOn = "LagBar: Ping da casa agora [|cFF99CC33ATIVADO|r]"
L.SlashHomePingOff = "LagBar: Ping da casa agora [|cFF99CC33DESATIVADO|r]"
L.SlashHomePingInfo = "Alterna a exibicao do ping da casa (|cFF99CC33ATIV/DESAT|r)."
L.SlashHomePingChkBtn = "Mostrar o ping da casa."

L.SlashWorldPing = "pingmundo"
L.SlashWorldPingOn = "LagBar: Ping do mundo agora [|cFF99CC33ATIVADO|r]"
L.SlashWorldPingOff = "LagBar: Ping do mundo agora [|cFF99CC33DESATIVADO|r]"
L.SlashWorldPingInfo = "Alterna a exibicao do ping do mundo (|cFF99CC33ATIV/DESAT|r)."
L.SlashWorldPingChkBtn = "Mostrar o ping do mundo."

L.SlashImpDisplay = "melhorado"
L.SlashImpDisplayOn = "LagBar: Exibicao de ping melhorada agora [|cFF99CC33ATIVADA|r]"
L.SlashImpDisplayOff = "LagBar: Exibicao de ping melhorada agora [|cFF99CC33DESATIVADA|r]"
L.SlashImpDisplayInfo = "Alterna a exibicao de ping melhorada (|cFF99CC33ATIV/DESAT|r)."
L.SlashImpDisplayChkBtn = "Mostrar a exibicao de ping melhorada."

L.SlashMetricLabels = "metricas"
L.SlashMetricLabelsOn = "LagBar: Etiquetas metricas agora [|cFF99CC33ATIVADAS|r]"
L.SlashMetricLabelsOff = "LagBar: Etiquetas metricas agora [|cFF99CC33DESATIVADAS|r]"
L.SlashMetricLabelsInfo = "Alterna a exibicao de etiquetas metricas (|cFF99CC33ATIV/DESAT|r)."
L.SlashMetricLabelsChkBtn = "Mostrar etiquetas metricas na exibicao."

L.SlashClampToScreenChkBtn = "Fixar o quadro do LagBar na tela. |cFF99CC33(Evita que seja arrastado para fora da tela)|r"

L.AddonLoginMsg = "Mostrar anuncio de addon carregado ao fazer login."

L.TooltipDragInfo = "[Segure Shift e arraste para mover a janela.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "C"
L.World = "M"
