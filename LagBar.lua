--LagBar by Xruptor

local ADDON_NAME, addon = ...
if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end
addon = _G[ADDON_NAME]

local L = addon.L
if not L then
	L = {}
	setmetatable(L, { __index = function(_, k) return k end })
	addon.L = L
end

local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local LagBar_SlashCommand

local UPDATE_INTERVAL = 1

local lagBarTooltip = CreateFrame("GameTooltip", "LagBarTooltip", UIParent, "GameTooltipTemplate")

local floor = math.floor
local format = string.format
local max = math.max
local GetFramerate = GetFramerate
local GetNetStats = GetNetStats
local wipe = wipe or function(t) for k in pairs(t) do t[k] = nil end end
local tconcat = table.concat
local unpack = unpack or table.unpack

local MIN_FRAME_WIDTH = 30
local MIN_FRAME_HEIGHT = 25
local TEXT_PADDING_X = 20
local TEXT_PADDING_Y = 10

local PING_THRESHOLDS = { 1000, 500, 250, 100, 0 }
local DEFAULTS = {
	bgShown = true,
	ttShown = true,
	worldping = true,
	impdisplay = true,
	scale = 1,
	fps = true,
	homeping = true,
	metric = true,
	clampToScreen = true,
	addonLoginMsg = true,
}

----------------------
-- Color Functions  --
----------------------

local function LagBar_GetThresholdPercentage(quality, ...)
	local n = select('#', ...)
	if n <= 1 then
		return LagBar_GetThresholdPercentage(quality, 0, ... or 1)
	end

	local worst = ...
	local best = select(n, ...)

	if worst == best and quality == worst then
		return 0.5
	end

	if worst <= best then
		if quality <= worst then
			return 0
		elseif quality >= best then
			return 1
		end
		local last = worst
		for i = 2, n-1 do
			local value = select(i, ...)
			if quality <= value then
				return ((i-2) + (quality - last) / (value - last)) / (n-1)
			end
			last = value
		end

		local value = select(n, ...)
		return ((n-2) + (quality - last) / (value - last)) / (n-1)
	else
		if quality >= worst then
			return 0
		elseif quality <= best then
			return 1
		end
		local last = worst
		for i = 2, n-1 do
			local value = select(i, ...)
			if quality >= value then
				return ((i-2) + (quality - last) / (value - last)) / (n-1)
			end
			last = value
		end

		local value = select(n, ...)
		return ((n-2) + (quality - last) / (value - last)) / (n-1)
	end
end

--check for infinite
local function isInf(value)
	return value == math.huge or value == -math.huge
end

local function LagBar_GetThresholdColor(quality, ...)
	if quality ~= quality or isInf(quality) then
		return 1, 1, 1
	end

	local percent = LagBar_GetThresholdPercentage(quality, ...)

	if percent <= 0 then
		return 1, 0, 0
	elseif percent <= 0.5 then
		return 1, percent*2, 0
	elseif percent >= 1 then
		return 0, 1, 0
	else
		return 2 - percent*2, 1, 0
	end
end

local function LagBar_GetThresholdHexColor(quality, ...)
	local r, g, b = LagBar_GetThresholdColor(quality, ...)
	return format("%02x%02x%02x", r*255, g*255, b*255)
end


----------------------
--      Enable      --
----------------------

local function EnsureDefaults()
	if not LagBar_DB then LagBar_DB = {} end
	for key, value in pairs(DEFAULTS) do
		if LagBar_DB[key] == nil then
			LagBar_DB[key] = value
		end
	end
end

function addon:EnableAddon()
	EnsureDefaults()

	self:DrawGUI()
	self:RestoreLayout(ADDON_NAME)

	self:BackgroundToggle()

	SLASH_LAGBAR1 = "/lagbar"
	SlashCmdList["LAGBAR"] = LagBar_SlashCommand

	if addon.configFrame then addon.configFrame:EnableConfig() end

	if LagBar_DB.addonLoginMsg then
		local GetAddonMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
		local ver = (GetAddonMetadata and GetAddonMetadata(ADDON_NAME, "Version")) or "1.0"
		DEFAULT_CHAT_FRAME:AddMessage(format("|cFF99CC33%s|r [v|cFF20ff20%s|r] loaded:   /lagbar", ADDON_NAME, ver or "1.0"))
	end
end

local function normalizeSlashToken(token)
	if not token then return nil end
	return token:lower()
end

local function matchesSlash(token, key, baseL)
	if not token or not key then return false end
	local v = L[key]
	if type(v) == "string" and token == v:lower() then return true end
	if baseL then
		local bv = baseL[key]
		if type(bv) == "string" and token == bv:lower() then return true end
	end
	return false
end

