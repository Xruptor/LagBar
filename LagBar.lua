--LagBar by Xruptor

local f = CreateFrame("frame","LagBar",UIParent)
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

local debugf = tekDebug and tekDebug:GetFrame("LagBar")
local function Debug(...)
    if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end
end

local MAX_INTERVAL = 1
local UPDATE_INTERVAL = 0

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

local function LagBar_GetThresholdColor(quality, ...)

	local inf = 1/0
	
	if quality ~= quality or quality == inf or quality == -inf then
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

function f:PLAYER_LOGIN()

	if not LagBar_DB then LagBar_DB = {} end
	
	if LagBar_DB.bgShown == nil then LagBar_DB.bgShown = 1 end
	if LagBar_DB.worldping == nil then LagBar_DB.worldping = true end
	if LagBar_DB.impdisplay == nil then LagBar_DB.impdisplay = true end
	if LagBar_DB.scale == nil then LagBar_DB.scale = 1 end

	self:DrawGUI()
	self:RestoreLayout("LagBar")
	
	SLASH_LAGBAR1 = "/lagbar";
	SlashCmdList["LAGBAR"] = LagBar_SlashCommand;
	
	local ver = GetAddOnMetadata("LagBar","Version") or '1.0'
	DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF99CC33%s|r [v|cFFDF2B2B%s|r] Loaded", "LagBar", ver or "1.0"))

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

function LagBar_SlashCommand(cmd)

	local a,b,c=strfind(cmd, "(%S+)"); --contiguous string of non-space characters
	
	if a and a ~= "" then
		if c and c:lower() == "reset" then
			DEFAULT_CHAT_FRAME:AddMessage("LagBar: Frame position has been reset!");
			f:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
			return nil;
		elseif c and c:lower() == "bg" then
			LagBar:BackgroundToggle();
			return nil;
			
		elseif c and c:lower() == "worldping" then
			LagBar:WorldPingToggle();
			return nil;
			
		elseif c and c:lower() == "impdisplay" then
			LagBar:ImpDisplayToggle();
			return nil;	
		elseif c and c:lower() == "scale" then
			if b then
				local scalenum = strsub(cmd, b+2)
				if scalenum and scalenum ~= "" and tonumber(scalenum) then
					LagBar_DB.scale = tonumber(scalenum)
					f:SetScale(tonumber(scalenum))
					DEFAULT_CHAT_FRAME:AddMessage("LagBar: scale has been set to ["..tonumber(scalenum).."]")
					return true
				end
			end
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("LagBar");
	DEFAULT_CHAT_FRAME:AddMessage("To move the LagBar window, hold down SHIFT then drag to a new position.");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar reset - resets the frame position");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar bg - toggles the background on/off");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar worldping - toggles world ping display on/off");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar impdisplay - toggles improved world ping display");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar scale # - Set the scale of the LagBar frame. Use small numbers like 0.5, 0.2, 1, 1.1, 1.5, etc..")
end

