local ADDON_NAME, addon = ...
if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end
addon = _G[ADDON_NAME]

addon.configFrame = CreateFrame("frame", ADDON_NAME.."_config_eventFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
local configFrame = addon.configFrame

local L = addon.L
if not L then
	L = {}
	setmetatable(L, { __index = function(_, k) return k end })
	addon.L = L
end

local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME

local lastObject
local function addConfigEntry(objEntry, adjustX, adjustY)

	objEntry:ClearAllPoints()

	if not lastObject then
		objEntry:SetPoint("TOPLEFT", 20, -150)
	else
		objEntry:SetPoint("LEFT", lastObject, "BOTTOMLEFT", adjustX or 0, adjustY or -30)
	end

	lastObject = objEntry
end

local chkBoxIndex = 0
local function createCheckbutton(parentFrame, displayText)
	chkBoxIndex = chkBoxIndex + 1

	local checkbutton = CreateFrame("CheckButton", ADDON_NAME.."_config_chkbtn_" .. chkBoxIndex, parentFrame, "ChatConfigCheckButtonTemplate")
	_G[checkbutton:GetName() .. "Text"]:SetText(" " .. displayText)

	return checkbutton
end

local buttonIndex = 0
local function createButton(parentFrame, displayText)
	buttonIndex = buttonIndex + 1

	local button = CreateFrame("Button", ADDON_NAME.."_config_button_" .. buttonIndex, parentFrame, "UIPanelButtonTemplate")
	button:SetText(displayText)
	button:SetHeight(30)
	button:SetWidth(button:GetTextWidth() + 30)

	return button
end

local sliderIndex = 0
local function createSlider(parentFrame, displayText, minVal, maxVal, setStep)
	sliderIndex = sliderIndex + 1

	local SliderBackdrop  = {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 6, bottom = 6 }
	}

	local slider = CreateFrame("Slider", ADDON_NAME.."_config_slider_" .. sliderIndex, parentFrame, BackdropTemplateMixin and "BackdropTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetHeight(15)
	slider:SetWidth(300)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	slider:SetMinMaxValues(minVal or 0.5, maxVal or 5)
	slider:SetValue(0.5)
	slider:SetBackdrop(SliderBackdrop)
	slider:SetValueStep(setStep or 1)

	local label = slider:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("CENTER", slider, "CENTER", 0, 16)
	label:SetJustifyH("CENTER")
	label:SetHeight(15)
	label:SetText(displayText)

	local lowtext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	lowtext:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 2, 3)
	lowtext:SetText(minVal)

	local hightext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	hightext:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -2, 3)
	hightext:SetText(maxVal)

	local currVal = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	currVal:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 45, 12)
	currVal:SetText('(?)')
	slider.currVal = currVal

	return slider
end

local function toggleSetting(key, onMsg, offMsg, onToggle)
	local newValue = not LagBar_DB[key]
	LagBar_DB[key] = newValue
	if onMsg and offMsg then
		DEFAULT_CHAT_FRAME:AddMessage(newValue and onMsg or offMsg)
	end
	if onToggle then
		onToggle(newValue)
	end
	return newValue
end

local function addToggleOption(opts)
	local btn = createCheckbutton(addon.aboutPanel, opts.label)
	btn:SetScript("OnShow", function() btn:SetChecked(LagBar_DB[opts.key]) end)
	btn.func = function()
		toggleSetting(opts.key, opts.onMsg, opts.offMsg, opts.onToggle)
	end
	btn:SetScript("OnClick", btn.func)
	addConfigEntry(btn, 0, opts.offset or -20)
	addon.aboutPanel[opts.storeKey] = btn
	return btn
end

local function LoadAboutFrame()

	--Code inspired from tekKonfigAboutPanel
	local about = CreateFrame("Frame", ADDON_NAME.."AboutPanel", InterfaceOptionsFramePanelContainer or UIParent, BackdropTemplateMixin and "BackdropTemplate")
	about.name = ADDON_NAME
	about:Hide()

	local fields = {"Version", "Author"}
	local GetAddonMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
	local notes = (GetAddonMetadata and GetAddonMetadata(ADDON_NAME, "Notes")) or ""

	local title = about:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(ADDON_NAME)

	local subtitle = about:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(32)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", about, -32, 0)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(notes)

	local anchor
	for _,field in pairs(fields) do
		local val = GetAddonMetadata and GetAddonMetadata(ADDON_NAME, field)
		if val then
			local title = about:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			title:SetWidth(75)
			if not anchor then title:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -8)
			else title:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -6) end
			title:SetJustifyH("RIGHT")
			title:SetText(field:gsub("X%-", ""))

			local detail = about:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
			detail:SetPoint("LEFT", title, "RIGHT", 4, 0)
			detail:SetPoint("RIGHT", -16, 0)
			detail:SetJustifyH("LEFT")
			detail:SetText(val)

			anchor = title
		end
	end

	if InterfaceOptions_AddCategory then
		InterfaceOptions_AddCategory(about)
	else
		local category, layout = _G.Settings.RegisterCanvasLayoutCategory(about, about.name);
		_G.Settings.RegisterAddOnCategory(category);
		addon.settingsCategory = category
	end

	return about
