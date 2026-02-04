local ADDON_NAME, private = ...

local L = private:NewLocale("zhTW")
if not L then return end

L.SlashBG = "背景"
L.SlashBGOn = "LagBar: 背景現在為 [|cFF99CC33顯示|r]"
L.SlashBGOff = "LagBar: 背景現在為 [|cFF99CC33隱藏|r]"
L.SlashBGInfo = "顯示視窗背景。"

L.SlashTT = "提示"
L.SlashTTOn = "LagBar: 滑鼠提示現在為 [|cFF99CC33顯示|r]"
L.SlashTTOff = "LagBar: 滑鼠提示現在為 [|cFF99CC33隱藏|r]"
L.SlashTTInfo = "滑鼠停留在資料上時顯示提示。"

L.SlashReset = "重置"
L.SlashResetInfo = "重置框架位置。"
L.SlashResetAlert = "LagBar: 框架位置已重置！"

L.SlashScale = "縮放"
L.SlashScaleSet = "LagBar: 縮放比例已設定為 [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "縮放無效！數字必須在 [0.5 - 5] 之間。 (0.5, 1, 3, 4.6, 等..)"
L.SlashScaleInfo = "設定 LagBar 框架縮放 (0.5 - 5)。"
L.SlashScaleText = "LagBar 框架縮放"

L.SlashFPS = "幀數"
L.SlashFPSOn = "LagBar: 幀數顯示 [|cFF99CC33開|r]"
L.SlashFPSOff = "LagBar: 幀數顯示 [|cFF99CC33關|r]"
L.SlashFPSInfo = "切換幀數顯示 (|cFF99CC33開/關|r)。"
L.SlashFPSChkBtn = "顯示幀數狀態。"

L.SlashHomePing = "本地延遲"
L.SlashHomePingOn = "LagBar: 本地延遲顯示 [|cFF99CC33開|r]"
L.SlashHomePingOff = "LagBar: 本地延遲顯示 [|cFF99CC33關|r]"
L.SlashHomePingInfo = "切換本地延遲顯示 (|cFF99CC33開/關|r)。"
L.SlashHomePingChkBtn = "顯示本地延遲狀態。"

L.SlashWorldPing = "世界延遲"
L.SlashWorldPingOn = "LagBar: 世界延遲顯示 [|cFF99CC33開|r]"
L.SlashWorldPingOff = "LagBar: 世界延遲顯示 [|cFF99CC33關|r]"
L.SlashWorldPingInfo = "切換世界延遲顯示 (|cFF99CC33開/關|r)。"
L.SlashWorldPingChkBtn = "顯示世界延遲狀態。"

L.SlashImpDisplay = "顯示"
L.SlashImpDisplayOn = "LagBar: 延遲區域顯示 [|cFF99CC33開|r]"
L.SlashImpDisplayOff = "LagBar: 延遲區域顯示 [|cFF99CC33關|r]"
L.SlashImpDisplayInfo = "切換延遲區域顯示 (|cFF99CC33開/關|r)。"
L.SlashImpDisplayChkBtn = "顯示延遲區域縮寫。"

L.SlashMetricLabels = "毫秒"
L.SlashMetricLabelsOn = "LagBar: 顯示毫秒 [|cFF99CC33開|r]"
L.SlashMetricLabelsOff = "LagBar: 顯示毫秒 [|cFF99CC33關|r]"
L.SlashMetricLabelsInfo = "切換毫秒顯示 (|cFF99CC33開/關|r)。"
L.SlashMetricLabelsChkBtn = "顯示毫秒縮寫。"

L.SlashClampToScreenChkBtn = "將 LagBar 鎖定在螢幕內。|cFF99CC33（防止被拖離螢幕）|r"

L.AddonLoginMsg = "登入時顯示已載入插件資訊。"

L.TooltipDragInfo = "[按住 Shift 移動視窗。]"
L.FPS = "幀"
L.Milliseconds = "毫秒"
L.Home = "本"
L.World = "世"
