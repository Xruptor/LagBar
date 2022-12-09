--LagBar by Xruptor

local ADDON_NAME, addon = ...
if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end
addon = _G[ADDON_NAME]

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local debugf = tekDebug and tekDebug:GetFrame(ADDON_NAME)
local function Debug(...)
    if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end
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

local MAX_INTERVAL = 1
local UPDATE_INTERVAL = 0

local lagBarTooltip = CreateFrame("GameTooltip", "LagBarTooltip", UIParent, "GameTooltipTemplate")

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

	self:DrawGUI()
	self:RestoreLayout(ADDON_NAME)
	
	self:BackgroundToggle()
	
	SLASH_LAGBAR1 = "/lagbar";
	SlashCmdList["LAGBAR"] = LagBar_SlashCommand;
	
	if addon.configFrame then addon.configFrame:EnableConfig() end
	
	local ver = GetAddOnMetadata(ADDON_NAME,"Version") or '1.0'
	DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF99CC33%s|r [v|cFF20ff20%s|r] loaded:   /lagbar", ADDON_NAME, ver or "1.0"))
end

function LagBar_SlashCommand(cmd)

	local a,b,c=strfind(cmd, "(%S+)"); --contiguous string of non-space characters
	
	if a then
		if c and c:lower() == L.SlashBG then
			addon.aboutPanel.btnBG.func(true)
			return true
		elseif c and c:lower() == L.SlashTT then
			addon.aboutPanel.btnTT.func()
			return true
		elseif c and c:lower() == L.SlashReset then
			addon.aboutPanel.btnReset.func()
			return true
		elseif c and c:lower() == L.SlashScale then
			if b then
				local scalenum = strsub(cmd, b+2)
				if scalenum and scalenum ~= "" and tonumber(scalenum) and tonumber(scalenum) > 0 and tonumber(scalenum) <= 200 then
					addon.aboutPanel.sliderScale.func(tonumber(scalenum))
				else
					DEFAULT_CHAT_FRAME:AddMessage(L.SlashScaleSetInvalid)
				end
				return true
			end
		elseif c and c:lower() == L.SlashWorldPing then
			addon.aboutPanel.btnWorldPing.func(true)
			return true
		elseif c and c:lower() == L.SlashFPS then
			addon.aboutPanel.btnFPS.func(true)
			return true
		elseif c and c:lower() == L.SlashHomePing then
			addon.aboutPanel.btnHomePing.func(true)
			return true
		elseif c and c:lower() == L.SlashImpDisplay then
			addon.aboutPanel.btnImpDisplay.func(true)
			return true
		elseif c and c:lower() == L.SlashMetricLabels then
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
	addon:SetClampedToScreen(true)
	
	addon:SetScale(LagBar_DB.scale)
	
	if LagBar_DB.bgShown == 1 then
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

	addon:SetScript("OnMouseDown",function()
		if (IsShiftKeyDown()) then
			self.isMoving = true
			self:StartMoving();
	 	end
	end)
	addon:SetScript("OnMouseUp",function()
		if( self.isMoving ) then

			self.isMoving = nil
			self:StopMovingOrSizing()

			addon:SaveLayout(ADDON_NAME)

		end
	end)

	addon:SetScript("OnUpdate", function(self, arg1)
		
		if (UPDATE_INTERVAL > 0) then
			UPDATE_INTERVAL = UPDATE_INTERVAL - arg1
		else
			UPDATE_INTERVAL = MAX_INTERVAL;
			
			local finalText = ""
			local metric
			
			
			if LagBar_DB.metric then metric = L.FPS else metric = "" end
			--thanks to comix1234 on wowinterface.com for the update.
			local framerate = floor(GetFramerate() + 0.5)
			local framerate_text = format("|cff%s%d|r "..metric, LagBar_GetThresholdHexColor(framerate / 60), framerate)
			
			if not LagBar_DB.fps then
				framerate_text = ""
			end
			
			if LagBar_DB.metric then metric = L.Milliseconds else metric = "" end
			local latencyHome = select(3, GetNetStats())
			local latency_text = format("|cff%s%d|r "..metric, LagBar_GetThresholdHexColor(latencyHome, 1000, 500, 250, 100, 0), latencyHome)
				
			if not LagBar_DB.homeping then
				latency_text = ""
			end
			
			if LagBar_DB.metric then metric = L.Milliseconds else metric = "" end
			local latencyWorld = select(4, GetNetStats())
			local latency_text_server = format("|cff%s%d|r "..metric, LagBar_GetThresholdHexColor(latencyWorld, 1000, 500, 250, 100, 0), latencyWorld)

			if not LagBar_DB.worldping then
				latency_text_server = ""
			end
			
			
			if LagBar_DB.fps and (LagBar_DB.homeping or LagBar_DB.worldping) then
				finalText = framerate_text.." | "
			else
				finalText = framerate_text
			end
			
			if LagBar_DB.homeping and LagBar_DB.worldping then
				if LagBar_DB.impdisplay then
					finalText = finalText.."|cFF99CC33"..L.Home..":|r"..latency_text.." | "
				else
					finalText = finalText..latency_text.." | "
				end
			elseif LagBar_DB.homeping then
				if LagBar_DB.impdisplay then
					finalText = finalText.."|cFF99CC33"..L.Home..":|r"..latency_text
				else
					finalText = finalText..latency_text
				end
			end
			
			if LagBar_DB.worldping then
				if LagBar_DB.impdisplay then
					finalText = finalText.."|cFF99CC33"..L.World..":|r"..latency_text_server
				else
					finalText = finalText..latency_text_server
				end
			end
			
			g:SetText(finalText)
			
			--check for overlapping text (JUST IN CASE)
			if g:GetStringWidth() > addon:GetWidth() then
				addon:SetWidth(g:GetStringWidth() + 20)
			elseif (addon:GetWidth() - g:GetStringWidth()) > 41 then
				addon:SetWidth(g:GetStringWidth() + 41)
			end

		end

	end)
	
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
