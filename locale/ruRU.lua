local ADDON_NAME, addon = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "ruRU")
if not L then return end
-- Translator ZamestoTV
L.SlashBG = "bg"
L.SlashBGOn = "LagBar: Фон теперь [|cFF99CC33ПОКАЗАН|r]"
L.SlashBGOff = "LagBar: Фон теперь [|cFF99CC33СКРЫТ|r]"
L.SlashBGInfo = "Показать фон окна."

L.SlashTT = "tt"
L.SlashTTOn = "LagBar: Всплывающая подсказка при наведении теперь [|cFF99CC33ПОКАЗАНА|r]"
L.SlashTTOff = "LagBar: Всплывающая подсказка при наведении теперь [|cFF99CC33СКРЫТА|r]"
L.SlashTTInfo = "Показывать всплывающую подсказку при наведении на данные."

L.SlashReset = "reset"
L.SlashResetInfo = "Сбросить позицию рамки."
L.SlashResetAlert = "LagBar: Позиция рамки сброшена!"

L.SlashScale = "scale"
L.SlashScaleSet = "LagBar: масштаб установлен на [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Недопустимый масштаб! Число должно быть от [0.5 - 5]. (0.5, 1, 3, 4.6 и т.д.)"
L.SlashScaleInfo = "Установить масштаб рамок LootRollMover (0.5 - 5)."
L.SlashScaleText = "Масштаб рамки LagBar"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar: FPS теперь [|cFF99CC33ВКЛЮЧЕН|r]"
L.SlashFPSOff = "LagBar: FPS теперь [|cFF99CC33ВЫКЛЮЧЕН|r]"
L.SlashFPSInfo = "Переключает отображение FPS (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashFPSChkBtn = "Показывать отображение FPS."

L.SlashHomePing = "homeping"
L.SlashHomePingOn = "LagBar: HomePing теперь [|cFF99CC33ВКЛЮЧЕН|r]"
L.SlashHomePingOff = "LagBar: HomePing теперь [|cFF99CC33ВЫКЛЮЧЕН|r]"
L.SlashHomePingInfo = "Переключает отображение локального пинга (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashHomePingChkBtn = "Показывать отображение локального пинга."

L.SlashWorldPing = "worldping"
L.SlashWorldPingOn = "LagBar: WorldPing теперь [|cFF99CC33ВКЛЮЧЕН|r]"
L.SlashWorldPingOff = "LagBar: WorldPing теперь [|cFF99CC33ВЫКЛЮЧЕН|r]"
L.SlashWorldPingInfo = "Переключает отображение глобального пинга (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashWorldPingChkBtn = "Показывать отображение глобального пинга."

L.SlashImpDisplay = "impdisplay"
L.SlashImpDisplayOn = "LagBar: Улучшенное отображение пинга теперь [|cFF99CC33ВКЛЮЧЕНО|r]"
L.SlashImpDisplayOff = "LagBar: Улучшенное отображение пинга теперь [|cFF99CC33ВЫКЛЮЧЕНО|r]"
L.SlashImpDisplayInfo = "Переключает улучшенное отображение пинга (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashImpDisplayChkBtn = "Показывать улучшенное отображение пинга."

L.SlashMetricLabels = "metric"
L.SlashMetricLabelsOn = "LagBar: Метрические метки теперь [|cFF99CC33ВКЛЮЧЕНЫ|r]"
L.SlashMetricLabelsOff = "LagBar: Метрические метки теперь [|cFF99CC33ВЫКЛЮЧЕНЫ|r]"
L.SlashMetricLabelsInfo = "Переключает отображение метрических меток (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashMetricLabelsChkBtn = "Показывать метрические метки в отображении."

L.SlashClampToScreenChkBtn = "Фиксировать рамку LagBar к экрану. |cFF99CC33(Предотвращает перетаскивание за пределы экрана)|r"

L.AddonLoginMsg = "Показывать объявление о загрузке аддона при входе."

L.TooltipDragInfo = "[Удерживайте Shift и перетаскивайте, чтобы переместить окно.]"
L.FPS = "к/с"
L.Milliseconds = "мс"
L.Home = "Д"
L.World = "М"
