local ADDON_NAME, private = ...
if type(private) ~= "table" then
	private = {}
end

if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end
local addon = _G[ADDON_NAME]

local current = (type(_G.GetLocale) == "function" and _G.GetLocale()) or "enUS"
if current == "enGB" then
	current = "enUS"
end

private._locales = private._locales or {
	current = current,
	default = nil,
	locales = {},
	defaultMT = nil,
}
private._locales.current = current

function private:NewLocale(locale, isDefault)
	if type(locale) ~= "string" or locale == "" then return nil end
	local store = private._locales

	if isDefault then
		store.default = store.default or {}
		return store.default
	end

	if locale ~= store.current then
		return nil
	end

	store.locales[locale] = store.locales[locale] or {}
	return store.locales[locale]
end

function private:GetLocale()
	local store = private._locales
	local currentLocale = store.locales[store.current]
	if currentLocale then
		if store.default and currentLocale ~= store.default then
			if not store.defaultMT or store.defaultMT.__index ~= store.default then
				store.defaultMT = { __index = store.default }
			end
			if getmetatable(currentLocale) ~= store.defaultMT then
				setmetatable(currentLocale, store.defaultMT)
			end
		end
		return currentLocale
	end
	return store.default or {}
end

private.L = private.L or setmetatable({}, {
	__index = function(_, key)
		return (private:GetLocale() or {})[key]
	end,
})

addon.L = private.L
addon._private = private
