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

local UPDATE_INTERVAL = 1

local lagBarTooltip = CreateFrame("GameTooltip", "LagBarTooltip", UIParent, "GameTooltipTemplate")

local floor = math.floor
local format = string.format
local max = math.max
local GetFramerate = GetFramerate
local GetNetStats = GetNetStats
local wipe = wipe or function(t) for k in pairs(t) do t[k] = nil end end

local MIN_FRAME_WIDTH = 30
local MIN_FRAME_HEIGHT = 25
local TEXT_PADDING_X = 20
local TEXT_PADDING_Y = 10

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
local function isINF(value)
  return value == math.huge or value == -math.huge
end

local function LagBar_GetThresholdColor(quality, ...)

	if quality ~= quality or isINF(quality) then
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
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end


----------------------
--      Enable      --
----------------------

function addon:EnableAddon()

	if not LagBar_DB then LagBar_DB = {} end

	if LagBar_DB.bgShown == nil then LagBar_DB.bgShown = true end
	if LagBar_DB.ttShown == nil then LagBar_DB.ttShown = true end
	if LagBar_DB.worldping == nil then LagBar_DB.worldping = true end
	if LagBar_DB.impdisplay == nil then LagBar_DB.impdisplay = true end
	if LagBar_DB.scale == nil then LagBar_DB.scale = 1 end
	if LagBar_DB.fps == nil then LagBar_DB.fps = true end
	if LagBar_DB.homeping == nil then LagBar_DB.homeping = true end
	if LagBar_DB.metric == nil then LagBar_DB.metric = true end
	if LagBar_DB.clampToScreen == nil then LagBar_DB.clampToScreen = true end
	if LagBar_DB.addonLoginMsg == nil then LagBar_DB.addonLoginMsg = true end

	self:DrawGUI()
	self:RestoreLayout(ADDON_NAME)

	self:BackgroundToggle()

	SLASH_LAGBAR1 = "/lagbar";
	SlashCmdList["LAGBAR"] = LagBar_SlashCommand;

	if addon.configFrame then addon.configFrame:EnableConfig() end

	if LagBar_DB.addonLoginMsg then
		local GetAddonMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
		local ver = (GetAddonMetadata and GetAddonMetadata(ADDON_NAME, "Version")) or "1.0"
		DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF99CC33%s|r [v|cFF20ff20%s|r] loaded:   /lagbar", ADDON_NAME, ver or "1.0"))
	end
end

function LagBar_SlashCommand(cmd)

	local a,b,c = string.find(cmd, "(%S+)") -- contiguous string of non-space characters
	local baseL = addon.L_enUS

	local function matches(token, key)
		if not token or not key then return false end
		token = token:lower()
		local v = L[key]
		if type(v) == "string" and token == v:lower() then return true end
		if baseL then
			local bv = baseL[key]
			if type(bv) == "string" and token == bv:lower() then return true end
		end
		return false
	end

	if a then
		if matches(c, "SlashBG") then
			addon.aboutPanel.btnBG.func(true)
			return true
		elseif matches(c, "SlashTT") then
			addon.aboutPanel.btnTT.func()
			return true
		elseif matches(c, "SlashReset") then
			addon.aboutPanel.btnReset.func()
			return true
		elseif matches(c, "SlashScale") then
			if b then
				local scalenum = string.sub(cmd, b + 2)
				if scalenum and scalenum ~= "" and tonumber(scalenum) and tonumber(scalenum) >= 0.5 and tonumber(scalenum) <= 5 then
					addon:SetAddonScale(tonumber(scalenum))
				else
					DEFAULT_CHAT_FRAME:AddMessage(L.SlashScaleSetInvalid)
				end
				return true
			end
		elseif matches(c, "SlashWorldPing") then
			addon.aboutPanel.btnWorldPing.func(true)
			return true
		elseif matches(c, "SlashFPS") then
			addon.aboutPanel.btnFPS.func(true)
			return true
		elseif matches(c, "SlashHomePing") then
			addon.aboutPanel.btnHomePing.func(true)
			return true
		elseif matches(c, "SlashImpDisplay") then
			addon.aboutPanel.btnImpDisplay.func(true)
			return true
		elseif matches(c, "SlashMetricLabels") then
			addon.aboutPanel.btnMetricLabels.func(true)
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

