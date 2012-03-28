--LagBar by Xruptor
local LagBar = CreateFrame("frame", "LagBar", UIParent)

LagBar:SetScript('OnEvent', function(self, event, ...)
	if self[event] then
		self[event](self, event, ...)
	end
end)

if IsLoggedIn() then LagBar:PLAYER_LOGIN() else LagBar:RegisterEvent('PLAYER_LOGIN') end

function LagBar:PLAYER_LOGIN()
	LagBar:Enable()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

LagBar.version = GetAddOnMetadata("LagBar", "Version")
LagBar.PL_Lock = false

LagBar.LOW_LATENCY = 300
LagBar.MEDIUM_LATENCY = 600
LagBar.MAX_INTERVAL = 1
LagBar.UPDATE_INTERVAL = 0

function LagBar:Enable()

	if not LagBar_DB then
		LagBar_DB = {};
		LagBar_DB.x = 0;
		LagBar_DB.y = 0;
		LagBar_DB.locked = false;
		LagBar_DB.bgShown = true;
	end
	--lets do a toggle for world ping
	if LagBar_DB and LagBar_DB.worldping == nil then
		LagBar_DB.worldping = true
	end
	--lets do a toggle for improved display
	if LagBar_DB and LagBar_DB.impdisplay == nil then
		LagBar_DB.impdisplay = true
	end

	LagBar:DrawGUI()
	LagBar:MoveFrame()
	
	SLASH_LAGBAR1 = "/lagbar";
	SlashCmdList["LAGBAR"] = LagBar_SlashCommand;

end

function LagBar:OnEvent(event, arg1, arg2, arg3, arg4, ...)
	if event == "ADDON_LOADED" and arg1 == "LagBar" then
		LagBar:Enable();
	end
end

function LagBar_SlashCommand(cmd)
	if cmd and cmd ~= "" then
		if cmd:lower() == "reset" then
			DEFAULT_CHAT_FRAME:AddMessage("LagBar: Frame position has been reset!");
			LagBarFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
	
			return nil;
		elseif cmd:lower() == "bg" then
			LagBar:BackgroundToggle();
			return nil;
			
		elseif cmd:lower() == "worldping" then
			LagBar:WorldPingToggle();
			return nil;
			
		elseif cmd:lower() == "impdisplay" then
			LagBar:ImpDisplayToggle();
			return nil;	
		end
		
	end
	DEFAULT_CHAT_FRAME:AddMessage("LagBar");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar reset - resets the frame position");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar bg - toggles the background on/off");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar worldping - toggles world ping display on/off");
	DEFAULT_CHAT_FRAME:AddMessage("/lagbar impdisplay - toggles improved world ping display");
end

function LagBar:MoveFrame()

	if LagBar.PL_Lock then return end

	LagBar.PL_Lock = true
	
		LagBarFrame:ClearAllPoints();
		LagBarFrame:SetPoint("CENTER", UIParent, LagBar_DB.x and "BOTTOMLEFT" or "BOTTOM", LagBar_DB.x or 0, LagBar_DB.y or 221);
		LagBarFrame:Show();

	LagBar.PL_Lock = false
	
end

