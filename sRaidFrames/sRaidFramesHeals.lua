local RL = AceLibrary("RosterLib-2.0")
local BS = AceLibrary("Babble-Spell-2.2")
local Banzai = AceLibrary("Banzai-1.0")

sRaidFramesHeals = sRaidFrames:NewModule("sRaidFramesHeals", "AceComm-2.0", "AceHook-2.0", "AceEvent-2.0")
sRaidFramesHeals.ver = GetAddOnMetadata("sRaidFrames", "Version")

sRaidFramesHeals.WhoHealsWho = {}
sRaidFramesHeals.WhoHealsWhoGroup = {}
sRaidFramesHeals.IgnoreLog = {}


local watchSpells = {
	[BS["Prayer of Healing"]] = true,
	[BS["Chain Heal"]] = true,
	[BS["Holy Light"]] = true,
	[BS["Flash of Light"]] = true,
	[BS["Flash Heal"]] = true,
	[BS["Greater Heal"]] = true,
	[BS["Heal"]] = true,
	[BS["Healing Touch"]] = true,
	[BS["Lesser Healing Wave"]] = true,
	[BS["Healing Wave"]] = true,
	[BS["Regrowth"]] = true,
	[BS["Lesser Heal"]] = true
}

local spellTimers = {
	["Prayer of Healing"] = 3,
	["Chain Heal"] = 2.5,
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
		self:RegisterEvent("SPELLCAST_INTERRUPTED", "SpellInterrupted")
		self:RegisterEvent("SPELLCAST_FAILED", "SpellInterrupted")
		self:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF","CombatLogHeal")
		self:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF","CombatLogHeal")
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "LogReset");
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

	function sRaidFramesHeals:VerifyDuration(val)
		if val and val <= 3.5 and val > 0 then
			return true
		end
		return nil
	end

	function sRaidFramesHeals:LogExamine(mode, caster_name, duration, prefix)
		local check = self.IgnoreLog[caster_name]
		if mode == "add"  then
			if string.find(prefix, "srf") or string.find(prefix, "luf") then
				if not self:VerifyDuration(duration) then
					if check == "pass" then
						self.IgnoreLog[caster_name] = "ban"
					end	
				elseif not check then
					--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:LogExamine - add - "..caster_name)
					self.IgnoreLog[caster_name] = "pass"
				end
			end
		elseif mode == "check" then
			if check == "pass" then
				--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:LogExamine - check - pass - "..caster_name)
				return true
			else
				--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:LogExamine - check - nil - "..caster_name)
				return nil
			end	
		end
	end

	function sRaidFramesHeals:LogReset()
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:LogReset")
		for blockindex,blockmatch in pairs(self.IgnoreLog) do
			self.IgnoreLog[blockindex] = nil
		end
	end

	function sRaidFramesHeals:CombatLogHeal(msg)
		for helper, spell in string.gfind(msg, "(.+) begins to cast (.+).") do
			if not watchSpells[spell] then return end
			local unitid = RL:GetUnitIDFromName(helper)

			if not helper or not spell or not unitid then return end
			
			if self:LogExamine("check", helper) then return end
			
			if spell == BS["Prayer of Healing"] then
				self:UnitIsHealedGroup(helper, 3, "log")
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


	function sRaidFramesHeals:OnCommReceive_LUNA(val1, val2, val3, val4)
		if (val1 == "HealComm" or val1 == "healcommComm") and val4 ~= UnitName("player") then
			local result = strsplit(val2,"/")
			if result[1] == "Heal" then	
				local duration = result[4]/1000
				if not self:VerifyDuration(duration) then
					duration = 2
				end
				self:UnitIsHealed(result[2], val4, duration, "luf")			
			elseif result[1] == "GrpHeal" then	
				local duration = result[3]/1000
				if not self:VerifyDuration(duration) then
					duration = 3
				end
				self:UnitIsHealedGroup(val4, duration, "luf")
			elseif val2 == "Healstop" then
				self:UnitHealCompleted(val4);
			elseif val2 == "GrpHealstop" then	
				self:UnitHealCompletedGroup(val4);
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
		
		if what == "HG" or spell and spell == "Prayer of Healing" then 
			if not self:VerifyDuration(duration) then
				duration = 3
			end
			self:UnitIsHealedGroup(sender, duration, strlower(prefix))

		elseif what == "HN" then
			if not self:VerifyDuration(duration) then
				duration = 2
			end
			self:UnitIsHealed(who, sender, duration, strlower(prefix))
			--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:OnCommReceive - UnitIsHealedGroup "..sender)
		
		elseif what == "STOP_CAST" then
			--DEFAULT_CHAT_FRAME:AddMessage("STOP_CAST - "..sender.." - "..prefix)
			self:UnitHealCompleted(sender);
			self:UnitHealCompletedGroup(sender);
		end
	end

	function sRaidFramesHeals:UnitIsHealedGroup(caster_name, duration, prefix)
		local u1 = RL:GetUnitObjectFromName(caster_name)
		local time = GetTime()
		
		if not caster_name then return end
		if not u1 then return end
		
		if not sRaidFramesHeals.WhoHealsWhoGroup[caster_name] then
			sRaidFramesHeals.WhoHealsWhoGroup[caster_name] = {}
		end
		
		self:LogExamine("add", caster_name, duration, prefix)
		
		if self:IsEventScheduled("HealCompletedGroup"..caster_name) then
			if prefix == "log" then
				self:UnitHealCompletedGroup(caster_name)
			else	
				return
			end	
		end
		
		for u2 in RL:IterateRoster() do
			if u2.subgroup == u1.subgroup and UnitIsConnected(u2.unitid) and not UnitIsDeadOrGhost(u2.unitid) and CheckInteractDistance(u1.unitid, 4) and CheckInteractDistance(u2.unitid, 4) then
				self.WhoHealsWhoGroup[caster_name][u2.name] = true
				sRaidFrames:ShowHealIndicator(u2.unitid)
				
			end
		end
		
		self:ScheduleEvent("HealCompletedGroup"..caster_name, self.UnitHealCompletedGroup, duration, self, caster_name)
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitIsHealedGroup - "..prefix)
	end
	
	function sRaidFramesHeals:UnitHealCompletedGroup(caster_name)
		if not caster_name then return end
		if not self.WhoHealsWhoGroup[caster_name] then return end
	
		for blockindex,blockmatch in pairs(self.WhoHealsWhoGroup[caster_name]) do
			local unit = RL:GetUnitIDFromName(blockindex)
			
			if unit then
				sRaidFrames:HideHealIndicator(unit)
				
			end
			self.WhoHealsWhoGroup[caster_name][blockindex] = nil
			
		end
		self:CancelScheduledEvent("HealCompletedGroup"..caster_name);
				
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitHealCompletedGroup "..caster_name)
	end

	function sRaidFramesHeals:UnitIsHealed(target_name, caster_name, duration, prefix)
		local unit = RL:GetUnitIDFromName(target_name)
		local check1 = self:IsEventScheduled("HealCompleted"..caster_name)
		local check2 = nil
		
		if not unit then return end
		if not caster_name then return end

		
		self:LogExamine("add", caster_name, duration, prefix)
		
		if self:IsEventScheduled("HealCompletedGroup"..caster_name) then
			self:UnitHealCompletedGroup(caster_name)
		end
		
		if check1 and (prefix == "log" or prefix ~= "log" and self.WhoHealsWho[caster_name] ~= target_name) then 
			--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitIsHealed x1"..caster_name..target_name.." old "..caster_name..self.WhoHealsWho[caster_name].." "..prefix)
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
		self:CancelScheduledEvent("HealCompleted"..caster);
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:UnitHealCompleted "..GetUnitName(unit))
	end

	function sRaidFramesHeals:SPELLCAST_START()
		if not self.target and UnitExists("target") and UnitIsFriend("target", "player") then
			self.target = GetUnitName("target")
		end

		if watchSpells[arg1] then
			local duration = arg2/1000
			local heal_amount = nil
			if arg1 == BS["Prayer of Healing"] then
				if GridStatusHeals then
					GridStatusHeals:SendCommMessage("GROUP", "HG", "", arg1, duration, heal_amount, "srf_"..self.ver)
				else
					self:SendCommMessage("GROUP", "HG", "", arg1, duration, heal_amount, "srf_"..self.ver)
					
				end	
			elseif self.target then
				if RL:GetUnitIDFromName(self.target) then
					if GridStatusHeals then
						GridStatusHeals:SendCommMessage("GROUP", "HN", self.target, arg1, duration, heal_amount, "srf_"..self.ver)
					else
						self:SendCommMessage("GROUP", "HN", self.target, arg1, duration, heal_amount, "srf_"..self.ver)   
					end	
				end
			end
		end
	end

	function sRaidFramesHeals:SPELLCAST_STOP()
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals:SPELLCAST_STOP ");	
		self.target = nil
	end
	
	function sRaidFramesHeals:SpellInterrupted()
		--DEFAULT_CHAT_FRAME:AddMessage("sRaidFramesHeals - SpellInterrupted");
		
		self.target = nil
		if GridStatusHeals then
			GridStatusHeals:SendCommMessage("GROUP", "STOP_CAST")
		else
			self:SendCommMessage("GROUP", "STOP_CAST")   
		end	
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


	