local L = AceLibrary("AceLocale-2.2"):new("sRaidFrames")
local BS = AceLibrary("Babble-Spell-2.2")
local Compost = AceLibrary("Compost-2.0")
local Banzai = AceLibrary("Banzai-1.0")

--local proximity = ProximityLib:GetInstance("1")
local surface = AceLibrary("Surface-1.0") 
local roster = AceLibrary("RosterLib-2.0")

surface:Register("Otravi", "Interface\\AddOns\\sRaidFrames\\textures\\otravi")
surface:Register("Smooth", "Interface\\AddOns\\sRaidFrames\\textures\\smooth")
surface:Register("Striped", "Interface\\AddOns\\sRaidFrames\\textures\\striped")
surface:Register("BantoBar", "Interface\\AddOns\\sRaidFrames\\textures\\bantobar")

surface:Register("Grid", "Interface\\AddOns\\sRaidFrames\\textures\\Grid")
surface:Register("Bumps", "Interface\\AddOns\\sRaidFrames\\textures\\Bumps")
surface:Register("Button", "Interface\\AddOns\\sRaidFrames\\textures\\Button")
surface:Register("Cloud", "Interface\\AddOns\\sRaidFrames\\textures\\Cloud")
surface:Register("DarkBottom", "Interface\\AddOns\\sRaidFrames\\textures\\DarkBottom")
surface:Register("Diagonal", "Interface\\AddOns\\sRaidFrames\\textures\\Diagonal")
surface:Register("Fifths", "Interface\\AddOns\\sRaidFrames\\textures\\Fifths")
surface:Register("Fourths", "Interface\\AddOns\\sRaidFrames\\textures\\Fourths")
surface:Register("Gloss", "Interface\\AddOns\\sRaidFrames\\textures\\Gloss")
surface:Register("Hatched", "Interface\\AddOns\\sRaidFrames\\textures\\Hatched")
surface:Register("Paint", "Interface\\AddOns\\sRaidFrames\\textures\\Paint")
surface:Register("Skewed", "Interface\\AddOns\\sRaidFrames\\textures\\Skewed")
surface:Register("Water", "Interface\\AddOns\\sRaidFrames\\textures\\Water")
surface:Register("Charcoal", "Interface\\AddOns\\sRaidFrames\\textures\\Charcoal")
surface:Register("Glaze", "Interface\\AddOns\\sRaidFrames\\textures\\glaze")
surface:Register("Metal", "Interface\\AddOns\\sRaidFrames\\textures\\BEB-BarFill-Metal")
surface:Register("Wood", "Interface\\AddOns\\sRaidFrames\\textures\\BEB-BarFill-Wood")
surface:Register("Gradient", "Interface\\AddOns\\sRaidFrames\\textures\\gradient32x32")
surface:Register("Aluminium", "Interface\\AddOns\\sRaidFrames\\textures\\Aluminium")
surface:Register("Rupture", "Interface\\AddOns\\sRaidFrames\\textures\\Rupture")
surface:Register("Highlight", "Interface\\AddOns\\sRaidFrames\\textures\\debuffHighlight")
surface:Register("TukuiBar", "Interface\\AddOns\\sRaidFrames\\textures\\tukuibar")
surface:Register("LiteStepLite", "Interface\\AddOns\\sRaidFrames\\textures\\LiteStepLite")
surface:Register("Blur", "Interface\\AddOns\\sRaidFrames\\textures\\bar1.tga")
surface:Register("VuhDo", "Interface\\AddOns\\sRaidFrames\\textures\\bar3.tga")
surface:Register("Club", "Interface\\AddOns\\sRaidFrames\\textures\\bar5.tga")
surface:Register("Force", "Interface\\AddOns\\sRaidFrames\\textures\\bar8.tga")
surface:Register("CoffeShop", "Interface\\AddOns\\sRaidFrames\\textures\\bar13.tga")
surface:Register("Toxic", "Interface\\AddOns\\sRaidFrames\\textures\\bar14.tga")
surface:Register("HiContrast", "Interface\\AddOns\\sRaidFrames\\textures\\bar15.tga")
surface:Register("Flat", "Interface\\AddOns\\sRaidFrames\\textures\\bar17.tga")
surface:Register("Tube", "Interface\\AddOns\\sRaidFrames\\textures\\Tube.tga")
surface:Register("Stoned", "Interface\\AddOns\\sRaidFrames\\textures\\metal.tga")
surface:Register("Minimalist", "Interface\\AddOns\\sRaidFrames\\textures\\Minimalist.tga")
surface:Register("Glow", "Interface\\AddOns\\sRaidFrames\\textures\\glowTex.tga")
surface:Register("Ray", "Interface\\AddOns\\sRaidFrames\\textures\\highlightTex.tga")
surface:Register("Neal", "Interface\\AddOns\\sRaidFrames\\textures\\Neal.blp")
surface:Register("Smelly", "Interface\\AddOns\\sRaidFrames\\textures\\Smelly.tga")
surface:Register("Ruben", "Interface\\AddOns\\sRaidFrames\\textures\\Ruben.tga")
surface:Register("RenaitreMinion", "Interface\\AddOns\\sRaidFrames\\textures\\RenaitreMinion.tga")
surface:Register("Progressbar", "Interface\\AddOns\\sRaidFrames\\textures\\progressbar.tga")
surface:Register("Orient", "Interface\\AddOns\\sRaidFrames\\textures\\Orient.tga")
surface:Register("Ghost", "Interface\\AddOns\\sRaidFrames\\textures\\Ghost.tga")
surface:Register("Lap", "Interface\\AddOns\\sRaidFrames\\textures\\Lap.tga")

local math_mod = math.fmod or math.mod 

sRaidFrames = AceLibrary("AceAddon-2.0"):new(
	"AceDB-2.0",
	"AceEvent-2.0",
	"AceConsole-2.0",
	"FuBarPlugin-2.0",
	"AceModuleCore-2.0",
	"AceHook-2.0"
)

-- Look I'm a fubar plugin!!
sRaidFrames.hasIcon = "Interface\\Icons\\INV_Helmet_06"
sRaidFrames.defaultMinimapPosition = 180
sRaidFrames.cannotDetachTooltip = true
sRaidFrames.hasNoColor = true
sRaidFrames.clickableTooltip = false
sRaidFrames.hideWithoutStandby = true
sRaidFrames.independentProfile = true
sRaidFrames.TargetMonitor = nil
sRaidFrames.TargetMonitorEnd = nil

sRaidFrames.FocusWithRange = false
sRaidFrames.ClassCheck = false
sRaidFrames.SpellCheck = false
sRaidFrames.MenuOpen = false
sRaidFrames.MapEnable = false

sRaidFrames.JoiningWorld = 0
sRaidFrames.NextScan = 0
sRaidFrames.MapScale = 0


sRaidFrames.ClassSpellArray = {Paladin = "Holy Light", Priest = "Flash Heal", Druid = "Healing Touch", Shaman = "Healing Wave"}


function sRaidFrames:OnInitialize()

	self:RegisterDB("sRaidFramesDB")
	self:Variables()
	
	sRaidFrames.UnitRangeFocus = Compost and Compost:Acquire() or {}
	sRaidFrames.ExtendedRangeScan = Compost and Compost:Acquire() or {}

	self:RegisterDefaults("profile", {
		lock				= false,
		SortBy				= "fixed",
		healthDisplayType	= 'percent',
		Invert = false,
		Scale				= 0.8,
		Width				= 82,
		ScaleFocus 			= 1.3,
		WidthFocus 			= 85,
		Border				= true,
		Texture				= "Gradient",
		BuffType			= "debuffs",
		ShowOnlyDispellable	= 1,
		BackgroundColor		= {r = 0.3, g = 0.3, b = 0.3, a = 0.7},
		BorderColor			= {r = 1, g = 1, b = 1, a = 1},
		Growth				= "down",
		Spacing				= 0,
		ShowGroupTitles		= true,
		SubSort				= "class",
		TooltipMethod		= "notincombat",
		ClassFilter			= {["WARRIOR"] = true, ["PALADIN"] = true, ["SHAMAN"] = true, ["HUNTER"] = true, ["WARLOCK"] = true, ["MAGE"] = true, ["DRUID"] = true, ["ROGUE"] = true, ["PRIEST"] = true},
		GroupFilter			= {true, true, true, true, true, true, true, true},
		BuffFilter			= {},
		PowerFilter			= {[0] = true,[1] = true,[2] = true,[3] = true},
		aggro				= false,
		RangeCheck 			= false,
		ExtendedRangeCheck = false,
		ExtendedRangeCheckCombat = true,
		fixed_count			= 5,
		RangeFrequency 		= 0.25,
		RangeAlpha 			= 0.2,
		srfhideparty		= true,
		lock_focus			= false,
		ShowGroupTitles_Focus = true,
		dead_sort 			= true,
		fill_range		    = false,
		hp_limit 			= 100,
		units_limit 		= 10,
		Growth_Focus 		= "down",
		show_txt_buff		= true,
		targeting 			= true,
	})

	self:RegisterChatCommand({"/srf", "/sraidframes"}, self.options)

	self.opt = self.db.profile

	self.OnMenuRequest = self.options

	self.master = CreateFrame("Frame", "sRaidFrame", UIParent)
	self.master:SetMovable(true)
	self.master:SetScale(self.opt.Scale)

	self.master:SetHeight(200);
	self.master:SetWidth(200);

	self.tooltip = CreateFrame("GameTooltip", "sRaidFramesTooltip", WorldFrame, "GameTooltipTemplate")
	self.tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	--self.tooltip:SetOwner(WorldFrame, "ANCHOR_TOPRIGHT", 0,0);

	self.master:Hide()
	
	--self:LoadProfile()

	for i = 1, MAX_RAID_MEMBERS do
		self:CreateUnitFrame(i)
	end

	for i = 1, 9 do
		self:CreateGroupFrame(i)
	end
	
	for i = 1, MAX_RAID_MEMBERS do
		self.UnitSortOrder[i] = 0
	end
	

	if WatchDog_OnClick then
		sRaidFramesCustomOnClickFunction = WatchDog_OnClick
	elseif JC_OnClick then
		sRaidFramesCustomOnClickFunction = JC_OnClick
	elseif CT_RA_CustomOnClickFunction then
		sRaidFramesCustomOnClickFunction = CT_RA_CustomOnClickFunction
	end
	
	--==Added by Ogrisch 
	self:Hook("TargetFrame_OnEvent")

	
	Zorlen_MakeFirstMacros = nil
	DEFAULT_CHAT_FRAME:AddMessage("_SRaidFrames Improved by ".."|cff9900FF".."Ogrisch".."|cffffffff".. " loaded")
