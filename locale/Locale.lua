local ADDON_NAME = ...

if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end

local addon = _G[ADDON_NAME]

addon.L = addon.L or {}
local L = addon.L

if not L._init then
	setmetatable(L, { __index = function(_, k) return k end })
	L._init = true
end

