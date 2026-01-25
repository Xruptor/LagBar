local ADDON_NAME = ...
if GetLocale() ~= "zhCN" then return end

local addon = _G[ADDON_NAME]
local L = addon and addon.L
if not L then return end

L.SlashBG = "背景"
L.SlashBGOn = "LagBar: 背景现在是 [|cFF99CC33显示|r]"
L.SlashBGOff = "LagBar: 背景现在是 [|cFF99CC33隐藏|r]"
L.SlashBGInfo = "显示窗口背景。"

L.SlashTT = "提示"
L.SlashTTOn = "LagBar: 提示显示是 [|cFF99CC33显示|r]"
L.SlashTTOff = "LagBar: 提示显示是 [|cFF99CC33隐藏|r]"
L.SlashTTInfo = "将鼠标悬停在信息上时显示提示。"

L.SlashReset = "重置"
L.SlashResetInfo = "重置信息条位置"
L.SlashResetAlert = "LagBar: 信息条已重置为默认！"

L.SlashScale = "缩放"
L.SlashScaleSet = "LagBar: 缩放比列设置为 [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "缩放无效！数字必需为 [0.5 - 5]。 (0.5, 1, 3, 4.6, 等..)"
L.SlashScaleInfo = "设置信息条比例为 (0.5 - 5)。"
L.SlashScaleText = "LagBar 窗口比例"

L.SlashFPS = "帧数"
L.SlashFPSOn = "LagBar: 帧数显示 [|cFF99CC33开|r]"
L.SlashFPSOff = "LagBar: 帧数显示 [|cFF99CC33关|r]"
L.SlashFPSInfo = "切换帧数显示 (|cFF99CC33开/关|r)。"
L.SlashFPSChkBtn = "显示帧数状态。"

L.SlashHomePing = "本地延迟"
L.SlashHomePingOn = "LagBar: 本地延迟显示 [|cFF99CC33开|r]"
L.SlashHomePingOff = "LagBar: 本地延迟显示 [|cFF99CC33关|r]"
L.SlashHomePingInfo = "切换本地延迟显示 (|cFF99CC33开/关|r)."
L.SlashHomePingChkBtn = "显示本地延迟状态。"

L.SlashWorldPing = "世界延迟"
L.SlashWorldPingOn = "LagBar: 世界延迟显示 [|cFF99CC33开|r]"
L.SlashWorldPingOff = "LagBar: 世界延迟显示 [|cFF99CC33关|r]"
L.SlashWorldPingInfo = "切换世界延迟显示 (|cFF99CC33开/关|r)。"
L.SlashWorldPingChkBtn = "显示世界延迟状态。"

L.SlashImpDisplay = "显示"
L.SlashImpDisplayOn = "LagBar: 延迟地区显示 [|cFF99CC33开|r]"
L.SlashImpDisplayOff = "LagBar: 延迟地区显示 [|cFF99CC33关|r]"
L.SlashImpDisplayInfo = "切换延迟地区显示 (|cFF99CC33开/关|r)。"
L.SlashImpDisplayChkBtn = "显示延迟地区缩写。"

L.SlashMetricLabels = "毫秒"
L.SlashMetricLabelsOn = "LagBar: 显示毫秒 [|cFF99CC33开|r]"
L.SlashMetricLabelsOff = "LagBar: 显示毫秒 [|cFF99CC33关|r]"
L.SlashMetricLabelsInfo = "切换毫秒显示 (|cFF99CC33开/关|r)。"
L.SlashMetricLabelsChkBtn = "显示毫秒缩写。"

L.SlashClampToScreenChkBtn = "将LagBar 锁定在屏幕内。|cFF99CC33（防止被托离屏幕）|r"

L.AddonLoginMsg = "登录时显示已加载插件信息。"

L.TooltipDragInfo = "[按住 Shift 移动窗口。]"
L.FPS = "帧"
L.Milliseconds = "毫秒"
L.Home = "本"
L.World = "世"