end

function sRaidFrames:OnProfileEnable()
	self.opt = self.db.profile
end

function sRaidFrames:OnEnable()
	self:SetPosition()
	
	self:chatUpdateBuffMenu()

	self:RegisterBucketEvent("RAID_ROSTER_UPDATE", 0.1, "UpdateRoster")
	self:RegisterBucketEvent("PLAYER_ENTERING_WORLD",1.5)
	self:RegisterBucketEvent("PARTY_MEMBERS_CHANGED", 0.01, "UpdateParty");

	self:UpdateRoster()
	
	if LunaUnitFrames then
		Luna_Target_Original = LunaUnitFrames.UpdateTargetFrame
		LunaUnitFrames.UpdateTargetFrame = Luna_Target_Hook
	end
end

function sRaidFrames:TargetFrame_OnEvent(event)
	--DEFAULT_CHAT_FRAME:AddMessage("sRaidFrames:TargetFrame_OnEvent")
	if not self.TargetMonitor then
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFrames:TargetFrame_OnEvent")
		self.hooks.TargetFrame_OnEvent.orig(event)
	end	
end

function Luna_Target_Hook()
	if not sRaidFrames.TargetMonitor then
		Luna_Target_Original()
	end	
end

function sRaidFrames:OnDisable()
	self.master:Hide()
end


function sRaidFrames:JoinedRaid()
	--self:Print("Joined a raid, enabling raid frames")
	self.enabled = true

	self:RegisterBucketEvent("UNIT_HEALTH", 0.2, "UpdateUnit")
	self:RegisterBucketEvent("UNIT_AURA", 0.2, "UpdateBuffs")
	
	self:RegisterBucketEvent("ZONE_CHANGED_NEW_AREA", 1, "ZoneCheck")
	self:RegisterBucketEvent("PLAYER_UNGHOST", 1, "ZoneCheck")
		
	self:RegisterBucketEvent("PLAYER_REGEN_ENABLED", 2, "ResetHealIndicators")
	self:RegisterBucketEvent("PLAYER_REGEN_DISABLED", 2, "ResetHealIndicators")
	self:RegisterBucketEvent("PLAYER_DEAD", 2, "ResetHealIndicators")

	--self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterBucketEvent("PLAYER_TARGET_CHANGED", 0.01)

	self:RegisterEvent("Banzai_UnitGainedAggro")
	self:RegisterEvent("Banzai_UnitLostAggro")
	
	self:RegisterEvent("oRA_PlayerCanResurrect")
	self:RegisterEvent("oRA_PlayerResurrected")
	self:RegisterEvent("oRA_PlayerNotResurrected")

	-- TODO: only updateunit
	self:ScheduleRepeatingEvent("sRaidFramesSort_Force", self.Sort_Force, 0.5, self)
	self:ScheduleRepeatingEvent("sRaidFramesRangeCheck", self.RangeCheck, self.opt.RangeFrequency, self)
	
	
	self:ScheduleRepeatingEvent("sRaidFramesUpdateAll", self.UpdateAll, 1, self)
	

	self:UpdateRoster()
	self:UpdateAll()

	self.master:Show()
	self:ZoneCheck()
	self:UpdateParty()
	
end

function sRaidFrames:UpdateParty()
	if self.opt.srfhideparty and UnitInRaid("player") then
		HidePartyFrame();
	end
end

function sRaidFrames:PLAYER_ENTERING_WORLD()
	self.JoiningWorld = GetTime()
	if not self.enabled and UnitInRaid("player") then
		self:JoinedRaid();
	end
end

function sRaidFrames:PLAYER_TARGET_CHANGED()
	if self.TargetMonitor and self.TargetMonitorEnd then
		self.TargetMonitorEnd = nil
		self.TargetMonitor = nil
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFrames:PLAYER_TARGET_CHANGED")
	end
	
end

function sRaidFrames:LeftRaid()
	--self:Print("Left raid, disabling raid frames")
	self.visible = {}
	self.enabled = false

	self:UnregisterBucketEvent("UNIT_HEALTH")
	self:UnregisterBucketEvent("UNIT_AURA")

	self:UnregisterEvent("Banzai_UnitGainedAggro")
	self:UnregisterEvent("Banzai_UnitLostAggro")
	
	self:UnregisterEvent("oRA_PlayerCanResurrect")
	self:UnregisterEvent("oRA_PlayerResurrected")
	self:UnregisterEvent("oRA_PlayerNotResurrected")

	self:CancelScheduledEvent("sRaidFramesUpdateAll")
	self:CancelScheduledEvent("sRaidFramesRangeCheck")

	for id = 1, MAX_RAID_MEMBERS do
		self.frames["raid" ..id]:Hide()
	end

	self.master:Hide()
end

function sRaidFrames:UpdateAll()
	self:UpdateUnit(self.visible)
	self:UpdateBuffs(self.visible)
end

