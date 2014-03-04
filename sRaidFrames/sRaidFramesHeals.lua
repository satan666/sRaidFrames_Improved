local RL = AceLibrary("RosterLib-2.0")
local BS = AceLibrary("Babble-Spell-2.2")
local Banzai = AceLibrary("Banzai-1.0")

sRaidFramesHeals = sRaidFrames:NewModule("sRaidFramesHeals", "AceComm-2.0", "AceHook-2.0", "AceEvent-2.0")
sRaidFramesHeals.ver = GetAddOnMetadata("sRaidFrames", "Version")

sRaidFramesHeals.WhoHealsWho = {}

local watchSpells = {
	[BS["Holy Light"]] = true,
	[BS["Flash of Light"]] = true,
	[BS["Flash Heal"]] = true,
	[BS["Greater Heal"]] = true,
	[BS["Heal"]] = true,
	[BS["Healing Touch"]] = true,
	[BS["Lesser Healing Wave"]] = true,
	[BS["Healing Wave"]] = true,
	[BS["Regrowth"]] = true,
	[BS["Prayer of Healing"]] = true,
	[BS["Lesser Heal"]] = true
}

local spellTimers = {
	["Holy Light"] = 2.5,
	["Flash of Light"] = 1.5,
	["Flash Heal"] = 1.5,
	["Greater Heal"] = 2.5,  --3s but - 0.5 from talents
	["Heal"] = 2.5,			--3s but - 0.5 from talents
	["Healing Touch"] = 2.5,  --3.5s but - 0.5 from talents and - 0.5 cuz of lower ranks
	["Regrowth"] = 1.9,
	["Lesser Healing Wave"] = 1.5,  
	["Healing Wave"] = 2.5, --3s but - 0.5 from talents
	["Lesser Heal"] = 2
}

	function sRaidFramesHeals:OnInitialize()
		if not Grid then  --need to check if Grid active othervise error 
			self:SetCommPrefix("Grid")
		end	
	end

	function sRaidFramesHeals:OnEnable()
		if not self.tooltip then
			self.tooltip = CreateFrame("GameTooltip", "sRaidFramesHeals_Tooltip", UIParent, "GameTooltipTemplate")
			self.tooltip:SetScript("OnLoad",function() this:SetOwner(WorldFrame, "ANCHOR_NONE") end)
		end
		
		self:Hook("CastSpell") --blocked
		self:Hook("CastSpellByName") --blocked
		--self:Hook("UseAction") --blocked
		self:Hook("SpellTargetUnit")
		self:Hook("SpellStopTargeting")
		--self:Hook("TargetUnit")  -- blocked
		self:HookScript(WorldFrame,"OnMouseDown","sRaidFramesHealsOnMouseDown")
		-- register events
		self:RegisterEvent("SPELLCAST_START")
		self:RegisterEvent("SPELLCAST_STOP")
		self:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF","CombatLogHeal")
		self:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF","CombatLogHeal")
		-- AceComm

		self:RegisterComm("Grid", "GROUP", "OnCommReceive")
		self:RegisterEvent("CHAT_MSG_ADDON", "OnCommReceive_LUNA")
	end
	
	--code taken from HealComm by Luna
	local function strsplit(pString, pPattern)
		local Table = {}
		local fpat = "(.-)" .. pPattern
		local last_end = 1
		local s, e, cap = strfind(pString, fpat, 1)
		while s do
			if s ~= 1 or cap ~= "" then
				table.insert(Table,cap)
			end
			last_end = e+1
			s, e, cap = strfind(pString, fpat, last_end)
		end
		if last_end <= strlen(pString) then
			cap = strfind(pString, last_end)
			table.insert(Table, cap)
		end
		return Table
	end

	function sRaidFramesHeals:CombatLogHeal(msg)
		for helper, spell in string.gfind(msg, "(.+) begins to cast (.+).") do
			if not watchSpells[spell] then return end
			local unitid = RL:GetUnitIDFromName(helper)

			if not helper or not spell or not unitid then return end
			if spell == BS["Prayer of Healing"] then
				self:GroupHeal(helper)
			else
				local u = RL:GetUnitObjectFromUnit(unitid.."target")
				if not u then return end
				-- filter units that are probably not the correct unit
				--if UnitHealth(u.unitid)/UnitHealthMax(u.unitid) < 0.9 or Banzai:GetUnitAggroByUnitId(u.unitid) then
					self:UnitIsHealed(u.name, helper, spellTimers[spell], "log")
				--end
			end
		end
	end

	function sRaidFramesHeals:VerifyDuration(val)
		if val and val < 3.5 and val > 0 then
			return true
		end
		return nil
	end

	function sRaidFramesHeals:OnCommReceive_LUNA(val1, val2, val3, val4)
		if (val1 == "HealComm" or val1 == "healcommComm") and val4 ~= UnitName("player") then
			local result = strsplit(val2,"/")
			if result[1] == "Heal" then	
				local duration = result[4]/1000
				if not self:VerifyDuration(duration) then
					duration = 2
				end
				self:UnitIsHealed(result[2], val4, duration, "luf")			
			elseif val2 == "Healstop" then
				self:CancelScheduledEvent("HealCompleted"..val4);
				self:UnitHealCompleted(val4);
			elseif result[1] == "Healdelay" then
				--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:OnCommReceive_LUNA Healdelay - "..val4)
			end
		end
	end

	function sRaidFramesHeals:OnCommReceive(prefix, sender, distribution, what, who, spell, duration, heal_amount, sufix)
		if sender == UnitName("player") then return end
		if not RL:GetUnitIDFromName(sender) then return end
		
		if duration and self:VerifyDuration(duration) then
			--
		elseif spell and watchSpells[spell] then
			duration = spellTimers[spell]
		end
		
		if not self:VerifyDuration(duration) then
			duration = 2
		end	
		
		if what == "HN" then
			self:UnitIsHealed(who, sender, duration, strlower(prefix))
		elseif what == "HG" then
			self:GroupHeal(sender)
		end
	end
	
	function sRaidFramesHeals:GroupHeal(healer)
		-- TO DO
	end
	
	function sRaidFramesHeals:UnitIsHealed(target_name, caster_name, duration, prefix)
		local unit = RL:GetUnitIDFromName(target_name)
		local check1 = self:IsEventScheduled("HealCompleted"..caster_name)
		local check2 = nil
		
		if not unit then 
			return 
		end
		
		if check1 and (prefix == "log" or prefix ~= "log" and self.WhoHealsWho[caster_name] ~= target_name) then 
			--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitIsHealed x1"..caster_name..target_name.." old "..caster_name..self.WhoHealsWho[caster_name].." "..prefix)
			self:CancelScheduledEvent("HealCompleted"..caster_name);
			self:UnitHealCompleted(caster_name);
			check2 = true
			
		end
		
		if not check1 or check2 then
			--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitIsHealed x2 "..prefix)
			sRaidFrames:ShowHealIndicator(unit)
			self.WhoHealsWho[caster_name] = target_name
			self:ScheduleEvent("HealCompleted"..caster_name, self.UnitHealCompleted, duration, self, caster_name)
		end	
		
	end

	function sRaidFramesHeals:UnitHealCompleted(caster)
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitHealCompleted ")
		local target = self.WhoHealsWho[caster]
		if not target then return end
		
		local unit = RL:GetUnitIDFromName(target)
		if not unit then return end
		
		self.WhoHealsWho[caster] = nil
		sRaidFrames:HideHealIndicator(unit)
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitHealCompleted "..GetUnitName(unit))
	end

	function sRaidFramesHeals:SPELLCAST_START()
		if not self.target and UnitExists("target") and UnitIsFriend("target", "player") then
			self.target = GetUnitName("target")
		end

		if watchSpells[arg1] and self.target then
			--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:SPELLCAST_START "..self.target);

			if self.spell == BS["Prayer of Healing"] then
				self:GroupHeal(playerName)
				if GridStatusHeals then
					GridStatusHeals:SendCommMessage("GROUP", "HG")
				else
					self:SendCommMessage("GROUP", "HG")
				end	
			else
				local spell_start = GetTime()
				local duration = arg2/1000
				local heal_amount = nil
				
				if RL:GetUnitIDFromName(self.target) then
					if GridStatusHeals then
						GridStatusHeals:SendCommMessage("GROUP", "HN", self.target, arg1, duration, heal_amount, "SRF_"..self.ver)
					else
						self:SendCommMessage("GROUP", "HN", self.target, arg1, duration, heal_amount, "SRF_"..self.ver)   
					end	
				end
			end
		end
	end

	function sRaidFramesHeals:SPELLCAST_STOP()
		self.target = nil
	end

	function sRaidFramesHeals:CastSpell(spellId, spellbookTabNum)
		--DEFAULT_CHAT_FRAME:AddMessage("CastSpell");
		self.hooks["CastSpell"](spellId, spellbookTabNum)
		sRaidFramesHeals_Tooltip:SetSpell(spellId, spellbookTabNum)
		local spellName = sRaidFramesHeals_TooltipTextLeft1:GetText()
		if SpellIsTargeting() then 
			self.spell = spellName
		elseif UnitExists("target") then
			self.spell = spellName
			--self.target = UnitName("target")
		end
	end

	function sRaidFramesHeals:CastSpellByName(a1, a2)
		--DEFAULT_CHAT_FRAME:AddMessage("CastSpellByName");
		self.hooks["CastSpellByName"](a1, a2)
		local _, _, spellName = string.find(a1, "^([^%(]+)");
		if spellName then
			if SpellIsTargeting() then
				self.spell = spellName
			else
				self.spell = spellName
				--self.target = UnitName("target") 
			end
		end
	end

	function sRaidFramesHeals:UseAction(a1, a2, a3)
		sRaidFramesHeals_Tooltip:SetAction(a1)
		local spellName = sRaidFramesHeals_TooltipTextLeft1:GetText()
		self.spell = spellName
		self.hooks["UseAction"](a1, a2, a3)
		if GetActionText(a1) or not self.spell then return end
		if SpellIsTargeting() then return
		elseif a3 then
			self.target = UnitName("player")
		elseif UnitExists("target") then
			self.target = UnitName("target")
		end
	end

	function sRaidFramesHeals:SpellTargetUnit(a1)
		
		local shallTargetUnit
		if SpellIsTargeting() then
			shallTargetUnit = true
		end
		self.hooks["SpellTargetUnit"](a1)
		if shallTargetUnit and not SpellIsTargeting() then
			--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:SpellTargetUnit "..UnitName(a1))
			self.target = UnitName(a1)
			
		end
	end

	function sRaidFramesHeals:SpellStopTargeting()
		self.hooks["SpellStopTargeting"]()
		self.spell = nil
		self.target = nil
	end

	function sRaidFramesHeals:TargetUnit(a1)
		self.hooks["TargetUnit"](a1)
		if self.spell and UnitExists(a1) then
			self.target = UnitName(a1)
			--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:TargetUnit");
		end
	end

	function sRaidFramesHeals:sRaidFramesHealsOnMouseDown()
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:sRaidFramesHealsOnMouseDown")
		if self.spell and UnitName("mouseover") then
			self.target = UnitName("mouseover")
		elseif self.spell and GameTooltipTextLeft1:IsVisible() then
			local _, _, name = string.find(GameTooltipTextLeft1:GetText(), "^Corpse of (.+)$")
			if ( name ) then
				self.target = name;
			end
		end
		self.hooks[WorldFrame]["OnMouseDown"]()
	end


	