function f:DrawGUI()

	f:SetWidth(30)
	f:SetHeight(25)
	f:SetMovable(true)
	f:SetClampedToScreen(true)
	
	f:SetScale(LagBar_DB.scale)
	
	if LagBar_DB.bgShown == 1 then
		f:SetBackdrop( {
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground";
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border";
			tile = true; tileSize = 32; edgeSize = 16;
			insets = { left = 5; right = 5; top = 5; bottom = 5; };
		} );
		f:SetBackdropBorderColor(0.5, 0.5, 0.5);
		f:SetBackdropColor(0.5, 0.5, 0.5, 0.6)
	else
		f:SetBackdrop(nil)
	end
	
	f:EnableMouse(true)
	
	local g = f:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
	g:SetJustifyH("LEFT")
	g:SetPoint("CENTER",0,0)
	g:SetText("")

	f:SetScript("OnMouseDown",function()
		if (IsShiftKeyDown()) then
			self.isMoving = true
			self:StartMoving();
	 	end
	end)
	f:SetScript("OnMouseUp",function()
		if( self.isMoving ) then

			self.isMoving = nil
			self:StopMovingOrSizing()

			f:SaveLayout(self:GetName());

		end
	end)

	f:SetScript("OnUpdate", function(self, arg1)
		
		if (UPDATE_INTERVAL > 0) then
			UPDATE_INTERVAL = UPDATE_INTERVAL - arg1
		else
			UPDATE_INTERVAL = MAX_INTERVAL;
			
			--thanks to comix1234 on wowinterface.com for the update.
			local framerate = floor(GetFramerate() + 0.5)
			local framerate_text = format("|cff%s%d|r fps", LagBar_GetThresholdHexColor(framerate / 60), framerate)
						
			local latencyHome = select(3, GetNetStats())
			local latency_text = format("|cff%s%d|r ms", LagBar_GetThresholdHexColor(latencyHome, 1000, 500, 250, 100, 0), latencyHome)
					
			local latencyWorld = select(4, GetNetStats())
			local latency_text_server = format("|cff%s%d|r ms", LagBar_GetThresholdHexColor(latencyWorld, 1000, 500, 250, 100, 0), latencyWorld)

			--change text according to worldping
			if LagBar_DB.worldping then
				if LagBar_DB.impdisplay then
					g:SetText(framerate_text.." | |cFF99CC33H:|r"..latency_text.." | |cFF99CC33W:|r"..latency_text_server)
				else
					g:SetText(framerate_text.." | "..latency_text.." | "..latency_text_server)
				end
			else
				g:SetText(framerate_text.." | "..latency_text)
			end
			
			--check for overlapping text (JUST IN CASE)
			if g:GetStringWidth() > f:GetWidth() then
				f:SetWidth(g:GetStringWidth() + 20)
			elseif (f:GetWidth() - g:GetStringWidth()) > 41 then
				f:SetWidth(g:GetStringWidth() + 41)
			end

		end

	end)
	
	f:Show()
end

function f:SaveLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	if not LagBar_DB then LagBar_DB = {} end
	
	local opt = LagBar_DB[frame] or nil

	if not opt then
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

function f:RestoreLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	if not LagBar_DB then LagBar_DB = {} end

	local opt = LagBar_DB[frame] or nil

	if not opt then
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

function f:BackgroundToggle()
	if not LagBar_DB then LagBar_DB = {} end
	if LagBar_DB.bgShown == nil then LagBar_DB.bgShown = 1 end
	
	if LagBar_DB.bgShown == 0 then
		LagBar_DB.bgShown = 1;
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Background Shown");
	elseif LagBar_DB.bgShown == 1 then
		LagBar_DB.bgShown = 0;
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Background Hidden");
	else
		LagBar_DB.bgShown = 1
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Background Shown");
	end

	--now change background
	if LagBar_DB.bgShown == 1 then
		f:SetBackdrop( {
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground";
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border";
			tile = true; tileSize = 32; edgeSize = 16;
			insets = { left = 5; right = 5; top = 5; bottom = 5; };
		} );
		f:SetBackdropBorderColor(0.5, 0.5, 0.5);
		f:SetBackdropColor(0.5, 0.5, 0.5, 0.6)
	else
		f:SetBackdrop(nil)
	end
	
end

function f:WorldPingToggle()
	if not LagBar_DB then LagBar_DB = {} end
	
	if not LagBar_DB.worldping then
		LagBar_DB.worldping = true
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: World ping is now displayed")
	elseif LagBar_DB.worldping then
		LagBar_DB.worldping = false
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: World ping is now hidden")
	else
		LagBar_DB.worldping = true
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: World ping is now displayed")
	end
	
end

function f:ImpDisplayToggle()
	if not LagBar_DB then LagBar_DB = {} end
	
	if not LagBar_DB.impdisplay then
		LagBar_DB.impdisplay = true
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Improved World Ping Display On")
	elseif LagBar_DB.impdisplay then
		LagBar_DB.impdisplay = false
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Improved World Ping Off")
	else
		LagBar_DB.impdisplay = true
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Improved World Ping On")
	end
	
end

if IsLoggedIn() then f:PLAYER_LOGIN() else f:RegisterEvent("PLAYER_LOGIN") end