function sRaidFrames:Variables()
	self.enabled = false
	self.frames, self.visible, self.groupframes = {}, {}, {}
	self.feign, self.unavail, self.res = {}, {}, {}
	
	self.UnitSortOrder = {}
	self.UnitFocusHPArray = {}
	self.UnitFocusArray = {}
	self.UnitRangeArray = {}
	self.indicator = {}
	self.debuff = {}
	self.targeting = {}

	self.debuffColors = {}
	self.debuffColors["Curse"]    = { ["r"] = 1, ["g"] = 0, ["b"] = 0.75, ["a"] = 0.5, ["priority"] = 4 }
	self.debuffColors["Magic"]    = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 0.5, ["priority"] = 3 }
	self.debuffColors["Disease"]  = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 0.5, ["priority"] = 2 }
	self.debuffColors["Poison"]   = { ["r"] = 0, ["g"] = 0.5, ["b"] = 0, ["a"] = 0.5, ["priority"] = 1 }	
	self.debuffColors["Blue"]    = { ["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1, ["priority"] = 4 }
	self.debuffColors["Red"]    = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1, ["priority"] = 4 }

	self.RAID_CLASS_COLORS = {
	  ["HUNTER"] = { r = 0.67, g = 0.83, b = 0.45, colorStr = "|cffabd473" },
	  ["WARLOCK"] = { r = 0.58, g = 0.51, b = 0.79, colorStr = "|cff9482c9" },
	  ["PRIEST"] = { r = 1.0, g = 1.0, b = 1.0, colorStr = "|cffffffff" },
	  ["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73, colorStr = "|cfff58cba" },
	  ["MAGE"] = { r = 0.41, g = 0.8, b = 0.94, colorStr = "|cff69ccf0" },
	  ["ROGUE"] = { r = 1.0, g = 0.96, b = 0.41, colorStr = "|cfffff569" },
	  ["DRUID"] = { r = 1.0, g = 0.49, b = 0.04, colorStr = "|cffff7d0a" },
	  ["SHAMAN"] = { r = 0.0, g = 0.44, b = 0.87, colorStr = "|cff0070de" },
	  ["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43, colorStr = "|cffc79c6e" },
	};
	
	self.cooldownSpells = {}
	self.cooldownSpells["WARLOCK"] = BS["Soulstone Resurrection"]
	self.cooldownSpells["DRUID"] = BS["Rebirth"]
	self.cooldownSpells["SHAMAN"] = BS["Reincarnation"]

	self.ManaBarColor = ManaBarColor

	-- Nurfed mana color, where is the love :(
	--self.ManaBarColor[0] = { r = 0.00, g = 1.00, b = 1.00, prefix = TEXT(MANA) };
end

function sRaidFrames:UpdateRoster()
	local num = GetNumRaidMembers()

	if num == 0 then
		if self.enabled then
			self:LeftRaid()
		end
		return
	end

	if not self.enabled then
		self:JoinedRaid()
	end
	
	self:ResetHealIndicators()
	self:UpdateVisibility()
	self:LoadStyle()
end

function sRaidFrames:QueryVisibility(id)
	local unitid = "raid" .. id
	if not UnitName(unitid) then
		return false
	end

	local _, eClass = UnitClass(unitid)
	if eClass and self.opt.ClassFilter and not self.opt.ClassFilter[eClass] then
		return false
	end

	local _, _, subgroup = GetRaidRosterInfo(id)
	if subgroup and not self.opt.GroupFilter[subgroup] then
		return false
	end

	return true
end

function sRaidFrames:UpdateVisibility()
	for id = 1, MAX_RAID_MEMBERS do
		if self:QueryVisibility(id) then
			if not self.visible["raid" .. id] then
				self.frames["raid" .. id]:Show()
				self.visible["raid" .. id] = true;
			end
		else
			if self.visible["raid" .. id] then
				self.frames["raid" .. id]:Hide()
				self.visible["raid" .. id] = nil;
			end
		end
	end

	self:Sort();
end

function sRaidFrames:Banzai_UnitGainedAggro(unit, unitTable)
	--self.UnitAggro[unit] = true
	if self.opt.dynamic_aggro_sort then
		sRaidFrames:Sort_Force()
	end
	
	
	if not unit or not self.visible[unit] or not self.opt.aggro then return end
	self.frames[unit]:SetBackdropBorderColor(1, 0, 0, self.opt.BorderColor.a)
end

function sRaidFrames:Banzai_UnitLostAggro(unit)
	--self.UnitAggro[unit] = nil
	if self.opt.dynamic_aggro_sort then
		sRaidFrames:Sort_Force()
		local units = {}
		units[unit] = true
		self:UpdateUnit(units)
	end	

	if not unit or not self.visible[unit] or not self.opt.aggro then return end
	self.frames[unit]:SetBackdropBorderColor(self.opt.BorderColor.r, self.opt.BorderColor.g, self.opt.BorderColor.b, self.opt.BorderColor.a)
end

function sRaidFrames:oRA_PlayerCanResurrect(msg, author)
	local unit = roster:GetUnitIDFromName(author)
	--self:Print("oRA_PlayerCanResurrect", UnitIsDead(unit), UnitIsGhost(unit), self.unavail[unit], msg, author, unit)
	if unit then self.res[unit] = 1 end
end

function sRaidFrames:oRA_PlayerResurrected(msg, author)
	local unit = roster:GetUnitIDFromName(author)
	--self:Print("oRA_PlayerResurrected", UnitIsDead(unit), UnitIsGhost(unit), self.unavail[unit], msg, author, unit)
	if unit then self.res[unit] = 2 end
end

function sRaidFrames:oRA_PlayerNotResurrected(msg, author)
	local unit = roster:GetUnitIDFromName(author)
	--self:Print("oRA_PlayerNotResurrected", UnitIsDead(unit), UnitIsGhost(unit), self.unavail[unit], msg, author, unit)
	if unit then self.res[unit] = nil end
end

function sRaidFrames:IsSpellInRangeAndActionBar(SpellName)
	if SpellName then
		local SpellButton = Zorlen_Button[SpellName..".Any"]
		if SpellButton then
			if(IsActionInRange(SpellButton) == 1) then	
				return true
			else 
				return false
			end
		else
			if self.JoiningWorld > 0 and (GetTime() - self.JoiningWorld > 5) then
				UIErrorsFrame:AddMessage("|cff00eeee sRaidFrames: |cff00FF00"..SpellName.." - not on Actionbar")
			end	
			return false
		end
	end
	return false
end

function sRaidFrames:Freqcalc(num)
	local val1 = (0.064*num + 0.936)
	local val2 = val1/num
	--DEFAULT_CHAT_FRAME:AddMessage(num.." - "..val1.." - "..val2)
	return val2, val1
end

function sRaidFrames:ExtendedRangeArrayUtilize(modez, unit)
	local counter = 0
	if modez == "add" then
		self.ExtendedRangeScan[unit] = true
		
	elseif modez == "remove" then
		self.ExtendedRangeScan[unit] = nil
	
	elseif modez == "ret" then
		for blockindex,blockmatch in pairs(self.ExtendedRangeScan) do
			return blockindex
		end
		return nil

	elseif modez == "reset" then
		for blockindex,blockmatch in pairs(self.ExtendedRangeScan) do
			self.ExtendedRangeScan[blockindex] = nil
		end
	
	elseif modez == "calc" then
		for blockindex,blockmatch in pairs(self.ExtendedRangeScan) do
			counter = counter + 1
		end
		return counter
	end
end

function sRaidFrames:RangeCheck()
	local now = GetTime()
	local moving = Zorlen_isMoving()
	local _px, _py = GetPlayerMapPosition("player")

	if _px > 0 and _py > 0 and not self.MapEnable then
		self.MapEnable = true
		self:Debug("RC_MAP_ENABLE")
	end
	if not self.opt.RangeCheck and not self.opt.ExtendedRangeCheck and not self.opt.ExtendedRangeCheckCombat then 
		return 
	end	
	--DEFAULT_CHAT_FRAME:AddMessage("|cff00eeeeDebug: |cffffffffRange Check")
	if not self.ClassCheck then 
		self.ClassCheck = UnitClass("player") 
		self.SpellCheck = self.ClassSpellArray[self.ClassCheck]
	end
	
	--if not UnitIsDeadOrGhost("player") and table.getn(self.ExtendedRangeScan) == 0 then --now > self.NextScan or and (self.MapEnable and self.MapScale == 0 or not self.MapEnable)
	if not UnitIsDeadOrGhost("player") and self:ExtendedRangeArrayUtilize("calc") == 0 then --now > self.NextScan or and (self.MapEnable and self.MapScale == 0 or not self.MapEnable)
		self:CancelScheduledEvent("sRaidFramesExtendedRangeCheck")
		
		--self.ExtendedRangeScan = {} 
		--self.ExtendedRangeScan = Compost and Compost:Acquire() or {}
		self:ExtendedRangeArrayUtilize("reset")

		local counter = 1		
		for unit in pairs(self.visible) do	
		 
			local unitcheck = UnitExists(unit) and UnitIsVisible(unit) and UnitIsConnected(unit) and not UnitIsGhost(unit)
			local deadcheck = UnitIsDead(unit)
			if unitcheck and UnitIsUnit("player", unit) then
				--self.frames[unit]:SetAlpha(1)
				self.UnitRangeArray[unit] = " 11Y"
			elseif unitcheck and CheckInteractDistance(unit, 4) then
				--self.frames[unit]:SetAlpha(1)
				self.UnitRangeArray[unit] = " 28Y"
				if self.MapEnable and (self.opt.RangeCheck or self.opt.ExtendedRangeCheckCombat and not UnitAffectingCombat("player")) then
					local _tx, _ty = GetPlayerMapPosition(unit)
					local dist = sqrt((_px - _tx)^2 + (_py - _ty)^2)*1000
					if _tx > 0 and _ty > 0 then
						if (dist/11.11) > self.MapScale and CheckInteractDistance(unit, 2) then
							self.UnitRangeArray[unit] = " 11Y"
							local adjust = dist/11.11
							self:Debug("RC_INC "..GetUnitName(unit).."_11Y - "..math.floor(adjust/self.MapScale*100).."% "..adjust)
							self.MapScale = adjust
						elseif (dist/28) > self.MapScale then
							local adjust = dist/28
							self:Debug("RC_INC "..GetUnitName(unit).."_28Y - "..math.floor(adjust/self.MapScale*100).."% "..adjust)
							self.MapScale = adjust
						end
					end	
				end
			elseif unitcheck and self.MapEnable and (self.opt.RangeCheck or self.opt.ExtendedRangeCheckCombat and not UnitAffectingCombat("player")) and not deadcheck then
				local _tx, _ty = GetPlayerMapPosition(unit)
				local dist = sqrt((_px - _tx)^2 + (_py - _ty)^2)*1000
				if _tx > 0 and _ty > 0 and self:VerifyUnitRange(unit, dist) then
					--self.frames[unit]:SetAlpha(1)
					self.UnitRangeArray[unit] = " 40Y*"
				else
					self.UnitRangeArray[unit] = ""
					--self.frames[unit]:SetAlpha(self.opt.RangeAlpha)
				end
			elseif unitcheck and self.SpellCheck and (self.opt.ExtendedRangeCheck or self.opt.ExtendedRangeCheckCombat and UnitAffectingCombat("player")) and not deadcheck then
				--self.ExtendedRangeScan[counter] = unit
				self:ExtendedRangeArrayUtilize("add", unit)
				counter = counter + 1
				
			else
				self.UnitRangeArray[unit] = ""
				--self.frames[unit]:SetAlpha(self.opt.RangeAlpha)
			end
		end	
		if counter > 1 then 
			local status = "INACTIVE"
			if (not self.MenuOpen or self.MenuOpen < GetTime()) and not (InspectFrame and InspectFrame:IsVisible() or LootFrame and LootFrame:IsVisible() or XLootFrame and XLootFrame:IsVisible() or TradeFrame and TradeFrame:IsVisible()) then 
				status = "ACTIVE" 
			end
			
			local table_val = self:ExtendedRangeArrayUtilize("calc")
			local step, freq = self:Freqcalc(table_val)
			self:Debug("RC_TOTAL: "..table_val.." - CYCLE FREQ: "..((math.floor(freq *100))/100).."s - STATUS: "..status)
			self:ScheduleRepeatingEvent("sRaidFramesExtendedRangeCheck", self.ExtendedRangeCheck, step , self)	
		end
	end
end

function sRaidFrames:ExtendedRangeCheck()
	local now = GetTime()
	local j = self:ExtendedRangeArrayUtilize("ret")
	
	if not (self.opt.ExtendedRangeCheck or self.opt.ExtendedRangeCheckCombat and UnitAffectingCombat("player")) or not UnitExists(j) or self.MenuOpen and self.MenuOpen > now or (InspectFrame and InspectFrame:IsVisible() or XLootFrame and XLootFrame:IsVisible() or LootFrame and LootFrame:IsVisible() or TradeFrame and TradeFrame:IsVisible()) or Zorlen_isEnemy("target") and isShootActive() then	
		self:CancelScheduledEvent("sRaidFramesExtendedRangeCheck")
		--Compost:Reclaim(self.ExtendedRangeScan)
		self:ExtendedRangeArrayUtilize("reset")
		return 
	end

	if j then
		local jumpnext = true
		local targetchanged = nil

		if not UnitExists("target") or UnitExists("target") and not UnitIsUnit("target", j) then
			self.TargetMonitor = true
			targetchanged = true
			--DEFAULT_CHAT_FRAME:AddMessage("TargetUnit")
			TargetUnit(j)
			
		end
		if self:IsSpellInRangeAndActionBar(self.SpellCheck) then
			--self.frames[j]:SetAlpha(1)
			if self.MapEnable and (self.opt.RangeCheck or self.opt.ExtendedRangeCheckCombat and not UnitAffectingCombat("player")) then self.UnitRangeArray[j] = " 40Y*" else self.UnitRangeArray[j] = " 40Y"	end
			self:Debug("RC "..GetUnitName(j).."_40y - " .."|cff00FF00 PASS")
			jumpnext = nil
		end
		if targetchanged then 
			self.TargetMonitorEnd = true
			--DEFAULT_CHAT_FRAME:AddMessage("TargetLastTarget")
			TargetLastTarget()
			
		end
		if jumpnext then
			--self.frames[j]:SetAlpha(self.opt.RangeAlpha)
			self.UnitRangeArray[j] = ""
			self:Debug("RC "..GetUnitName(j).."_40y - " .."|cffFF0000 NOT PASS")
		end
		--self.ExtendedRangeScan[i] = nil
		self:ExtendedRangeArrayUtilize("remove", j)
	end
end

function sRaidFrames:VerifyUnitRange(unit, dist)
	if UnitExists("target") and UnitIsUnit("target", unit) then
		if self:IsSpellInRangeAndActionBar(self.SpellCheck) then
			if dist > (self.MapScale*40) then
				local adjust = dist/(40*0.99)
				self:Debug("RC_INC "..GetUnitName(unit).."_40Y - "..math.floor(adjust/self.MapScale*100).."% "..adjust)
				self.MapScale = adjust
			end	
			return true
		elseif dist < (self.MapScale*40) then
			local adjust = dist/(40*1.01)
			self:Debug("RC_DEC "..GetUnitName(unit).."_40Y - "..math.floor(adjust/self.MapScale*100).."% "..adjust)
			self.MapScale = adjust
			return nil
		else
			return nil
		end
	elseif dist < (self.MapScale*40*0.85) then
		return true
	else
		return nil
	end
end

function sRaidFrames:ZoneCheck()
	self.MapScale = 0
	self.MapEnable = false
	SetMapToCurrentZone()
	self:ResetHealIndicators()
	self:Debug("RC_RST")
end

function sRaidFrames:Debug(msg)
	if msg and self.opt.Debug then 
		DEFAULT_CHAT_FRAME:AddMessage("|cff00eeee sRaidFrames Debug: |cffffffff"..msg); 
	end
end

function sRaidFrames:UpdateRangeFrequency(value)
	self:CancelScheduledEvent("sRaidFramesRangeCheck")
	self:ScheduleRepeatingEvent("sRaidFramesRangeCheck", self.RangeCheck, value, self)
end

function sRaidFrames:UpdateUnit(units, force_focus)
	local class_color = self.opt.statusbar_color
	for unit in pairs(units) do
		local focus_unit = self:CheckFocusUnit(unit)
		if self.visible[unit] and UnitExists(unit) then
			if (not self.opt.dynamic_sort or not focus_unit and not force_focus or focus_unit and force_focus) then
				local f = self.frames[unit]
				local range = ""
				
				local id_str = string.gsub(unit,"raid","")
				local _, _, subgroup = GetRaidRosterInfo(id_str)
				
				if self.opt.grp_name then
					subgroup = "G"..subgroup
				else
					subgroup = ""
				end
				
				if self.opt.Debug then
					range = self.UnitRangeArray[unit]
					if not range then
						range =  ""
					end
				end

				local _, class = UnitClass(unit)
				local unit_name = UnitName(unit).." "..subgroup
				
				if self.opt.unit_name_lenght or self.opt.Debug then
					unit_name = string.sub(UnitName(unit), 1, 3).." "..subgroup --UnitName(unit)
				end
				
				local unit_aggro = Banzai:GetUnitAggroByUnitId(unit)
				
				if unit_aggro and self.opt.red then
					f.title:SetText("|cffff0000"..unit_name..range.."|r")
				elseif not self.opt.unitname_color then
					f.title:SetText(unit_name..range.."|r")
				elseif class then
					f.title:SetText(self.RAID_CLASS_COLORS[class].colorStr..unit_name..range.."|r")
				else
					f.title:SetText(unit_name or L["Unknown"])
				end

				self.feign[unit] = nil
				
				-- Silly hunters, why do you have to be so annoying
				if UnitExists(unit.."target") and UnitIsUnit(unit.."target", "player") and not UnitIsUnit(unit, "player") then
					self.targeting[unit] = true
				else
					self.targeting[unit] = nil
				end
				
				if class == "HUNTER" then
					if UnitIsDead(unit) then
						for i=1,32 do
							local texture = UnitBuff(unit, i)
							if not texture then break end
							if texture == "Interface\\Icons\\Ability_Rogue_FeignDeath" then
								self.feign[unit] = true
								break
							end
						end
					end
				end
				
				
				if not self.feign[unit] then
					local status, dead, ghost = nil, UnitIsDead(unit) or UnitHealth(unit) <= 1, UnitIsGhost(unit)
									
					if not UnitIsConnected(unit) then status = "|cff858687"..L["Offline"].."|r"
					elseif self.res[unit] == 1 and dead then status = "|cffff8c00"..L["Can Recover"].."|r"
					elseif self.res[unit] == 2 and (dead or ghost) then status = "|cffff8c00"..L["Resurrected"].."|r"
					elseif ghost then status = "|cffff0000"..L["Released"].."|r"
					elseif dead or UnitHealth(unit) <= 1 then status = "|cffff0000"..L["Dead"].."|r"
					end				
					
					if status then
						self.unavail[unit] = true
						f.hpbar.text:SetText(status)
						f.hpbar:SetValue(0)
						f.mpbar.text:SetText()
						f.mpbar:SetValue(0)
						--f:SetBackdropColor(0.3, 0.3, 0.3, 1)
					
						self:HideHealIndicator(unit, true)
						
					else
						
						--self:CreateHealIndicator(unit)
						
						self.unavail[unit] = false
						self.res[unit] = nil
						local hp = UnitHealth(unit) or 0
						local hpmax = UnitHealthMax(unit)
						local hpp = (hpmax ~= 0) and ceil((hp / hpmax) * 100) or 0
						local hptext, hpvalue = nil, nil

						if self.opt.healthDisplayType == "percent" then
							hptext = hpp .."%"
						elseif self.opt.healthDisplayType == "deficit" then
							hptext = (hp-hpmax) ~=  0 and (hp-hpmax) or nil
						elseif self.opt.healthDisplayType == "current" then
							hptext = hp
						elseif self.opt.healthDisplayType == "curmax" then
							hptext = hp .."/".. hpmax
						end
						
						if self.opt.Invert then
							hpvalue = 100 - hpp
						else
							hpvalue = hpp
						end

						f.hpbar.text:SetText(hptext)
						f.hpbar:SetValue(hpvalue)			
						

						if unit_aggro and self.opt.redbar then
							f.hpbar:SetStatusBarColor(1,0,0)
							
						elseif self.opt.targeting and not UnitAffectingCombat("player") and self.targeting[unit] then
							f.hpbar:SetStatusBarColor(0,0,0,0.75)
						
						elseif class_color then
							local class, fileName = UnitClass(unit)
							local color = self.RAID_CLASS_COLORS[fileName]
							if color then
								f.hpbar:SetStatusBarColor(color.r, color.g, color.b)
							end	
						else
							f.hpbar:SetStatusBarColor(self:GetHPSeverity(hpp/100))
						end

						local mp = UnitMana(unit) or 0
						local mpmax = UnitManaMax(unit)
						local mpp = (mpmax ~= 0) and ceil((mp / mpmax) * 100) or 0

						local powerType = UnitPowerType(unit)
						if self.opt.PowerFilter[powerType] == false then
							f.mpbar:SetValue(0)
						else
							local color = self.ManaBarColor[powerType]
							f.mpbar:SetStatusBarColor(color.r, color.g, color.b)
							f.mpbar:SetValue(mpp)
						end
					end
				else
					f.hpbar.text:SetText("|cff00ff00"..L["Feign Death"].."|r")
					f.hpbar:SetValue(100)
					f.hpbar:SetStatusBarColor(0, 0.9, 0.5)
					f.mpbar:SetValue(0)
				end
			end	
		end
	end
end

function sRaidFrames:UpdateBuffs(units)
	for unit in pairs(units) do
		if self.visible[unit] then
			local f = self.frames[unit]
			if UnitExists(unit) and UnitIsVisible(unit) then
				local cAura = nil
				local f = self.frames[unit]

				for i = 1, 2 do
					f["aura".. i]:Hide()
				end

				for i = 1, 4 do
					f["buff".. i]:Hide()
				end

				local debuffSlots = 0
				for i=1,16 do
					local debuffTexture, debuffApplications, debuffType = UnitDebuff(unit, i, self.opt.ShowOnlyDispellable)
					if not debuffTexture then break end

					if not self.opt.unit_debuff_aura and debuffType ~= nil and self.debuffColors[debuffType] and ((cAura and cAura.priority < self.debuffColors[debuffType].priority) or not cAura) then
						cAura = self.debuffColors[debuffType]
						sRaidFrames.debuff[unit] = debuffType
					end

					if (self.opt.BuffType == "debuffs" or self.opt.BuffType == "buffsifnotdebuffed") and debuffSlots < 2 then
						debuffSlots = debuffSlots + 1
						local debuffFrame = f["aura".. debuffSlots]
						debuffFrame.unitid = unit
						debuffFrame.debuffid = i
						debuffFrame:SetScript("OnEnter", function() GameTooltip:SetOwner(debuffFrame) GameTooltip:SetUnitDebuff(this.unitid, this.debuffid, self.opt.ShowOnlyDispellable) end);
						debuffFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
						debuffFrame.count:SetText(debuffApplications > 1 and debuffApplications or nil);
						debuffFrame.texture:SetTexture(debuffTexture)
						debuffFrame:SetFrameLevel(5)
						debuffFrame:Show()
					end
				end
				
				local dead = UnitIsDeadOrGhost(unit) or UnitHealth(unit) <= 1
				if self.opt.aggro_aura and not dead and Banzai:GetUnitAggroByUnitId(unit) then
					sRaidFrames.debuff[unit] = "Red"
					cAura = self.debuffColors["Red"]
					f:SetBackdropColor(cAura.r, cAura.g, cAura.b, cAura.a);
					
				elseif cAura and not dead then
					f:SetBackdropColor(cAura.r, cAura.g, cAura.b, cAura.a);
						
				else
					sRaidFrames.debuff[unit] = nil
					f:SetBackdropColor(self.opt.BackgroundColor.r, self.opt.BackgroundColor.g, self.opt.BackgroundColor.b, self.opt.BackgroundColor.a)
				end
		

				f.mpbar.text:SetText()
				
				if self.opt.targeting and not UnitAffectingCombat("player") and self.targeting[unit] then
					f.mpbar.text:SetText("|cffffffff Targeting You |r")
				
				elseif not self.opt.show_txt_buff then
					for i=1,32 do
						local texture = UnitBuff(unit, i)
						if not texture then break end
						--INV_BannerPVP_01
						-- First we match the texture, then we pull the name of the debuff from a tooltip, and compare it to BabbleSpell
						-- The idea is that we do a simple string match, and only if that string match triggers something, then we do the extra check
						-- This should prevent unnessesary calls to functions and lookups
						if texture == "Interface\\Icons\\INV_BannerPVP_01" then
							f.mpbar.text:SetText("|cffff0000 Flag Carrier|r")
						elseif texture == "Interface\\Icons\\Spell_Nature_TimeStop" and self:GetBuffName(unit, i) == BS["Divine Intervention"] then
							f.hpbar.text:SetText("|cffff0000"..L["Intervened"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Nature_Lightning" and self:GetBuffName(unit, i) == BS["Innervate"] then
							f.mpbar.text:SetText("|cff00ff00"..L["Innervating"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Holy_GreaterHeal" and self:GetBuffName(unit, i) == BS["Spirit of Redemption"] then
							f.hpbar.text:SetText("|cffff0000"..L["Spirit"].."|r")
						elseif texture == "Interface\\Icons\\Ability_Warrior_ShieldWall" and self:GetBuffName(unit, i) == BS["Shield Wall"] then
							f.mpbar.text:SetText("|cffffffff"..BS["Shield Wall"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Holy_AshesToAshes" and self:GetBuffName(unit, i) == BS["Last Stand"] then
							f.mpbar.text:SetText("|cffffffff"..BS["Last Stand"].."|r")
						elseif texture == "Interface\\Icons\\INV_Misc_Gem_Pearl_05" then
							f.mpbar.text:SetText("|cffffffff"..L["Gift of Life"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Frost_Frost" and self:GetBuffName(unit, i) == BS["Ice Block"] then
							f.mpbar.text:SetText("|cffbfefff"..BS["Ice Block"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Holy_SealOfProtection" and self:GetBuffName(unit, i) == BS["Blessing of Protection"] then
							f.mpbar.text:SetText("|cffffffff"..L["Protection"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Holy_DivineIntervention" and self:GetBuffName(unit, i) == BS["Divine Shield"] then
							f.mpbar.text:SetText("|cffffffff"..BS["Divine Shield"].."|r")
						elseif texture == "Interface\\Icons\\Ability_Vanish" and self:GetBuffName(unit, i) == BS["Vanish"] then
							f.mpbar.text:SetText("|cffffffff"..L["Vanished"].."|r")
						elseif texture == "Interface\\Icons\\Ability_Stealth" and self:GetBuffName(unit, i) == BS["Stealth"] then
							f.mpbar.text:SetText("|cffffffff"..L["Stealthed"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Holy_PowerInfusion" and self:GetBuffName(unit, i) == BS["Power Infusion"] then
							f.mpbar.text:SetText("|cffffffff"..L["Infused"].."|r")
						elseif texture == "Interface\\Icons\\Spell_Holy_Excorcism" and self:GetBuffName(unit, i) == BS["Fear Ward"] then
							f.mpbar.text:SetText("|cffffff00"..BS["Fear Ward"].."|r")
						elseif UnitClass("player") == "Priest" and texture == "Interface\\Icons\\Spell_Holy_Renew" and self:GetBuffName(unit, i) == BS["Renew"] then
							f.mpbar.text:SetText("|cff00ff00"..BS["Renew"].."|r")
						elseif UnitClass("player") == "Druid" and texture == "Interface\\Icons\\Spell_Nature_Rejuvenation" and self:GetBuffName(unit, i) == BS["Rejuvenation"] then
							f.mpbar.text:SetText("|cff00ff00"..BS["Rejuvenation"].."|r")
						end
					end	
				end

				if self.opt.BuffType == "buffs" or (self.opt.BuffType == "buffsifnotdebuffed" and debuffSlots == 0) then
					local buffSlots = 0
					local showOnlyCastable = 1
					if next(self.opt.BuffFilter) then
						showOnlyCastable = 0
					end
					for i=1,32 do
						local buffTexture, buffApplications = UnitBuff(unit, i, showOnlyCastable)
						if not buffTexture then break end

						if showOnlyCastable == 1 or self.opt.BuffFilter[self:GetBuffName(unit, i)] then
							buffSlots = buffSlots + 1
							local buffFrame = f["buff".. buffSlots]
							buffFrame.buffid = i
							buffFrame.unitid = unit
							buffFrame:SetScript("OnEnter", function() GameTooltip:SetOwner(buffFrame) GameTooltip:SetUnitBuff(this.unitid, this.buffid, showOnlyCastable) end)
							buffFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
							buffFrame.count:SetText(buffApplications > 1 and buffApplications or nil)
							buffFrame.texture:SetTexture(buffTexture)
							--buffFrame:SetFrameLevel(10)
							buffFrame:Show()
						end

						if buffSlots == 4 then break end
					end
				end
			else
				f.mpbar.text:SetText()
			end
		end	
	end
end

function sRaidFrames:GetBuffName(unit, i)
	sRaidFramesTooltip:SetUnitBuff(unit, i)
  return sRaidFramesTooltipTextLeft1:GetText() or ""
end

function sRaidFrames:SetUnitBuffDuration(unit, buff)
	if not oRAOBuff or not oRAOBuff.UnitBuffsTables then return end
	local unitBuffs = oRAOBuff.UnitBuffsTables[UnitName(unit)]

	local endtime = unitBuffs[self:GetBuffName(unit, buff)]
	if endtime then
		local time = endtime - GetTime()
		if time > 0 then
			GameTooltip:AddLine("Time remaining: ".. SecondsToTimeAbbrev(time), 0.7, 0.7, 1)
			GameTooltip:Show()
		end
	end
end

function sRaidFrames:GetHPSeverity(percent)
	--if (percent<=0 or percent>1.0) then return 0.35,0.35,0.35 end

	if (percent >= 0.5) then
		return (1.0-percent)*2, 1.0, 0.0
	else
		return 1.0, percent*2, 0.0
	end
end

function sRaidFrames:StartMovingAll()
	this.multidrag = 1
	local id = this:GetID()
	local fg = self.groupframes[id]
	local x, y = fg:GetLeft(), fg:GetTop()
	if ( not x or not y ) then
		return
	end
	for k, f in pairs(self.groupframes) do
		if k ~= id then
			local oX, oY = f:GetLeft(), f:GetTop()
			if ( oX and oY ) then
				f:ClearAllPoints()
				f:SetPoint("TOPLEFT", fg, "TOPLEFT", oX-x, oY-y)
			end
		end
	end
end

function sRaidFrames:StopMovingOrSizingAll()
	this.multidrag = nil
	local id = this:GetID()
	local fg = self.groupframes[id]
	for k, f in pairs(self.groupframes) do
		if k ~= id then
			local oX, oY = f:GetLeft(), f:GetTop()
			if ( oX and oY ) then
				f:ClearAllPoints()
				f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", oX, oY)
			end
		end
	end
end

function sRaidFrames:UnitTooltip(frame)
	if self.opt.TooltipMethod == "never" then
		return
	elseif self.opt.TooltipMethod == "notincombat" and UnitAffectingCombat("player") then
		return
	end
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(frame.id);
	GameTooltip:SetOwner(frame)
	GameTooltip:AddDoubleLine(name, level, self.RAID_CLASS_COLORS[fileName].r, self.RAID_CLASS_COLORS[fileName].g, self.RAID_CLASS_COLORS[fileName].b, 1, 1, 1)
	GameTooltip:AddLine(UnitRace(frame.unit) .. " " .. class, 1, 1, 1);
	GameTooltip:AddDoubleLine(zone, "Group ".. subgroup, 1, 1, 1, 1, 1, 1);

	if oRAOCoolDown and oRAOCoolDown.db.profile.cooldowns[name] and self.cooldownSpells[fileName] then
		GameTooltip:AddLine(" ")
		local expire = oRAOCoolDown.db.profile.cooldowns[name]-time()
		if expire > 0 then
  		GameTooltip:AddDoubleLine(self.cooldownSpells[fileName], SecondsToTime(expire), nil, nil, nil, 1, 0, 0)
  	else
  		GameTooltip:AddDoubleLine(self.cooldownSpells[fileName], "Ready!", nil, nil, nil, 0, 1, 0)
  	end
	end

	GameTooltip:Show()
end


function sRaidFrames:MouseOverHighlight(f, type)
	--DEFAULT_CHAT_FRAME:AddMessage(type)
	if type =="ENTER" then
		f.hpbar.highlight:Show()
	else
		f.hpbar.highlight:Hide()
	end
end

function sRaidFrames:CreateUnitFrame(id)
	local f = CreateFrame("Button", "sRaidFrames_" .. id, self.master)
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	f:SetScript("OnClick", self.OnUnitClick)
	f:SetScript("OnEnter", function() self:UnitTooltip(this) sRaidFrames:MouseOverHighlight(f, "ENTER") end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() sRaidFrames:MouseOverHighlight(f, "LEAVE") end)

	f.title = f:CreateFontString(nil, "ARTWORK")
	f.title:SetFontObject(GameFontNormalSmall)
	f.title:SetJustifyH("LEFT")

	f.aura1 = CreateFrame("Button", nil, f)
	f.aura1.texture = f.aura1:CreateTexture(nil, "ARTWORK")
	f.aura1.texture:SetAllPoints(f.aura1);
	f.aura1.count = f.aura1:CreateFontString(nil, "OVERLAY")
	f.aura1.count:SetFontObject(GameFontHighlightSmallOutline)
	f.aura1.count:SetJustifyH("CENTER")
	f.aura1.count:SetPoint("CENTER", f.aura1, "CENTER", 0, 0);
	f.aura1:Hide()

	f.aura2 = CreateFrame("Button", nil, f)
	f.aura2.texture = f.aura2:CreateTexture(nil, "ARTWORK")
	f.aura2.texture:SetAllPoints(f.aura2)
	f.aura2.count = f.aura2:CreateFontString(nil, "OVERLAY")
	f.aura2.count:SetFontObject(GameFontHighlightSmallOutline)
	f.aura2.count:SetJustifyH("CENTER")
	f.aura2.count:SetPoint("CENTER", f.aura2, "CENTER", 0, 0);
	f.aura2:Hide()

	f.buff1 = CreateFrame("Button", nil, f)
	f.buff1.texture = f.buff1:CreateTexture(nil, "ARTWORK")
	f.buff1.texture:SetAllPoints(f.buff1)
	f.buff1.count = f.buff1:CreateFontString(nil, "OVERLAY")
	f.buff1.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff1.count:SetJustifyH("CENTER")
	f.buff1.count:SetPoint("CENTER", f.buff1, "CENTER", 0, 0);
	f.buff1:Hide()

	f.buff2 = CreateFrame("Button", nil, f)
	f.buff2.texture = f.buff2:CreateTexture(nil, "ARTWORK")
	f.buff2.texture:SetAllPoints(f.buff2)
	f.buff2.count = f.buff2:CreateFontString(nil, "OVERLAY")
	f.buff2.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff2.count:SetJustifyH("CENTER")
	f.buff2.count:SetPoint("CENTER", f.buff2, "CENTER", 0, 0);
	f.buff2:Hide()

	f.buff3 = CreateFrame("Button", nil, f)
	f.buff3.texture = f.buff3:CreateTexture(nil, "ARTWORK")
	f.buff3.texture:SetAllPoints(f.buff3)
	f.buff3.count = f.buff3:CreateFontString(nil, "OVERLAY")
	f.buff3.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff3.count:SetJustifyH("CENTER")
	f.buff3.count:SetPoint("CENTER", f.buff3, "CENTER", 0, 0);
	f.buff3:Hide()

	f.buff4 = CreateFrame("Button", nil, f)
	f.buff4.texture = f.buff4:CreateTexture(nil, "ARTWORK")
	f.buff4.texture:SetAllPoints(f.buff4)
	f.buff4.count = f.buff4:CreateFontString(nil, "OVERLAY")
	f.buff4.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff4.count:SetJustifyH("CENTER")
	f.buff4.count:SetPoint("CENTER", f.buff4, "CENTER", 0, 0);
	f.buff4:Hide()

	f.hpbar = CreateFrame("StatusBar", nil, f)
	f.hpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
	f.hpbar:SetMinMaxValues(0,100)
	f.hpbar:SetFrameLevel(2)

	f.hpbar.texture = f.hpbar:CreateTexture(nil, "BORDER")
	f.hpbar.texture:SetTexture(surface:Fetch(self.opt.Texture))
	f.hpbar.texture:SetVertexColor(1, 0, 0, 0)
	
	
	f.hpbar.highlight = f.hpbar:CreateTexture(nil, "OVERLAY")
	f.hpbar.highlight:SetAlpha(0.3)
	f.hpbar.highlight:SetTexture("Interface\\AddOns\\sRaidFrames\\textures\\MouseoverHighlight")
	f.hpbar.highlight:SetBlendMode("ADD")
	f.hpbar.highlight:Hide()
	
	f.hpbar.indicator1 = f.hpbar:CreateTexture(nil, "OVERLAY")
	f.hpbar.indicator1:SetAlpha(1)
	f.hpbar.indicator1:SetTexture("Interface\\Addons\\sRaidFrames\\textures\\round16x16")
	f.hpbar.indicator1:Hide()
	
	f.hpbar.indicator2 = f.hpbar:CreateTexture(nil, "OVERLAY")
	f.hpbar.indicator2:SetAlpha(1)
	f.hpbar.indicator2:SetTexture("Interface\\Addons\\sRaidFrames\\textures\\square16x16")
	f.hpbar.indicator2:Hide()
	

	f.hpbar.text = f.hpbar:CreateFontString(nil, "ARTWORK")
	f.hpbar.text:SetFontObject(GameFontHighlightSmall)
	f.hpbar.text:SetJustifyH("CENTER")

	f.mpbar = CreateFrame("StatusBar", nil, f)
	f.mpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
	f.mpbar:SetMinMaxValues(0,100)

	f.mpbar.texture = f.mpbar:CreateTexture(nil, "BORDER")
	f.mpbar.texture:SetTexture(surface:Fetch(self.opt.Texture))
	f.mpbar.texture:SetVertexColor(1, 0, 0, 0)

	f.mpbar.text = f.mpbar:CreateFontString(nil, "ARTWORK")
	f.mpbar.text:SetFontObject(GameFontHighlightSmall)
	f.mpbar.text:SetJustifyH("CENTER")

	f:SetID(id)
	f.id = id
	f.unit = "raid" .. id

	self:SetStyle(f, "raid"..id)

	f:Hide();

	self.frames["raid"..id] = f
end


function sRaidFrames:CreateGroupFrame(id)
	local f = CreateFrame("Frame", "sRaidGroupFrames_" .. id, self.master)
	f:SetHeight(15)
	f:SetWidth(90)
	f:SetMovable(true)
	f:EnableMouse(true)
	
	if id == 9 then
		f:SetScript("OnDragStart", function() if self.opt.lock_focus then return end if IsAltKeyDown() then self:StartMovingAll() end f:StartMoving() end)
	else
		f:SetScript("OnDragStart", function() if self.opt.lock then return end if IsAltKeyDown() then self:StartMovingAll() end f:StartMoving() end)
	end
	
	f:SetScript("OnDragStop", function() if f.multidrag == 1 then self:StopMovingOrSizingAll() end f:StopMovingOrSizing() self:SavePosition() end)
	f:RegisterForDrag("LeftButton")
	f:SetParent(self.master)

	f.title = f:CreateFontString(nil, "ARTWORK")
	f.title:SetFontObject(GameFontNormalSmall)
	f.title:SetJustifyH("CENTER")
	f.title:SetText("Group ".. id);
	if id ~= 9 and not self.opt.ShowGroupTitles or id == 9 and not self.opt.ShowGroupTitles_Focus then
		f.title:Hide()
	end

	self:SetWHP(f.title, 80, f:GetHeight(), "TOPLEFT", f, "TOPLEFT",  0, 0)
	
	f:ClearAllPoints();
	f:SetPoint("LEFT", self.master, "LEFT")
	
	
	f:SetID(id)
	f.id = id

	f:Hide();
	self.groupframes[id] = f
end

function sRaidFrames:SortGroupFrames(frame, id)
	frame:ClearAllPoints();
	if id == 1 then
		frame:SetPoint("TOPLEFT", self.master, "BOTTOMLEFT")
	else
		frame:SetPoint("TOPLEFT", self.groupframes[id-1], "BOTTOMLEFT")
	end
end

function sRaidFrames:SetBackdrop(f, unit, aggro)
	if self.opt.Border then
		f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
										tile = true,
										tileSize = 16,
										edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
										edgeSize = 16,
										insets = { left = 5, right = 5, top = 5, bottom = 5 }
									})
	else
		f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
										tile = true, tileSize = 16,
										insets = { left = 0, right = 0, top = 0, bottom = 0 }
									})
	end

	local dead = UnitExists(unit) and (UnitIsDeadOrGhost(unit) or UnitHealth(unit) <= 1)
	if self.debuff[unit] and not dead then
		local cAura = self.debuffColors[self.debuff[unit]]
		f:SetBackdropColor(cAura.r, cAura.g, cAura.b, cAura.a);
	else
		f:SetBackdropColor(self.opt.BackgroundColor.r, self.opt.BackgroundColor.g, self.opt.BackgroundColor.b, self.opt.BackgroundColor.a)
	end	
	
	if aggro and self.opt.aggro then
		f:SetBackdropBorderColor(1, 0, 0, self.opt.BorderColor.a)
	else
		f:SetBackdropBorderColor(self.opt.BorderColor.r, self.opt.BorderColor.g, self.opt.BorderColor.b, self.opt.BorderColor.a)
	end	
end

function sRaidFrames:SetStyle(f, unit, width, aggro)
	
	--f.hpbar.highlight
	
	local frame_width = width or self.opt.Width
	
	self:SetWHP(f, frame_width, 40)
	self:SetWHP(f.title, frame_width - 10, 16, "TOPLEFT", f, "TOPLEFT",  5, -6)
	
	self:SetWHP(f.aura1, 12, 12, "TOPRIGHT", f, "TOPRIGHT", -4, -4)
	self:SetWHP(f.aura2, 12, 12, "RIGHT", f.aura1, "LEFT", 0, 0)
	self:SetWHP(f.buff1, 12, 12, "TOPRIGHT", f, "TOPRIGHT", -4, -4)
	self:SetWHP(f.buff2, 12, 12, "RIGHT", f.buff1, "LEFT", 0, 0)
	self:SetWHP(f.buff3, 12, 12, "RIGHT", f.buff2, "LEFT", 0, 0)
	self:SetWHP(f.buff4, 12, 12, "RIGHT", f.buff3, "LEFT", 0, 0)
	
		
	if not sRaidFrames.opt.Border then
		if self.opt.PowerFilter[0] or self.opt.PowerFilter[1] or self.opt.PowerFilter[2] or self.opt.PowerFilter[3] then
			self:SetWHP(f.hpbar, frame_width - 10, 27, "TOPLEFT", f, "BOTTOMLEFT", 5, 35)
		else
			self:SetWHP(f.hpbar, frame_width - 10, 30, "TOPLEFT", f, "BOTTOMLEFT", 5, 35)
		end	
		self:SetWHP(f.mpbar, frame_width - 10, 3, "TOPLEFT", f.hpbar, "BOTTOMLEFT", 0, 0)
		self:SetWHP(f.hpbar.indicator2, 5, 5, "TOPLEFT", f, "BOTTOMLEFT", 5, 35)
	else
		if self.opt.PowerFilter[0] or self.opt.PowerFilter[1] or self.opt.PowerFilter[2] or self.opt.PowerFilter[3] then
			self:SetWHP(f.hpbar, frame_width - 10, 26, "TOPLEFT", f, "BOTTOMLEFT", 5, 35)
		else
			self:SetWHP(f.hpbar, frame_width - 10, 30, "TOPLEFT", f, "BOTTOMLEFT", 5, 35)
		end	
		self:SetWHP(f.mpbar, frame_width - 10, 3, "TOPLEFT", f.hpbar, "BOTTOMLEFT", 0, 0)
		self:SetWHP(f.hpbar.indicator1, 9, 9, "TOPLEFT", f, "BOTTOMLEFT", 4, 37)
	end
	
	self:SetWHP(f.mpbar.text, f.mpbar:GetWidth(), f.mpbar:GetHeight(), "CENTER", f, "CENTER", 0, -11)
	self:SetWHP(f.hpbar.highlight, frame_width - 10, 30, "TOPLEFT", f, "BOTTOMLEFT", 5, 35) -- highlight
	self:SetWHP(f.hpbar.text, f.hpbar:GetWidth(), f.hpbar:GetHeight(), "CENTER", f, "CENTER", 0, -4)
	
	
	f.mpbar.text:SetTextHeight(7.5)
	f.hpbar.text:SetTextHeight(8)

	self:SetBackdrop(f, unit, aggro)
	
	if self.opt.vertical_hp then
		f.hpbar:SetOrientation("VERTICAL")
	else
		f.hpbar:SetOrientation("HORIZONTAL")
	end
end

function sRaidFrames:SetWHP(frame, width, height, p1, relative, p2, x, y)
	frame:SetWidth(width)
	frame:SetHeight(height)

	if (p1) then
		frame:ClearAllPoints()
		frame:SetPoint(p1, relative, p2, x, y)
	end
end

function sRaidFrames:Sort_Force()
	--DEFAULT_CHAT_FRAME:AddMessage("Sort_Force")
	if self.opt.dynamic_sort or self.opt.SortBy == "fixed" then 
		self:Sort(true)
	end
	
	if self.opt.RangeCheck or self.opt.ExtendedRangeCheck or self.opt.ExtendedRangeCheckCombat then
		for id = 1, MAX_RAID_MEMBERS do
			if self.visible["raid" .. id] then
				if self.UnitRangeArray["raid" .. id] ~= "" then
					self.frames["raid" .. id]:SetAlpha(1)
				else
					self.frames["raid" .. id]:SetAlpha(self.opt.RangeAlpha)
				end
			end
		end
	end	
end

function sRaidFrames:MembersSortBy(id)
	local sort_by = ""
	local unit = "raid" .. id
	
	if self.opt.SubSort == "class" then
		sort_by = UnitClass(unit) or ""
	elseif self.opt.SubSort == "name" then
		sort_by = UnitName(unit) or ""
	else
		local _, _, subgroup = GetRaidRosterInfo(id)
		sort_by = subgroup..id
	end	
	
	if self.opt.SortBy == "fixed" and self.opt.dead_sort and not self.feign[unit] then
		if not UnitIsConnected(unit) then
			sort_by = "zzz"..sort_by
		elseif UnitIsDead(unit) then
			sort_by = "zzy"..sort_by
		elseif UnitIsGhost(unit) then
			sort_by = "zzx"..sort_by
		elseif UnitHealth(unit) <= 1 then
			sort_by = "zzw"..sort_by
		end	
	end
	--DEFAULT_CHAT_FRAME:AddMessage(sort_by)
	return sort_by
end

function sRaidFrames:Sort(force_sort)
	local self = sRaidFrames
	local frameAssignments = {}
	local sort = {}
	local counter={0,0,0,0,0,0,0,0,0}

	self:RefreshFocusWithRange()


	for id = 1, MAX_RAID_MEMBERS do
		if self.visible["raid" .. id] then
			--if not force_sort or force_sort and self:CheckFocusUnit("raid"..id) then
				table.insert(sort, id)
			--end
		end
	end
	
	--[[
	if self.opt.SubSort == "name" then
		table.sort(sort, function(a,b) return UnitName("raid" .. a) < UnitName("raid" ..b) end)
	elseif self.opt.SubSort == "class" then
		table.sort(sort, function(a,b) return UnitClass("raid" .. a) < UnitClass("raid" ..b) end)
	end
	--]]

	table.sort(sort, function(a,b) return self:MembersSortBy(a) < self:MembersSortBy(b) end)


	if self.opt.SortBy == "class" then
		frameAssignments["WARRIOR"] = 1;
		frameAssignments["MAGE"] = 2;
		frameAssignments["PALADIN"] = 3;
		frameAssignments["SHAMAN"] = 3;
		frameAssignments["DRUID"] = 4;
		frameAssignments["HUNTER"] = 5;
		frameAssignments["ROGUE"] = 6;
		frameAssignments["WARLOCK"] = 7;
		frameAssignments["PRIEST"] = 8;

		self.groupframes[1].title:SetText(L["Warrior"]);
		self.groupframes[2].title:SetText(L["Mage"]);
		self.groupframes[3].title:SetText((UnitFactionGroup("player") == "Alliance") and L["Paladin"] or L["Shaman"]);
		self.groupframes[4].title:SetText(L["Druid"]);
		self.groupframes[5].title:SetText(L["Hunter"]);
		self.groupframes[6].title:SetText(L["Rogue"]);
		self.groupframes[7].title:SetText(L["Warlock"]);
		self.groupframes[8].title:SetText(L["Priest"]);

	elseif self.opt.SortBy == "group" or self.opt.SortBy == "fixed" then
		frameAssignments[1] = 1;
		frameAssignments[2] = 2;
		frameAssignments[3] = 3;
		frameAssignments[4] = 4;
		frameAssignments[5] = 5;
		frameAssignments[6] = 6;
		frameAssignments[7] = 7;
		frameAssignments[8] = 8;

		self.groupframes[1].title:SetText(L["Group 1"]);
		self.groupframes[2].title:SetText(L["Group 2"]);
		self.groupframes[3].title:SetText(L["Group 3"]);
		self.groupframes[4].title:SetText(L["Group 4"]);
		self.groupframes[5].title:SetText(L["Group 5"]);
		self.groupframes[6].title:SetText(L["Group 6"]);
		self.groupframes[7].title:SetText(L["Group 7"]);
		self.groupframes[8].title:SetText(L["Group 8"]);
	end
	
	frameAssignments[9] = 9;
	self.groupframes[9].title:SetText("Focus");

	-- -- -- Do the sorting -- -- --

	local focus_units1 = {}
	local focus_units2 = {}
	for _,id in pairs(sort) do
		if self:CheckFocusUnit("raid"..id) then
			table.insert(focus_units1, id)
		end
	end
	
	if self.opt.dynamic_sort then
		table.sort(focus_units1, function(a,b) return self:UnitModHP("raid".. a) < self:UnitModHP("raid"..b) end)
	end	
	
	local index = 40
	for id in pairs(self.UnitSortOrder) do
		index = index + 1
		self.UnitSortOrder[id] = index 
	end
	
	for i,id in pairs(focus_units1) do
		focus_units2[id] = i-1
		self.UnitSortOrder[id] = i
	end

	for _,id in pairs(sort) do
		local frameAssignee = nil
		if self.opt.SortBy == "class" then
			local _, eClass = UnitClass("raid"..id)
			if eClass then
				frameAssignee = frameAssignments[eClass]
			end
		elseif self.opt.SortBy == "group" then
			local name, _, subgroup = GetRaidRosterInfo(id)
			if name and subgroup then
				frameAssignee = frameAssignments[subgroup]
			end
		else
			for k=8,1,-1 do
				if counter[k] < self.opt.fixed_count then
					frameAssignee = k
				end
			end
		end

		local growth = self.opt.Growth
		if self:CheckFocusUnit("raid"..id) then
			frameAssignee = 9
			growth = self.opt.Growth_Focus
		end

		if frameAssignee then
			local f = self.frames["raid" .. id]
			local groupframe = self.groupframes[frameAssignee]
			
			local count = counter[frameAssignee]
			if focus_units2[id] then
				count = focus_units2[id]
			end
			
			if growth == "up" then
				a1, a2, yMod, xMod = "BOTTOM", "TOP", (count*(f:GetHeight()+self.opt.Spacing)), 0
			elseif growth == "right" then
				a1, a2, yMod, xMod = "TOP", "BOTTOM", 0, (count*(f:GetWidth()+self.opt.Spacing))
			elseif growth == "left" then
				a1, a2, yMod, xMod = "TOP", "BOTTOM", 0, -1*(count*(f:GetWidth()+self.opt.Spacing))
			else
				a1, a2, yMod, xMod = "TOP", "BOTTOM", -1*(count*(f:GetHeight()+self.opt.Spacing)), 0
			end

			f:ClearAllPoints()
			f:SetPoint(a1, groupframe, a2, xMod, yMod)

			counter[frameAssignee] = counter[frameAssignee] + 1
			groupframe:Show()
			
			if frameAssignee ~= 9 and self.opt.ShowGroupTitles or frameAssignee == 9 and self.opt.ShowGroupTitles_Focus then
				groupframe.title:Show()
			else
				groupframe.title:Hide()
			end
		end
	end

	-- Hide group frames which contain no children
	if not force_sort then	
		for k,v in pairs(counter) do
			if v == 0 then
				self.groupframes[k]:Hide()
			end
		end

		self:UpdateAll()
	else
		self:UpdateUnit(self.visible, force_sort)
	end	
	
end

function sRaidFrames:OnUnitClick()
	local unitid, button = this.unit, arg1;

	if sRaidFramesCustomOnClickFunction and sRaidFramesCustomOnClickFunction(button, unitid) then
		return
	end

	if ( SpellIsTargeting() ) then
		SpellTargetUnit(unitid)
	else
		TargetUnit(unitid)
	end
end

function sRaidFrames:SetPosition()
	if not self.opt.Positions then
		self:ResetPosition()
	else
		self:RestorePosition()
	end
end

function sRaidFrames:SavePosition()
	local aryPos = {}
	local s = self.master:GetEffectiveScale()

	for k,f in pairs(self.groupframes) do
		aryPos[k] = {x = f:GetLeft()*s, y = f:GetTop()*s}
	end

	self:S("Positions", aryPos)
end

function sRaidFrames:RestorePosition()
	local aryPos = self.opt.Positions
	local s = self.master:GetEffectiveScale()

	for k, pos in pairs(aryPos) do
		local f = self.groupframes[k]
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pos["x"]/s, pos["y"]/s)
	end
end

function sRaidFrames:ResetPosition()
	self:PositionLayout("ctra", 200, -200)
end

function sRaidFrames:PositionLayout(layout, xBuffer, yBuffer)
	local xMod, yMod, i = 0, 0, -1
	local frameHeight = self.frames["raid1"]:GetHeight()+3

	for k,v in pairs(self.groupframes) do
		i = i + 1
		if layout == "horizontal" then
			yMod = (i) * v:GetWidth()
			xMod = 0
		elseif layout == "vertical" then
			if i ~= 0 and math_mod(i, 2) == 0 then
				xMod = xMod + (-1*MEMBERS_PER_RAID_GROUP*frameHeight)
				yMod = 0
				i = 0
			else
				yMod = i * v:GetWidth()
			end
		elseif layout == "ctra" then
			if i ~= 0 and math_mod(i, 2) == 0 then
				yMod = yMod + v:GetWidth()
				xMod = 0
				i = 0
			else
				xMod = i * (-1*MEMBERS_PER_RAID_GROUP*frameHeight)
			end
		end

		v:ClearAllPoints()
		v:SetPoint("TOPLEFT", UIParent, "TOPLEFT", xBuffer+yMod, yBuffer+xMod)
	end

	self:SavePosition()
end

local Tablet = AceLibrary("Tablet-2.0")
function sRaidFrames:OnTooltipUpdate()
	Tablet:SetHint(L["Right-click for options."])
end

function sRaidFrames:S(var, val)
	self.db.profile[var] = val
end


--==Added by Ogrisch

function sRaidFrames:ShowHealIndicator(unit)
	if not unit or not self.opt.heal then return end
		
	if not self.indicator[unit] then
		self.indicator[unit] = 0
	end
	
	--if not unit or not self.indicator or not self.indicator[unit] then return end
	
	if self.indicator[unit] then
		self.indicator[unit] = self.indicator[unit] + 1
	end	
	
	self:SetHealIndicator(unit);
end

function sRaidFrames:HideHealIndicator(unit, force)
	if not unit or not self.opt.heal then return end
	
	if not self.indicator[unit] then
		self.indicator[unit] = 0
	end
	
	if self.indicator[unit] and self.indicator[unit] > 0 then
		if force then
			self.indicator[unit] = 0
		else
			self.indicator[unit] = self.indicator[unit] - 1
		end	
	end
	
	self:SetHealIndicator(unit);
end

function sRaidFrames:SetHealIndicator(unit)
	if not unit or not UnitExists(unit) or not self.frames or not self.frames[unit] then
		return
	end
	
	local f = nil
	
	if self.opt.Border then
		f = self.frames[unit].hpbar.indicator1
	else
		f = self.frames[unit].hpbar.indicator2
	end
	
	if self.indicator[unit] == 0 then
		f:SetVertexColor(0, 0, 0, 0)
		f:Hide()
	else
		if self.indicator[unit] == 1 then
			f:SetVertexColor(0, 1, 0, 1)
		elseif self.indicator[unit] == 2 then
			f:SetVertexColor(1, 1, 0, 1)
		elseif self.indicator[unit] == 3 then
			f:SetVertexColor(1, 0.4, 0, 1)
		else
			f:SetVertexColor(1, 0, 0, 1)
		end
		
		f:Show()

	end	
end

function sRaidFrames:ResetHealIndicators(mode)
	if UnitInRaid("player") and self.indicator then
		for key,value in pairs(self.indicator) do
			self.indicator[key] = 0
			self:SetHealIndicator(key)
			if mode == "force" then
				self.indicator[key] = nil
			end
		end
	end	
end

function sRaidFrames:LoadStyle()
	for unit in pairs(self.visible) do
		local aggro = Banzai:GetUnitAggroByUnitId(unit)
		if self:CheckFocusUnit(unit) then
			self:SetStyle(self.frames[unit], unit, self.opt.WidthFocus, aggro)
			self.frames[unit]:SetScale(self.opt.ScaleFocus)
		else
			self:SetStyle(self.frames[unit], unit, self.opt.Width, aggro)
			self.frames[unit]:SetScale(self.opt.Scale)
		end
	end
	
	self:Sort();
end


function sRaidFrames:RefreshFocusWithRange()
	self:CheckRangeFocus(nil, "reset")
	for id = 1, MAX_RAID_MEMBERS do
		if self:QueryVisibility(id) then
			self:CheckRangeFocus("raid" .. id, "add")
			if not self.visible["raid" .. id] then
				self.frames["raid" .. id]:Show()
				self.visible["raid" .. id] = true;
			end
		else
			if self.visible["raid" .. id] then
				self.frames["raid" .. id]:Hide()
				self.visible["raid" .. id] = nil;
			end
		end
	end
	
	self:CheckRangeFocus(nil, "sort")
		
	if self.opt.fill_range then
		for unit in pairs(self.visible) do
			local aggro = Banzai:GetUnitAggroByUnitId(unit)
			if self:CheckFocusUnit(unit) then
				self:SetStyle(self.frames[unit], unit, self.opt.WidthFocus, aggro)
				self.frames[unit]:SetScale(self.opt.ScaleFocus)
			else
				self:SetStyle(self.frames[unit], unit, self.opt.Width, aggro)
				self.frames[unit]:SetScale(self.opt.Scale)
			end
		end
	end	
end

function sRaidFrames:OverHealCalc(unit)
	local bonus = 0
	if self.opt.dynamic_overheal_sort and not Banzai:GetUnitAggroByUnitId(unit) then
		local indicator = self.indicator and self.indicator[unit] and self.indicator[unit]
		if indicator and indicator > 0 then
			bonus = bonus + 15*indicator
		end
	end
	return bonus
end

function sRaidFrames:OrderCalc(unit)
	local order = 0
	local id_str = string.gsub(unit,"raid","")
	local id_fix = tonumber(id_str)
	local group_order = self.UnitSortOrder[id_fix]

	order = group_order/10000
	
	if self.opt.dynamic_aggro_sort and not Banzai:GetUnitAggroByUnitId(unit) then
		order = order + 200
	end
	
	return order
end

function sRaidFrames:UnitModHP(unit)
	local percent = nil
	local treshhold = 3
	
	local order = self:OrderCalc(unit)
	local overheal = self:OverHealCalc(unit)
	
	if UnitHealth(unit) <= 1 or not UnitIsConnected(unit) then
		percent = 1000
	else
		local health = math.ceil(Zorlen_HealthPercent(unit))
		local health_old = self.UnitFocusHPArray[unit]

		if health_old and health and health_old ~= health and health ~= 100 and math.abs(health - health_old) <= treshhold then ---fixed
			health = health_old
		else
			self.UnitFocusHPArray[unit] = health
		end

		if health >= 100 then
			--
		elseif overheal > 0 and (health + overheal) >= 100 then
			health = 99
		else
			health = health + overheal
		end

		if self.opt.dynamic_range_sort and self.UnitRangeArray[unit] ~= "" then
			percent = health + order
		else
			percent = health + order + 800
		end
	end

	return percent
end

function sRaidFrames:CheckRangeHpCalc(unit)
	return Zorlen_HealthPercent(unit) + self:OrderCalc(unit)
end

function sRaidFrames:CheckRangeFocus(unit, mode)
	if not self.opt.fill_range then
		return nil
	end
	
	if mode == "sort" then
		table.sort(self.UnitRangeFocus, function(a,b) return self:CheckRangeHpCalc(a) < self:CheckRangeHpCalc(b) end)
		return
	elseif mode == "reset" then
		Compost:Reclaim(self.UnitRangeFocus)
		self.UnitRangeFocus = Compost and Compost:Acquire() or {}
		return
	end
	
	local hplimit = self.opt.hp_limit or 100
	local check1 = UnitIsConnected(unit) and hplimit >= Zorlen_HealthPercent(unit) and UnitHealth(unit) > 1 or self.opt.dynamic_aggro_sort and Banzai:GetUnitAggroByUnitId(unit)
	local check2 = self.UnitRangeArray[unit] ~= ""

	if mode == "add" then
		if check1 and check2 and not self:CheckFocusUnit(unit) then
			table.insert(self.UnitRangeFocus, unit)
		end
		
	elseif mode == "check" then
		if check1 and check2 then
			local units_limit = self.opt.units_limit or 5
			for blockindex,blockmatch in pairs(self.UnitRangeFocus) do
				if blockmatch == unit and blockindex <= units_limit then
					return true
				end
			end
		end
		return nil
	end	
end

function sRaidFrames:CheckFocusUnit(unit)
	if not unit then 
		return 
	end
	local name = UnitName(unit)
	if not name then 
		return
	end	
	
	if self.UnitFocusArray[name] or self:CheckRangeFocus(unit, "check") then
		return true	
	end
	
	return nil
end

function sRaidFrames:AddRemoveFocusUnit(unit)
	local err_txt = "Unit not in Group"
	if UnitExists(unit) then	
		if Zorlen_isEnemy(unit)  then
			err_txt = "Unit Has no Target"
			if UnitExists(unit.."target") and UnitIsFriend(unit.."target", "player") then
				unit = unit.."target"
			end	
		end
	end
	
	local name = UnitName(unit)

	local _, classFileName = UnitClass(unit)
	--local color = self.classColors[classFileName]
	local color = self.RAID_CLASS_COLORS[classFileName].colorStr
	
	if self.UnitFocusArray[name] then
		self.UnitFocusArray[name] = nil
		UIErrorsFrame:Clear()
		UIErrorsFrame:AddMessage(color.."Remove Focus: "..name)
		
		self:UpdateVisibility()
		self:LoadStyle()
		
		return
	end
	
	local unit = roster:GetUnitIDFromName(name)
	
	if unit then 
		self.UnitFocusArray[name] = true
		UIErrorsFrame:Clear()
		UIErrorsFrame:AddMessage(color.."Add Focus : "..name)

		self:UpdateVisibility()
		self:LoadStyle()
	else
		UIErrorsFrame:Clear()
		UIErrorsFrame:AddMessage("|cFFFF0000"..err_txt)
	end
	return
end