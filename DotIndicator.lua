
DotIndicator.lua = {};
DotIndicator.lua.fully_loaded = false;
DotIndicator.lua.default_options = {

	-- main frame position
	frameRef = "CENTER",
	frameX = 0,
	frameY = 0,
	hide = false,

	-- sizing
	frameW = 200,
	frameH = 200,
};


function DotIndicator.lua.OnReady()

	-- set up default options
	_G.DotIndicator.luaPrefs = _G.DotIndicator.luaPrefs or {};

	for k,v in pairs(DotIndicator.lua.default_options) do
		if (not _G.DotIndicator.luaPrefs[k]) then
			_G.DotIndicator.luaPrefs[k] = v;
		end
	end

	DotIndicator.lua.CreateUIFrame();
end

function DotIndicator.lua.OnSaving()

	if (DotIndicator.lua.UIFrame) then
		local point, relativeTo, relativePoint, xOfs, yOfs = DotIndicator.lua.UIFrame:GetPoint()
		_G.DotIndicator.luaPrefs.frameRef = relativePoint;
		_G.DotIndicator.luaPrefs.frameX = xOfs;
		_G.DotIndicator.luaPrefs.frameY = yOfs;
	end
end

function DotIndicator.lua.OnUpdate()
	if (not DotIndicator.lua.fully_loaded) then
		return;
	end

	if (DotIndicator.luaPrefs.hide) then 
		return;
	end

	DotIndicator.lua.UpdateFrame();
end

function DotIndicator.lua.OnEvent(frame, event, ...)

	if (event == 'ADDON_LOADED') then
		local name = ...;
		if name == 'DotIndicator.lua' then
			DotIndicator.lua.OnReady();
		end
		return;
	end
end

function DotIndicator.lua.CreateUIFrame()

	-- create the UI frame
	DotIndicator.lua.UIFrame = CreateFrame("Frame",nil,UIParent);
	DotIndicator.lua.UIFrame:SetFrameStrata("BACKGROUND")
	DotIndicator.lua.UIFrame:SetWidth(_G.DotIndicator.luaPrefs.frameW);
	DotIndicator.lua.UIFrame:SetHeight(_G.DotIndicator.luaPrefs.frameH);
end

function DotIndicator.lua.SetFontSize(string, size)

	local Font, Height, Flags = string:GetFont()
	if (not (Height == size)) then
		string:SetFont(Font, size, Flags)
	end
end

function DotIndicator.lua.OnDragStart(frame)
	DotIndicator.lua.UIFrame:StartMoving();
	DotIndicator.lua.UIFrame.isMoving = true;
	GameTooltip:Hide()
end

function DotIndicator.lua.OnDragStop(frame)
	DotIndicator.lua.UIFrame:StopMovingOrSizing();
	DotIndicator.lua.UIFrame.isMoving = false;
end

function DotIndicator.lua.OnClick(self, aButton)
	-- on click behvior
end

function DotIndicator.lua.UpdateFrame()

	-- update the main frame state here
	DotIndicator.lua.Label:SetText(string.format("%d", GetTime()));

    zoneAbilities = C_ZoneAbility.GetActiveAbilities();
    for abilityIdx, ability in ipairs(zoneAbilites) do
        print( ability );
    end
end


DotIndicator.lua.EventFrame = CreateFrame("Frame");
DotIndicator.lua.EventFrame:Show();
DotIndicator.lua.EventFrame:SetScript("OnEvent", DotIndicator.lua.OnEvent);
DotIndicator.lua.EventFrame:SetScript("OnUpdate", DotIndicator.lua.OnUpdate);
DotIndicator.lua.EventFrame:RegisterEvent("ADDON_LOADED");