LagBar_SlashCommand = function(cmd)
	local token, rest = cmd:match("^(%S+)%s*(.-)%s*$")
	token = normalizeSlashToken(token)
	local baseL = addon.L_enUS

	if token then
		if matchesSlash(token, "SlashBG", baseL) then
			addon.aboutPanel.btnBG.func()
			return true
		elseif matchesSlash(token, "SlashTT", baseL) then
			addon.aboutPanel.btnTT.func()
			return true
		elseif matchesSlash(token, "SlashReset", baseL) then
			addon.aboutPanel.btnReset.func()
			return true
		elseif matchesSlash(token, "SlashScale", baseL) then
			local scalenum = tonumber(rest)
			if scalenum and scalenum >= 0.5 and scalenum <= 5 then
				addon:SetAddonScale(scalenum)
			else
				DEFAULT_CHAT_FRAME:AddMessage(L.SlashScaleSetInvalid)
			end
			return true
		elseif matchesSlash(token, "SlashWorldPing", baseL) then
			addon.aboutPanel.btnWorldPing.func()
			return true
		elseif matchesSlash(token, "SlashFPS", baseL) then
			addon.aboutPanel.btnFPS.func()
			return true
		elseif matchesSlash(token, "SlashHomePing", baseL) then
			addon.aboutPanel.btnHomePing.func()
			return true
		elseif matchesSlash(token, "SlashImpDisplay", baseL) then
			addon.aboutPanel.btnImpDisplay.func()
			return true
		elseif matchesSlash(token, "SlashMetricLabels", baseL) then
			addon.aboutPanel.btnMetricLabels.func()
			return true
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage(ADDON_NAME, 64/255, 224/255, 208/255)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashReset.." - "..L.SlashResetInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashBG.." - "..L.SlashBGInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashTT.." - "..L.SlashTTInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashFPS.." - "..L.SlashFPSInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashHomePing.." - "..L.SlashHomePingInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashWorldPing.." - "..L.SlashWorldPingInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashImpDisplay.." - "..L.SlashImpDisplayInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashMetricLabels.." - "..L.SlashMetricLabelsInfo)
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar "..L.SlashScale.." # - "..L.SlashScaleInfo)
end

addon:RegisterEvent("ADDON_LOADED")
addon:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" or event == "PLAYER_LOGIN" then
		if event == "ADDON_LOADED" then
			local arg1 = ...
			if arg1 and arg1 == ADDON_NAME then
				self:UnregisterEvent("ADDON_LOADED")
				self:RegisterEvent("PLAYER_LOGIN")
			end
			return
		end
		if IsLoggedIn() then
			self:EnableAddon(event, ...)
			self:UnregisterEvent("PLAYER_LOGIN")
		end
		return
	end
	if self[event] then
		return self[event](self, event, ...)
	end
end)

local BACKDROP_STYLE = {
	bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 },
}

local function ApplyBackdrop(frame, enabled)
	if enabled then
		frame:SetBackdrop(BACKDROP_STYLE)
		frame:SetBackdropBorderColor(0.5, 0.5, 0.5)
		frame:SetBackdropColor(0.5, 0.5, 0.5, 0.6)
	else
		frame:SetBackdrop(nil)
	end
end

function addon:DrawGUI()
	addon:SetWidth(MIN_FRAME_WIDTH)
	addon:SetHeight(MIN_FRAME_HEIGHT)
	addon:SetMovable(true)
	addon:SetClampedToScreen(LagBar_DB.clampToScreen)

	addon:SetAddonScale(LagBar_DB.scale, true)

	ApplyBackdrop(addon, LagBar_DB.bgShown)

	addon:EnableMouse(true)

	local g = addon:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
	g:SetJustifyH("LEFT")
	g:SetPoint("CENTER", 0, 0)
	g:SetText("")
	addon.text = g

	addon:SetScript("OnMouseDown", function(self)
		if IsShiftKeyDown() then
			self.isMoving = true
			self:StartMoving()
		end
	end)
	addon:SetScript("OnMouseUp", function(self)
		if self.isMoving then
			self.isMoving = nil
			self:StopMovingOrSizing()
			addon:SaveLayout(ADDON_NAME)
		end
	end)

	addon:StartUpdateTicker()

	addon:SetScript("OnLeave", function()
		lagBarTooltip:Hide()
	end)

	addon:SetScript("OnEnter", function()
		lagBarTooltip:SetOwner(self, "ANCHOR_TOP")
		lagBarTooltip:SetPoint(self:GetTipAnchor(addon))
		lagBarTooltip:ClearLines()

		if LagBar_DB.ttShown then
			lagBarTooltip:AddLine(ADDON_NAME)
			lagBarTooltip:AddLine(L.TooltipDragInfo, 64/255, 224/255, 208/255)
		end

		lagBarTooltip:Show()
	end)

	addon:Show()
end

local parts = {}

local function formatValue(value, hexColor, suffix)
	return format("|cff%s%d|r%s", hexColor, value, suffix or "")