end

function configFrame:EnableConfig()

	addon.aboutPanel = LoadAboutFrame()

	--bg shown
	addToggleOption({
		key = "bgShown",
		label = L.SlashBGInfo,
		onMsg = L.SlashBGOn,
		offMsg = L.SlashBGOff,
		onToggle = function() addon:BackgroundToggle() end,
		offset = -20,
		storeKey = "btnBG",
	})

	--show tooltip
	addToggleOption({
		key = "ttShown",
		label = L.SlashTTInfo,
		onMsg = L.SlashTTOn,
		offMsg = L.SlashTTOff,
		offset = -25,
		storeKey = "btnTT",
	})

	--reset
	local btnReset = createButton(addon.aboutPanel, L.SlashResetInfo)
	btnReset.func = function()
		DEFAULT_CHAT_FRAME:AddMessage(L.SlashResetAlert)
		addon:ClearAllPoints()
		addon:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
	btnReset:SetScript("OnClick", btnReset.func)

	addConfigEntry(btnReset, 0, -30)
	addon.aboutPanel.btnReset = btnReset

	--scale
	local sliderScale = createSlider(addon.aboutPanel, L.SlashScaleText, 0.5, 5, 0.1)
	sliderScale:SetScript("OnShow", function()
		sliderScale:SetValue(LagBar_DB.scale)
		sliderScale.currVal:SetText("("..LagBar_DB.scale..")")
	end)
	sliderScale.sliderFunc = function(self, value)
		value = math.floor(value * 10) / 10
		if value < 0.5 then value = 0.5 end --always make sure we are 0.5 as the highest zero.  Anything lower will make the frame dissapear
		if value > 5 then value = 5 end --nothing bigger than this
		sliderScale.currVal:SetText("("..value..")")
		sliderScale:SetValue(value)
	end
	sliderScale.sliderMouseUp = function(self, button)
		local value = math.floor(self:GetValue() * 10) / 10
		addon:SetAddonScale(value)
	end
	sliderScale:SetScript("OnValueChanged", sliderScale.sliderFunc)
	sliderScale:SetScript("OnMouseUp", sliderScale.sliderMouseUp)

	addConfigEntry(sliderScale, 0, -40)
	addon.aboutPanel.sliderScale = sliderScale

	addToggleOption({
		key = "fps",
		label = L.SlashFPSChkBtn,
		onMsg = L.SlashFPSOn,
		offMsg = L.SlashFPSOff,
		onToggle = function() if addon.UpdateDisplay then addon:UpdateDisplay() end end,
		offset = -35,
		storeKey = "btnFPS",
	})

	addToggleOption({
		key = "homeping",
		label = L.SlashHomePingChkBtn,
		onMsg = L.SlashHomePingOn,
		offMsg = L.SlashHomePingOff,
		onToggle = function() if addon.UpdateDisplay then addon:UpdateDisplay() end end,
		offset = -20,
		storeKey = "btnHomePing",
	})

	addToggleOption({
		key = "worldping",
		label = L.SlashWorldPingChkBtn,
		onMsg = L.SlashWorldPingOn,
		offMsg = L.SlashWorldPingOff,
		onToggle = function() if addon.UpdateDisplay then addon:UpdateDisplay() end end,
		offset = -20,
		storeKey = "btnWorldPing",
	})

	addToggleOption({
		key = "impdisplay",
		label = L.SlashImpDisplayChkBtn,
		onMsg = L.SlashImpDisplayOn,
		offMsg = L.SlashImpDisplayOff,
		onToggle = function() if addon.UpdateDisplay then addon:UpdateDisplay() end end,
		offset = -20,
		storeKey = "btnImpDisplay",
	})

	addToggleOption({
		key = "metric",
		label = L.SlashMetricLabelsChkBtn,
		onMsg = L.SlashMetricLabelsOn,
		offMsg = L.SlashMetricLabelsOff,
		onToggle = function() if addon.UpdateDisplay then addon:UpdateDisplay() end end,
		offset = -20,
		storeKey = "btnMetricLabels",
	})

	addToggleOption({
		key = "clampToScreen",
		label = L.SlashClampToScreenChkBtn,
		onToggle = function(value) addon:SetClampedToScreen(value) end,
		offset = -20,
		storeKey = "btnClampToScreen",
	})

	--login message
	addToggleOption({
		key = "addonLoginMsg",
		label = L.AddonLoginMsg,
		offset = -20,
		storeKey = "btnAddonLoadedChk",
	})

end