function LagBar:DrawGUI()
	
	--don't repeat
	if LagBarFrame then
		return
	end
	
	--frames cannot have onclick handlers

	lbFrame = CreateFrame("Frame", "LagBarFrame", UIParent, "GameTooltipTemplate");
	lbFrame:SetPoint("CENTER", UIParent, LagBar_DB.x and "BOTTOMLEFT" or "BOTTOM", LagBar_DB.x or 0, LagBar_DB.y or 221);
	lbFrame:EnableMouse(true);
	lbFrame:SetToplevel(true);
	lbFrame:SetMovable(true);
	lbFrame:SetFrameStrata("LOW");
	lbFrame:SetHeight(25);

	--set to a small size to update size automaticall on first FPS grab
	LagBarFrame:SetWidth(30)
	
	if LagBar_DB.bgShown then
		local backdrop_header = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile=1, tileSize=16, edgeSize = 16,
				insets = {left = 5, right = 5, top = 5, bottom = 5}};

		lbFrame:SetBackdrop(backdrop_header);
		lbFrame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
		lbFrame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
	else
		lbFrame:SetBackdrop(nil);
	end
		
	lbFrame:RegisterForDrag("LeftButton")
	lbFrame.text = lbFrame:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall");
	lbFrame.text:SetPoint("CENTER", lbFrame, "CENTER", 0, 0);
	lbFrame.text:Show();

		
	lbFrame:SetScript("OnUpdate", function(self, arg1)
		
		if (LagBar.UPDATE_INTERVAL > 0) then
			LagBar.UPDATE_INTERVAL = LagBar.UPDATE_INTERVAL - arg1;
		else
			LagBar.UPDATE_INTERVAL = LagBar.MAX_INTERVAL;
			
			--local bandwidthIn, bandwidthOut, latency = GetNetStats();
			--if (latency > LagBar_MEDIUM_LATENCY) then
			--	LagBar_Text:SetTextColor(1, 0, 0);									
			--elseif (latency > LagBar_LOW_LATENCY) then
			--	LagBar_Text:SetTextColor(1, 1, 0);
			--else
			--	LagBar_Text:SetTextColor(0, 1, 0);
			--end
			--if (latency > 9999) then
			--	LagBar_Text:SetText("Ping: HIGH");
			--else
			--	LagBar_Text:SetText("Ping: "..latency.." ms");
			--end

			--ORIGINAL CODE
			-- local framerate = floor(GetFramerate() + 0.5)
			-- local framerate_text = format("|cff%s%d|r fps", LagBar_GetThresholdHexColor(framerate / 60), framerate)
			
			-- local latency = select(3, GetNetStats())
			-- local latency_text = format("|cff%s%d|r ms", LagBar_GetThresholdHexColor(latency, 1000, 500, 250, 100, 0), latency)
			
			-- LagBarFrameText:SetText(framerate_text.." | "..latency_text);
			
			
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
					LagBarFrameText:SetText(framerate_text.." | |cFF99CC33H:|r"..latency_text.." | |cFF99CC33W:|r"..latency_text_server)
				else
					LagBarFrameText:SetText(framerate_text.." | "..latency_text.." | "..latency_text_server)
				end
			else
				LagBarFrameText:SetText(framerate_text.." | "..latency_text)
			end
			
			--check for overlapping text (JUST IN CASE)
			if LagBarFrameText:GetStringWidth() > LagBarFrame:GetWidth() then
				LagBarFrame:SetWidth(LagBarFrameText:GetStringWidth() + 20)
			elseif (LagBarFrame:GetWidth() - LagBarFrameText:GetStringWidth()) > 41 then
				LagBarFrame:SetWidth(LagBarFrameText:GetStringWidth() + 41)
			end

		end

	end)

	lbFrame:SetScript("OnMouseDown", function(frame, button) 
		
		if not LagBar_DB.locked and button ~= "RightButton" then
			frame.isMoving = true
			frame:StartMoving();
		end
		
	end)

	lbFrame:SetScript("OnMouseUp", function(frame, button) 

		if not LagBar_DB.locked and button ~= "RightButton" then
			if( frame.isMoving ) then

				frame.isMoving = nil
				frame:StopMovingOrSizing()

				LagBar_DB.x, LagBar_DB.y = frame:GetCenter()
			end
		
		elseif button == "RightButton" then
		
			if LagBar_DB.locked then
				LagBar_DB.locked = false
				DEFAULT_CHAT_FRAME:AddMessage("LagBar: Unlocked");
			else
				LagBar_DB.locked = true
				DEFAULT_CHAT_FRAME:AddMessage("LagBar: Locked");
			end
		end

	end)

end

function LagBar:BackgroundToggle()

	if not LagBar_DB.bgShown then
		LagBar_DB.bgShown = true;
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Background Shown");
	elseif LagBar_DB.bgShown then
		LagBar_DB.bgShown = false;
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Background Hidden");
	else
		LagBar_DB.bgShown = true;
		DEFAULT_CHAT_FRAME:AddMessage("LagBar: Background Shown");
	end

	--now change background
	if LagBar_DB.bgShown and LagBarFrame then
		local backdrop_header = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile=1, tileSize=16, edgeSize = 16,
				insets = {left = 5, right = 5, top = 5, bottom = 5}};


		LagBarFrame:SetBackdrop(backdrop_header);
		LagBarFrame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
		LagBarFrame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
		
	elseif LagBarFrame then
		LagBarFrame:SetBackdrop(nil)
	end
	
end

function LagBar:WorldPingToggle()

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

function LagBar:ImpDisplayToggle()

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

function LagBar_GetThresholdHexColor(quality, ...)
	local r, g, b = LagBar_GetThresholdColor(quality, ...)
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

function LagBar_GetThresholdColor(quality, ...)

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

function LagBar_GetThresholdPercentage(quality, ...)
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