function addon:DrawGUI()

	addon:SetWidth(30)
	addon:SetHeight(25)
	addon:SetMovable(true)
	addon:SetClampedToScreen(LagBar_DB.clampToScreen)

	addon:SetAddonScale(LagBar_DB.scale, true)

	if LagBar_DB.bgShown then
		addon:SetBackdrop( {
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground";
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border";
			tile = true; tileSize = 32; edgeSize = 16;
			insets = { left = 5; right = 5; top = 5; bottom = 5; };
		} );
		addon:SetBackdropBorderColor(0.5, 0.5, 0.5);
		addon:SetBackdropColor(0.5, 0.5, 0.5, 0.6)
	else
		addon:SetBackdrop(nil)
	end

	addon:EnableMouse(true)

	local g = addon:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
	g:SetJustifyH("LEFT")
	g:SetPoint("CENTER",0,0)
	g:SetText("")
	addon.text = g

	addon:SetScript("OnMouseDown",function(self)
		if (IsShiftKeyDown()) then
			self.isMoving = true
			self:StartMoving();
	 	end
	end)
	addon:SetScript("OnMouseUp",function(self)
		if( self.isMoving ) then

			self.isMoving = nil
			self:StopMovingOrSizing()

			addon:SaveLayout(ADDON_NAME)

		end
	end)

	addon:StartUpdateTicker()

	addon:SetScript("OnLeave",function()
		lagBarTooltip:Hide()
	end)

	addon:SetScript("OnEnter",function()

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

function addon:UpdateDisplay()
	if not LagBar_DB then return end
	if not self.text then return end
	if not self:IsShown() then return end

	wipe(parts)

	local _, _, latencyHome, latencyWorld = GetNetStats()

	if LagBar_DB.fps then
		local metric = LagBar_DB.metric and (L.FPS or "fps") or ""
		local framerate = floor(GetFramerate() + 0.5)
		parts[#parts + 1] = format("|cff%s%d|r%s", LagBar_GetThresholdHexColor(framerate / 60), framerate, metric ~= "" and (" " .. metric) or "")
	end

	if LagBar_DB.homeping then
		local metric = LagBar_DB.metric and (L.Milliseconds or "ms") or ""
		local latencyText = format("|cff%s%d|r%s", LagBar_GetThresholdHexColor(latencyHome, 1000, 500, 250, 100, 0), latencyHome, metric ~= "" and (" " .. metric) or "")
		if LagBar_DB.impdisplay then
			latencyText = "|cFF99CC33" .. (L.Home or "H") .. ": |r" .. latencyText
		end
		parts[#parts + 1] = latencyText
	end

	if LagBar_DB.worldping then
		local metric = LagBar_DB.metric and (L.Milliseconds or "ms") or ""
		local latencyText = format("|cff%s%d|r%s", LagBar_GetThresholdHexColor(latencyWorld, 1000, 500, 250, 100, 0), latencyWorld, metric ~= "" and (" " .. metric) or "")
		if LagBar_DB.impdisplay then
			latencyText = "|cFF99CC33" .. (L.World or "W") .. ": |r" .. latencyText
		end
		parts[#parts + 1] = latencyText
	end

	local finalText = table.concat(parts, " | ")
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

function addon:SetAddonScale(value, bypass) 
	--fix this in case it's ever smaller than   
	if value < 0.5 then value = 0.5 end --anything smaller and it would vanish  
	if value > 5 then value = 5 end --WAY too big  
 
	LagBar_DB.scale = value 
 
	if not bypass then 
		DEFAULT_CHAT_FRAME:AddMessage(string.format(L.SlashScaleSet, value)) 
	end 
	addon:SetScale(LagBar_DB.scale) 
end

function addon:SaveLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	if not LagBar_DB then LagBar_DB = {} end

	local opt = LagBar_DB[frame] or nil

	if not opt or not opt.point or not opt.xOfs then
		LagBar_DB[frame] = {
			["point"] = "CENTER",
			["relativePoint"] = "CENTER",
			["xOfs"] = 0,
			["yOfs"] = 0,
		}
		opt = LagBar_DB[frame]
		return
	end

	local point, relativeTo, relativePoint, xOfs, yOfs = _G[frame]:GetPoint()
	opt.point = point
	opt.relativePoint = relativePoint
	opt.xOfs = xOfs
	opt.yOfs = yOfs
end

function addon:RestoreLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	if not LagBar_DB then LagBar_DB = {} end

	local opt = LagBar_DB[frame] or nil

	if not opt or not opt.point or not opt.xOfs then
		LagBar_DB[frame] = {
			["point"] = "CENTER",
			["relativePoint"] = "CENTER",
			["xOfs"] = 0,
			["yOfs"] = 0,
		}
		opt = LagBar_DB[frame]
	end

	_G[frame]:ClearAllPoints()
	_G[frame]:SetPoint(opt.point, UIParent, opt.relativePoint, opt.xOfs, opt.yOfs)
end

function addon:BackgroundToggle()
	if LagBar_DB.bgShown then
		addon:SetBackdrop( {
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground";
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border";
			tile = true; tileSize = 32; edgeSize = 16;
			insets = { left = 5; right = 5; top = 5; bottom = 5; };
		} );
		addon:SetBackdropBorderColor(0.5, 0.5, 0.5);
		addon:SetBackdropColor(0.5, 0.5, 0.5, 0.6)
	else
		addon:SetBackdrop(nil)
	end
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