end

function addon:UpdateDisplay()
	if not LagBar_DB then return end
	if not self.text then return end
	if not self:IsShown() then return end

	local db = LagBar_DB
	local metricEnabled = db.metric
	local metricFps = metricEnabled and (" " .. (L.FPS or "fps")) or ""
	local metricMs = metricEnabled and (" " .. (L.Milliseconds or "ms")) or ""

	wipe(parts)

	if db.fps then
		local framerate = floor(GetFramerate() + 0.5)
		parts[#parts + 1] = formatValue(framerate, LagBar_GetThresholdHexColor(framerate / 60), metricFps)
	end

	if db.homeping or db.worldping then
		local latencyHome, latencyWorld
		if C_Net then
			latencyHome = C_Net.GetHomeLatency() or 0
			latencyWorld = C_Net.GetWorldLatency() or 0
		else
			local _, _, h, w = GetNetStats()
			latencyHome, latencyWorld = h or 0, w or 0
		end

		if db.homeping then
			local latencyText = formatValue(latencyHome, LagBar_GetThresholdHexColor(latencyHome, unpack(PING_THRESHOLDS)), metricMs)
			if db.impdisplay then
				latencyText = format("|cFF99CC33%s: |r%s", L.Home or "H", latencyText)
			end
			parts[#parts + 1] = latencyText
		end

		if db.worldping then
			local latencyText = formatValue(latencyWorld, LagBar_GetThresholdHexColor(latencyWorld, unpack(PING_THRESHOLDS)), metricMs)
			if db.impdisplay then
				latencyText = format("|cFF99CC33%s: |r%s", L.World or "W", latencyText)
			end
			parts[#parts + 1] = latencyText
		end
	end

	local finalText = tconcat(parts, " | ")
	if finalText ~= self._lastText then
		self.text:SetText(finalText)
		self._lastText = finalText
	end

	local newWidth = max(MIN_FRAME_WIDTH, self.text:GetStringWidth() + TEXT_PADDING_X)
	local newHeight = max(MIN_FRAME_HEIGHT, self.text:GetStringHeight() + TEXT_PADDING_Y)

	if newWidth ~= self._lastWidth then
		self:SetWidth(newWidth)
		self._lastWidth = newWidth
	end

	if newHeight ~= self._lastHeight then
		self:SetHeight(newHeight)
		self._lastHeight = newHeight
	end
end

function addon:StopUpdateTicker()
	if self._ticker then
		self._ticker:Cancel()
		self._ticker = nil
	end
	self:SetScript("OnUpdate", nil)
end

function addon:StartUpdateTicker()
	self:StopUpdateTicker()
	self:UpdateDisplay()

	if C_Timer and C_Timer.NewTicker then
		self._ticker = C_Timer.NewTicker(UPDATE_INTERVAL, function()
			if addon and addon.UpdateDisplay then
				addon:UpdateDisplay()
			end
		end)
	else
		local timeSinceLastUpdate = 0
		self:SetScript("OnUpdate", function(self, elapsed)
			timeSinceLastUpdate = timeSinceLastUpdate + elapsed
			if timeSinceLastUpdate >= UPDATE_INTERVAL then
				timeSinceLastUpdate = 0
				self:UpdateDisplay()
			end
		end)
	end
end

local function ClampScale(value)
	if value < 0.5 then return 0.5 end
	if value > 5 then return 5 end
	return value
end

function addon:SetAddonScale(value, bypass)
	value = ClampScale(value)
	LagBar_DB.scale = value

	if not bypass then
		DEFAULT_CHAT_FRAME:AddMessage(format(L.SlashScaleSet, value))
	end
	addon:SetScale(LagBar_DB.scale)
end

local function EnsureLayoutEntry(frame)
	if not LagBar_DB then LagBar_DB = {} end
	local opt = LagBar_DB[frame]
	if not opt or not opt.point or not opt.xOfs then
		opt = {
			point = "CENTER",
			relativePoint = "CENTER",
			xOfs = 0,
			yOfs = 0,
		}
		LagBar_DB[frame] = opt
	end
	return opt
end

function addon:SaveLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	local opt = EnsureLayoutEntry(frame)

	local point, _, relativePoint, xOfs, yOfs = _G[frame]:GetPoint()
	opt.point = point
	opt.relativePoint = relativePoint
	opt.xOfs = xOfs
	opt.yOfs = yOfs
end

function addon:RestoreLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	local opt = EnsureLayoutEntry(frame)

	_G[frame]:ClearAllPoints()
	_G[frame]:SetPoint(opt.point, UIParent, opt.relativePoint, opt.xOfs, opt.yOfs)
end

function addon:BackgroundToggle()
	ApplyBackdrop(addon, LagBar_DB.bgShown)
end

------------------------
--      Tooltip!      --
------------------------

function addon:GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end
