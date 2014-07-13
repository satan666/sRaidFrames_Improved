BINDING_HEADER_sRaidFrames = "sRaidFrames"

local L = AceLibrary("AceLocale-2.2"):new("sRaidFrames")
local surface = AceLibrary("Surface-1.0") 

sRaidFrames.options = {
	type = "group",
	args = {
		aggro_notification = {
			name = L["_Aggro notification"],
			type = "group",
			desc = L["Aggro notification"],
			args = {
		
				highlight = {
					name = L["Highlight units with aggro"],
					type = "toggle",
					desc = L["Turn the border of units who have aggro red"],
					get = function() return sRaidFrames.opt.aggro end,
					set = function(value)
						sRaidFrames:S("aggro", value)
					end,
					disabled = function() return not sRaidFrames.opt.Border end,
				},
	
			
				redname = {
					name = L["Red name on aggro"],
					type = "toggle",
					desc = L["Enable/Disable name color change on aggro"],
					get = function()
						return sRaidFrames.opt.red
					end,
					set = function(red)
						sRaidFrames:S("red", red)
						
					end,
				},	
			
				
				redbar = {
					name = L["Red status bar"],
					type = "toggle",
					desc = L["Enable/Disable statusbar color change on aggro"],
					get = function()
						return sRaidFrames.opt.redbar
					end,
					set = function(red)
						sRaidFrames:S("redbar", red)
						
					end,
				},	
				
				red_aura = {
					name = L["Red aura"],
					type = "toggle",
					desc = L["Enable/Disable background color change on aggro"],
					get = function()
						return sRaidFrames.opt.aggro_aura
					end,
					set = function(red)
						sRaidFrames:S("aggro_aura", red)
						
					end,
				},	
			}
	
		},
		
		
		heal_indicators = {
			name = L["_Healing indicators"],
			type = "toggle",
			desc = L["Show/Hide incoming heal indicators"],
			get = function()
				return sRaidFrames.opt.heal
			end,
			set = function(heal)
				sRaidFrames:S("heal", heal)
				sRaidFrames:ResetHealIndicators()
			end,
			--order = 3,
		},
		
		
		
		
		pure_view = {
		name = L["_Pure view"],
		type = "group",
		desc = L["Pure view"],
		args = {

				black_status_bar = {
					name = L["Status bar - black color"],
					type = "toggle",
					desc = L["Black colored status bar when friendly unit is targeting you and out of combat"],
					get = function()
						return sRaidFrames.opt.targeting
					end,
					set = function(targeting)
						sRaidFrames:S("targeting", targeting)
					end,
					order = 2,
				},
			
			
				status_bar = {
					name = L["Status bar - class color"],
					type = "toggle",
					desc = L["Class colored status bar"],
					get = function()
						return sRaidFrames.opt.statusbar_color
					end,
					set = function(statusbar_color)
						sRaidFrames:S("statusbar_color", statusbar_color)
					end,
					order = 1,
				},
						
				unit_name = {
					name = L["Unit name - class color"],
					type = "toggle",
					desc = L["Class colored unit name"],
					get = function()
						return sRaidFrames.opt.unitname_color
					end,
					set = function(unitname_color)
						sRaidFrames:S("unitname_color", unitname_color)
					end,
					order = 3,
				},


				debuff_aura = {
					name = L["Disable colored debuff aura"],
					type = "toggle",
					desc = L["Disable background color change when unit has debuff"],
					get = function()
						return sRaidFrames.opt.unit_debuff_aura
					end,
					set = function(style)
						sRaidFrames:S("unit_debuff_aura", style)
						sRaidFrames:UpdateVisibility()
						sRaidFrames:LoadStyle()
						
					end,
					order = 4,
				},
				
				bottom_buff = {
					name = L["Disable bottom buff name"],
					type = "toggle",
					desc = L["Disable bottom buff name"],
					get = function()
						return sRaidFrames.opt.show_txt_buff
					end,
					set = function(style)
						sRaidFrames:S("show_txt_buff", style)
						sRaidFrames:UpdateVisibility()
						sRaidFrames:LoadStyle()
						
					end,
					order = 5,
				},
				
				short_names = {
					name = L["Short unit names"],
					type = "toggle",
					desc = L["Reduce unit name to three letters"],
					get = function()
						return sRaidFrames.opt.unit_name_lenght
					end,
					set = function(style)
						sRaidFrames:S("unit_name_lenght", style)
						sRaidFrames:UpdateVisibility()
						sRaidFrames:LoadStyle()
						
					end,
					order = 6,
				},
				
				group_number = {
					name = L["Show group number"],
					type = "toggle",
					desc = L["Add group number to unit name string"],
					get = function()
						return sRaidFrames.opt.grp_name
					end,
					set = function(grp_name)
						sRaidFrames:S("grp_name", grp_name)						
					end,
					order = 7,
				},
				
				vertical_orientation = {
					name = L["Vertical orientation"],
					type = "toggle",
					desc = L["Vertical orientation"],
					get = function()
						return sRaidFrames.opt.vertical_hp
					end,
					set = function(val)
						sRaidFrames:S("vertical_hp", val)
						sRaidFrames:LoadStyle()
					end,
					order = 8,
				},
				
				
			
				
			profiles = {
			name = L["Load pure view profiles"],
			type = "group",
			desc = L["Load predefined profiles"],
			args = {
				profile11 = {
						name = L["Classic - 5 per column"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile11
						end,
						set = function(value)
							if value then
								sRaidFrames:chatToggleBorder(value)
								sRaidFrames.opt.profile22 = not value
								sRaidFrames.opt.profile33 = not value
								sRaidFrames.opt.profile44 = not value
								sRaidFrames:S("Spacing", -4)
								sRaidFrames:S("fixed_count", 5)
								sRaidFrames:S("Width", sRaidFrames.opt.Width_OLD or 70)
								sRaidFrames:S("unit_name_lenght", nil)
								sRaidFrames:S("debuff_slots", 2)
								sRaidFrames:S("buff_slots", 2)
								sRaidFrames:S("vertical_hp", nil)
							end
							sRaidFrames:S("profile11", value)
							sRaidFrames:ProfileFeed()
						end,
						order = 1,
					},
				
				profile22 = {
						name = L["Grid - 5 per column"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile22
						end,
						set = function(value)
							if value then
								sRaidFrames:chatToggleBorder(value)
								sRaidFrames.opt.profile11 = not value
								sRaidFrames.opt.profile33 = not value
								sRaidFrames.opt.profile44 = not value
								sRaidFrames:S("Spacing", -4)
								sRaidFrames:S("fixed_count", 5)
								sRaidFrames:S("Width_OLD", sRaidFrames.opt.Width or 70)
								sRaidFrames:S("Width", 40)
								sRaidFrames:S("unit_name_lenght", true)
								sRaidFrames:S("debuff_slots", 1)
								sRaidFrames:S("buff_slots", 1)
								sRaidFrames:S("vertical_hp", true)
							end
							sRaidFrames:S("profile22", value)
							sRaidFrames:ProfileFeed()
						end,
						order = 4,
					},
					
				profile33 = {
						name = L["Classic - 8 per column"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile33
						end,
						set = function(value)
							if value then
								sRaidFrames:chatToggleBorder(value)
								sRaidFrames.opt.profile11 = not value
								sRaidFrames.opt.profile22 = not value
								sRaidFrames.opt.profile44 = not value
								sRaidFrames:S("Spacing", -4)
								sRaidFrames:S("fixed_count", 8)
								sRaidFrames:S("Width", sRaidFrames.opt.Width_OLD or 70)
								sRaidFrames:S("unit_name_lenght", nil)
								sRaidFrames:S("debuff_slots", 2)
								sRaidFrames:S("buff_slots", 2)
								sRaidFrames:S("vertical_hp", nil)
							end
							sRaidFrames:S("profile33", value)
							sRaidFrames:ProfileFeed()

						end,
						order = 2,
					},	
					
				profile44 = {
						name = L["Classic - 20 per column"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile44
						end,
						set = function(value)
							if value then
								sRaidFrames:chatToggleBorder(value)
								sRaidFrames.opt.profile11 = not value
								sRaidFrames.opt.profile22 = not value
								sRaidFrames.opt.profile33 = not value
								sRaidFrames:S("Spacing", -4)
								sRaidFrames:S("fixed_count", 20)
								sRaidFrames:S("Width", sRaidFrames.opt.Width_OLD or 70)
								sRaidFrames:S("unit_name_lenght", nil)
								sRaidFrames:S("debuff_slots", 2)
								sRaidFrames:S("buff_slots", 2)
								sRaidFrames:S("vertical_hp", nil)
							end
							sRaidFrames:S("profile44", value)
							sRaidFrames:ProfileFeed()
						end,
						order = 3,
					},		
					
								
					}
					
				},
			}
		},		
						
						
						
						

		focus = {
			name = L["_Focus frame"],
			type = "group",
			desc = L["Use keybinding to add/remove units manually or select Polpulate with range feature"],
			args = {

				growth_focus = {
					name = L["Growth"],
					type = "text",
					desc = L["Set the growth of the raid frames"],
					order = 4,
					get = function()
						return sRaidFrames.opt.Growth_Focus
					end,
					set = function(value)
						sRaidFrames:S("Growth_Focus", value)
						sRaidFrames:UpdateVisibility()
					end,
					validate = {["up"] = L["Up"], ["down"] = L["Down"], ["left"] = L["Left"], ["right"] = L["Right"]},
					
				},
				
				lock_focus = {
					name = L["Lock"],
					type = "toggle",
					desc = L["Lock/Unlock the raid frames"],
					get = function()
						return sRaidFrames.opt.lock_focus
					end,
					set = function(locked)
						sRaidFrames:S("lock_focus", locked)
						if not locked then
							sRaidFrames:S("ShowGroupTitles_Focus", true)
							f = sRaidFrames.groupframes[9]
							if not locked and f:IsVisible() then
								f.title:Show()
							else
								f.title:Hide()
							end
							
						end
					end,
					map = {[false] = L["Unlocked"], [true] = L["Locked"]},
					order = 1,
				},
				
				titles_focus = {
					name = L["Show group titles"],
					type = "toggle",
					desc = L["Toggle display of titles above each group frame"],
					get = function()
						return sRaidFrames.opt.ShowGroupTitles_Focus
					end,
					set = function(value)
						sRaidFrames:S("ShowGroupTitles_Focus", value)
						f = sRaidFrames.groupframes[9]
						if value and f:IsVisible() then
							f.title:Show()
						else
							f.title:Hide()
						end
						
					end,
					disabled = function() return not sRaidFrames.opt.lock_focus end,
					order = 2,
				},
				
				
				
				sort_focus = {
				name = L["Sort focus"],
				type = "group",
				desc = L["Sort focus"],
				order = 4,
				args = {	
					
					sort_focus_hp = {
						name = L["Dynamic sort lvl1 - health"],
						type = "toggle",
						desc = L["Dynamic sort lvl1 - health"],
						get = function()
							return sRaidFrames.opt.dynamic_sort
						end,
						set = function(sort)
							sRaidFrames:S("dynamic_sort", sort)
							
							if not sort then
								sRaidFrames.opt.dynamic_range_sort = sort
								sRaidFrames.opt.dynamic_overheal_sort = sort
								sRaidFrames.opt.dynamic_aggro_sort = sort
							end	
							
						end,
					},
					
					sort_focus_range = {
						name = L["Dynamic sort lvl2 - range"],
						type = "toggle",
						desc = L["Dynamic sort lvl2 - range"],
						get = function()
							return sRaidFrames.opt.dynamic_range_sort
						end,
						set = function(sort)
							sRaidFrames:S("dynamic_range_sort", sort)
							if sort  then
								sRaidFrames.opt.dynamic_sort = sort
							else
								sRaidFrames.opt.dynamic_overheal_sort = sort
							end		
						end,
					},
					
					
					sort_focus_overheal = {
						name = L["Dynamic sort lvl3 - anti overheal"],
						type = "toggle",
						desc = L["Dynamic sort lvl3 - anti overheal"],
						get = function()
							return sRaidFrames.opt.dynamic_overheal_sort
						end,
						set = function(sort)
							sRaidFrames:S("dynamic_overheal_sort", sort)
							if sort then
								sRaidFrames.opt.dynamic_sort = sort
								sRaidFrames.opt.dynamic_range_sort = sort
							end		
						end,
					},
					
					
					sort_focus_aggro = {
						name = L["Aggro units on top"],
						type = "toggle",
						desc = L["Aggro units on top"],
						get = function()
							return sRaidFrames.opt.dynamic_aggro_sort
						end,
						set = function(sort)
							sRaidFrames:S("dynamic_aggro_sort", sort)
							if sort  then
								sRaidFrames.opt.dynamic_sort = sort
							end		
						end,
					},
					
					
				}
			},
	
				
				range_populate = {
				name = L["Populate with range"],
				type = "group",
				desc = L["Automatically populate focus frame with units in range"],
				order = 5,
				args = {
					
					
					fill_range = {
						name = L["Populate with range"],
						type = "toggle",
						desc = L["Automatically populate focus frame with units in range"],
						get = function()
							return sRaidFrames.opt.fill_range
						end,
						set = function(set)
							if set then
								sRaidFrames.opt.dynamic_sort = set
								if not sRaidFrames.opt.RangeCheck and not sRaidFrames.opt.ExtendedRangeCheck and not sRaidFrames.opt.ExtendedRangeCheckCombat then
									sRaidFrames.opt.ExtendedRangeCheckCombat = set
								end		
							end
							sRaidFrames:S("fill_range", set)
							sRaidFrames:UpdateVisibility()
							sRaidFrames:LoadStyle()
						end,
					},
					
					
					hp_limit = {
						name = L["Set unit HP filter"],
						type = "range",
						desc = L["Unit filtering treshold"],
						min = 1,
						max = 100,
						step = 1,
						get = function()
							return sRaidFrames.opt.hp_limit
						end,
						set = function(set)
							sRaidFrames:S("hp_limit", set)
						end,
					},
					
					fill_range_limit = {
						name = L["Units limit number"],
						type = "range",
						desc = L["Units limit number"],
						min = 1,
						max = 40,
						step = 1,
						get = function()
							return sRaidFrames.opt.units_limit 
						end,
						set = function(set)
							sRaidFrames:S("units_limit", set)
						end,
					},
				
				}
				},
					
				
				
				
				focus_size = {
				name = L["Size"],
				type = "group",
				desc = L["Size"],
				order = 3,
				args = {
			
					width_focus = {
						name = L["Width"],
						type = "range",
						desc = L["Width"],
						min = 40,
						max = 150,
						step = 1,
						get = function()
							return sRaidFrames.opt.WidthFocus
						end,
						set = function(set)
							sRaidFrames:S("WidthFocus", set)
							sRaidFrames:LoadStyle()
						end,
					},
					
					height_focus = {
						name = L["Scale"],
						type = "range",
						desc = L["Scale"],
						min = 0.1,
						max = 3,
						step = 0.05,
						get = function()
							return sRaidFrames.opt.ScaleFocus
						end,
						set = function(set)
							sRaidFrames:S("ScaleFocus", set)
							sRaidFrames:LoadStyle()
						end,
					},

				}
				},
				
				
			profiles = {
			name = L["Load focus profiles"],
			type = "group",
			desc = L["Load predefined profiles"],
			args = {
				
			
				profile1 = {
						name = L["Common"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile1
						end,
						set = function(value)
							if value then
								sRaidFrames.opt.dynamic_aggro_sort = not value
								sRaidFrames.opt.fill_range = not value
								
								sRaidFrames.opt.dynamic_sort = value
								sRaidFrames.opt.dynamic_range_sort = value

								sRaidFrames:UpdateAllUnits()
								sRaidFrames:Sort()
								
								sRaidFrames.opt.profile2 = not value
								sRaidFrames.opt.profile3 = not value
								sRaidFrames.opt.profile4 = not value
							end
							sRaidFrames:S("profile1", value)
							sRaidFrames:LoadStyle()
						end,
						order = 1,
					},
				
				profile2 = {
						name = L["Aggro"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile2
						end,
						set = function(value)
							if value then
								sRaidFrames.opt.dynamic_aggro_sort = value
								sRaidFrames.opt.fill_range = value
								
								sRaidFrames.opt.hp_limit = 1
								sRaidFrames.opt.units_limit = 5
								
								sRaidFrames:UpdateAllUnits()
								sRaidFrames:Sort()
								
								sRaidFrames.opt.profile1 = not value
								sRaidFrames.opt.profile3 = not value
								sRaidFrames.opt.profile4 = not value
							end
							sRaidFrames:S("profile2", value)
							sRaidFrames:LoadStyle()
						end,
						order = 2,
					},
					
				profile3 = {
						name = L["Healer"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile3
						end,
						set = function(value)
							if value then
								sRaidFrames.opt.fill_range = value
								sRaidFrames.opt.dynamic_range_sort = value
								sRaidFrames.opt.dynamic_overheal_sort = value
								sRaidFrames.opt.dynamic_sort = value
								sRaidFrames.opt.dynamic_aggro_sort = not value
								
								sRaidFrames.opt.hp_limit = 100
								sRaidFrames.opt.units_limit = 5
								
								sRaidFrames:UpdateAllUnits()
								sRaidFrames:Sort()

								sRaidFrames.opt.profile1 = not value
								sRaidFrames.opt.profile2 = not value
								sRaidFrames.opt.profile4 = not value
							end
							sRaidFrames:S("profile3", value)
							sRaidFrames:LoadStyle()
						end,
						order = 3,
					},	
				--[[	
				profile4 = {
						name = L["Healer2"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile4
						end,
						set = function(value)
							if value then
								sRaidFrames.opt.fill_range = value
								sRaidFrames.opt.dynamic_range_sort = value
								sRaidFrames.opt.dynamic_overheal_sort = value
								sRaidFrames.opt.dynamic_sort = value
								sRaidFrames.opt.dynamic_aggro_sort = not value
								
								sRaidFrames.opt.hp_limit = 100
								sRaidFrames.opt.units_limit = 5
								
								sRaidFrames:UpdateAllUnits()
								sRaidFrames:Sort()

								sRaidFrames.opt.profile1 = not value
								sRaidFrames.opt.profile2 = not value
								sRaidFrames.opt.profile3 = not value
							end
							sRaidFrames:S("profile4", value)
						end,
						order = 4,
					},		
					--]]
								
					}
					
				},
	
			}
			
		},	



	
		lock = {
			name = L["Lock"],
			type = "toggle",
			desc = L["Lock/Unlock the raid frames"],
			get = function()
				return sRaidFrames.opt.lock
			end,
			set = function(locked)
				sRaidFrames:S("lock", locked)
				if not locked then
					sRaidFrames:S("ShowGroupTitles", true)
					for cnt,f in pairs(sRaidFrames.groupframes) do
						if cnt ~= 9 then	
							if not locked and f:IsVisible() then
								f.title:Show()
							else
								f.title:Hide()
							end
						end	
					end
				end
			end,
			map = {[false] = L["Unlocked"], [true] = L["Locked"]},
			order = 1,
		},

		srfhideparty = {
			name = L["_Hide party interface"],
			type = "toggle",
			desc = L["Hide party interface in raid - Blizzard's version may fail sometimes"],
			get = function()
				return sRaidFrames.opt.srfhideparty
			end,
			set = function(value)
				if value and UnitInRaid("player") then
					HidePartyFrame();
				end	
				sRaidFrames:S("srfhideparty", value)
			end,
		},

		health = {
			name = L["Health text"],
			type = "text",
			desc = L["Set health display type"],
			get = function()
				return sRaidFrames.opt.healthDisplayType
			end,
			set = function(value)
				sRaidFrames:S("healthDisplayType", value)
			end,
			validate = {["curmax"] = L["Current and max health"], ["deficit"] = L["Health deficit"], ["percent"] = L["Health percentage"], ["current"] = L["Current health"], ["none"] = L["Hide health text"]},
		},

		

		titles = {
			name = L["Show group titles"],
			type = "toggle",
			desc = L["Toggle display of titles above each group frame"],
			get = function()
				return sRaidFrames.opt.ShowGroupTitles
			end,
			set = function(value)
				sRaidFrames:S("ShowGroupTitles", value)
				for cnt,f in pairs(sRaidFrames.groupframes) do
					if cnt ~= 9 then
						if value and f:IsVisible() then
							f.title:Show()
						else
							f.title:Hide()
						end
					end	
				end
			end,
			disabled = function() return not sRaidFrames.opt.lock end,
			order = 2,
		},

		subsort = {
			name = L["Member sort order"],
			type = "text",
			desc = L["Select how you wish to sort the members of each group"],
			get = function()
				return sRaidFrames.opt.SubSort
			end,
			set = function(value)
				sRaidFrames:S("SubSort", value)
				sRaidFrames:Sort()
			end,
			validate = {["name"] = L["By name"], ["class"] = L["By class"], ["none"] = L["By group"]},
			order = 4,
		},




		sorting_method = {
			name = L["Group by"],
			type = "group",
			desc = L["Select how you wish to show the groups"],
			order = 3,
			args = {


			sort = {
				name = L["Group by"],
				type = "text",
				desc = L["Select how you wish to show the groups"],
				order = 1,
				get = function()
					return sRaidFrames.opt.SortBy
				end,
				set = "chatSortBy",
				validate = {["group"] = L["By group"], ["class"] = L["By class"], ["fixed"] = L["Grid like"]},
			},
			
			
			per_column = {
					name = L["Units per column"],
					type = "range",
					desc = L["Set max number of units in column - effect only if Grid like group sort is enabled"],
					min = 3,
					max = 20,
					step = 1,
					get = function()
						return sRaidFrames.opt.fixed_count
					end,
					set = function(set)
						sRaidFrames:S("fixed_count", set)
						sRaidFrames:LoadStyle()
					end,
					order = 2,
				},
				
			dead_sort = {
				name = L["Dead and offline units sub sort"],
				type = "toggle",
				desc = L["Dead or offline units are moved to the bottom of frame - effect only if Grid like group sort is enabled"],
				get = function()
					return sRaidFrames.opt.dead_sort
				end,
				set = function(value)
					sRaidFrames:S("dead_sort", value)
				end,
				order = 3,
			},	
				
			
		}
		},






		buffsdebuffs = {
			name = L["_Buffs/Debuffs"],
			type = "group",
			desc = L["Buffs/Debuffs"],
			args = {
			
			
			
			bufffilter = {
				name = L["Buff filter"],
				type = "group",
				desc = L["Set buff filter"],
				args = {
					add = {
						name = L["Add buff"],
						type = "text",
						desc = L["Add a buff"],
						get = false,
						set = function(value)
							if not sRaidFrames.opt.BuffFilter[value] then
								sRaidFrames.opt.BuffFilter[value] = true
								sRaidFrames:chatUpdateBuffMenu()
							end
						end,
						usage = L["<name of buff>"],
					},
				},
				disabled = function() return (sRaidFrames.opt.BuffType == "debuffs" or sRaidFrames.opt.BuffType == "nothing") end,
				order = 4,
			},
			
			debufffilter = {
				name = L["Debuff filter"],
				type = "group",
				desc = L["Set debuff filter"],
				args = {
					add = {
						name = L["Add debuff"],
						type = "text",
						desc = L["Add a debuff"],
						get = false,
						set = function(value)
							if not sRaidFrames.opt.DebuffFilter[value] then
								sRaidFrames.opt.DebuffFilter[value] = true
								sRaidFrames:chatUpdateDebuffMenu()
							end
						end,
						usage = L["<name of debuff>"],
					},
				},
				disabled = function() return (sRaidFrames.opt.BuffType == "buffs" or sRaidFrames.opt.BuffType == "nothing") end,
				order = 4,
			},
			
			
			bufftype = {
				name = L["Buff/Debuff visibility"],
				type = "text",
				desc = L["Show buffs or debuffs on the raid frames"],
				get = function()
					return sRaidFrames.opt.BuffType
				end,
				set = "chatBuffType",
				validate = {["buffs"] = L["Only buffs"], ["debuffs"] = L["Only debuffs"], ["nothing"] = L["Nothing"], ["buffsanddebuffs"] = L["Buffs and debuffs"]},
				order = 1,
			},
			
			buff_slot = {
						name = L["Buff/debuff slot number"],
						type = "range",
						desc = L["Set max number of buffs and debuffs"],
						min = 1,
						max = 4,
						step = 1,
						get = function()
							return sRaidFrames.opt.buff_slots
						end,
						set = function(set)
							sRaidFrames:S("buff_slots", set)
						end,
						order = 2,
					},
			
			growth = {
				name = L["Growth"],
				type = "text",
				desc = L["Set the growth of the buffs/debuffs"],
				get = function()
					return sRaidFrames.opt.Buff_Growth
				end,
				set = function(value)
					sRaidFrames:S("Buff_Growth", value)
					sRaidFrames:LoadStyle()
				end,
				validate = {["down"] = L["Down"], ["left"] = L["Left"], ["combined"] = L["Combined"]},
				order = 3,
			},

			
			filterbuffs = {
				name = L["Show filtered buffs"],
				type = "toggle",
				desc = L["Toggle display of filtered buffs"],
				get = function()
					return sRaidFrames.opt.ShowFilteredBuffs
				end,
				set = function(set)
					sRaidFrames:S("ShowFilteredBuffs", set)
				end,	
				--disabled = function() return not (sRaidFrames.opt.BuffType ~= "buffs" or sRaidFrames.opt.BuffType ~= "nothing") end,
				order = 4
			},
			
			filterdebuffs = {
				name = L["Show filtered debuffs"],
				type = "toggle",
				desc = L["Toggle display of filtered debuffs"],
				get = function()
					return sRaidFrames.opt.ShowFilteredDebuffs
				end,
				set = function(set)
					sRaidFrames:S("ShowFilteredDebuffs", set)
				end,	
				--disabled = function() return not (sRaidFrames.opt.BuffType ~= "buffs" or sRaidFrames.opt.BuffType ~= "nothing") end,
				order = 5
			},

			
			dispellable_debuffs = {
				name = L["Show dispellable debuffs"],
				type = "toggle",
				desc = L["Toggle display of dispellable debuffs"],
				get = function()
					return sRaidFrames.opt.ShowOnlyDispellable
				end,
				set = "chatToggleDispellable",
				disabled = function() return not (sRaidFrames.opt.BuffType ~= "buffs" or sRaidFrames.opt.BuffType ~= "nothing") end,
				order = 6
			},
		
			dispellable_debuffs_range = {
				name = L["Show dispellable debuffs within range"],
				type = "toggle",
				desc = L["Toggle display debuffs within 28Y range"],
				get = function()
					return sRaidFrames.opt.ShowDebuffsOnlyRange
				end,
				set = "chatToggleDispellableRange",
				disabled = function() return not sRaidFrames.opt.ShowOnlyDispellable end,
				order = 7
			},	
		}
		},

		powerfilter = {
			name = L["Power type visiblity"],
			type = "group",
			desc = L["Toggle the display of certain power types (Mana, Rage, Energy)"],
			args = {
				mana = {
					name = L["Mana"],
					type = "toggle",
					desc = L["Toggle the display of mana bars"],
					get = function()
						return sRaidFrames.opt.PowerFilter[0]
					end,
					set = function(value)
						sRaidFrames.opt.PowerFilter[0] = value
						sRaidFrames:UpdateAllUnits()
						sRaidFrames:LoadStyle()
					end,
					map = {[false] = L["hidden"], [true] = L["shown"]},

				},
				energy = {
					name = L["Energy & Focus"],
					type = "toggle",
					desc = L["Toggle the display of energy and focus bars"],
					get = function()
						return sRaidFrames.opt.PowerFilter[2]
					end,
					set = function(value)
						sRaidFrames.opt.PowerFilter[2] = value
						sRaidFrames.opt.PowerFilter[3] = value
						sRaidFrames:UpdateAllUnits()
						sRaidFrames:LoadStyle()
					end,
					map = {[false] = L["hidden"], [true] = L["shown"]},
				},
				rage = {
					name = L["Rage"],
					type = "toggle",
					desc = L["Toggle the display of rage bars"],
					get = function()
						return sRaidFrames.opt.PowerFilter[1]
					end,
					set = function(value)
						sRaidFrames.opt.PowerFilter[1] = value
						sRaidFrames:UpdateAllUnits()
						sRaidFrames:LoadStyle()
					end,
					map = {[false] = L["hidden"], [true] = L["shown"]},
				},
			},
		},

		
		invert = {
			name = L["Invert health bars"],
			type = "toggle",
			desc = L["Invert the growth of the health bars"],
			get = function()
				return sRaidFrames.opt.Invert
			end,
			set = function(value)
				sRaidFrames.opt.Invert = value
				sRaidFrames:UpdateUnit(sRaidFrames.visible)
			end,
		},

		texture = {
			name = L["Bar textures"],
			type = "text",
			desc = L["Set the texture used on health and mana bars"],
			get = function()
				return sRaidFrames.opt.Texture
			end,
			set = "chatTexture",
			validate = surface:List(),
			order = 6,
		},

		
		size = {
				name = L["Frame size"],
				type = "group",
				desc = L["Size of the raid frames"],
				order = 6, 
				args = {
		
			width = {
				name = L["Width"],
				type = "range",
				desc = L["Width"],
				min = 40,
				max = 150,
				step = 1,
				get = function()
					return sRaidFrames.opt.Width
				end,
				set = function(set)
					sRaidFrames:S("Width", set)
					sRaidFrames:LoadStyle()
				end,
			},
		
		
			scale = {
				name = L["Scale"],
				type = "range",
				desc = L["Set the scale of the raid frames"],
				min = 0.1,
				max = 3.0,
				step = 0.05,
				get = function()
					return sRaidFrames.opt.Scale
				end,
				set = "chatScale",
			},
			
			
		}
		},

		layout = {
			name = L["Layout"],
			type = "group",
			desc = L["Set the layout of the raid frames"],
			order = 5,
			args = {
				reset = {
					name = L["Reset layout"],
					type = "execute",
					desc = L["Reset the position of sRaidFrames"],
					func = "ResetPosition"
				},
				predefined = {
					name = L["Predefined Layout"],
					type = "text",
					desc = L["Set a predefined layout for the raid frames"],
					get = function() return nil end,
					set = "chatSetLayout",
					validate = {["ctra"] = L["CT_RaidAssist"], ["horizontal"] = L["Horizontal"], ["vertical"] = L["Vertical"]},
				},
			},
		},

		backgroundcolor = {
			type = "color",
			name = L["Background color"],
			desc = L["Change the background color"],
			get = function()
				local s = sRaidFrames.opt.BackgroundColor
				return s.r, s.g, s.b, s.a
			end,
			set = "chatBackgroundColor",
			hasAlpha = true,
			order = 7,
		},

		bordercolor = {
			type = "color",
			name = L["Border color"],
			desc = L["Change the border color"],
			get = function()
				local s = sRaidFrames.opt.BorderColor
				return s.r, s.g, s.b, s.a
			end,
			set = "chatBorderColor",
			hasAlpha = true,
			disabled = function() return not sRaidFrames.opt.Border end,
			order = 8
		},

		tooltip = {
			name = L["Tooltip display"],
			type = "text",
			desc = L["Determine when a tooltip is displayed"],
			get = function() return sRaidFrames.opt.TooltipMethod end,
			set = function(value)
				sRaidFrames:S("TooltipMethod", value)
			end,
			validate = {["never"] = L["Never"], ["notincombat"] = L["Only when not in combat"], ["always"] = L["Always"]},
		},

		range = {
			name = L["_Range"],
			type = "group",
			desc = L["Set about range"],
			args = {
				enable = {
					name = L["Enable light range check"],
					type = "toggle",
					desc = L["Enable 28y range check in Instances and 40y coordinates dependant range check in Outdoors and Bgs - Suggested when you neither play healing class nor using Blizzard frames, agUnitFrames or LunaUnitFrames"],
					get = function() return sRaidFrames.opt.RangeCheck end,
					set = function(value)
						sRaidFrames:DisableRangeCheck()
						sRaidFrames.opt.RangeCheck = value
						if value then
							sRaidFrames.opt.ExtendedRangeCheck = not value
							sRaidFrames.opt.ExtendedRangeCheckCombat = not value
						end
					end,
					order = 1,
				},
				enable40y = {
					name = L["Enable accurate range check"],
					type = "toggle",
					desc = L["Enable 40y range check that requires certain spells to be on actionbar and Blizzard frames, agUnitFrames or LunaUnitFrames to be present - Only healing classes can use accurate range check"],
					get = function() return sRaidFrames.opt.ExtendedRangeCheck end,
					set = function(value)
						sRaidFrames:DisableRangeCheck()
						sRaidFrames.opt.ExtendedRangeCheck = value
						if value  then
							sRaidFrames.opt.RangeCheck = not value
							sRaidFrames.opt.ExtendedRangeCheckCombat = not value
						end	
					end,
					order = 2,
				},
				
				enable40ycombat = {
					name = L["Enable combined range check"],
					type = "toggle",
					desc = L["Enable 40y accurate range check only in combat otherwise light range check is active"],
					get = function() return sRaidFrames.opt.ExtendedRangeCheckCombat end,
					set = function(value)
						sRaidFrames:DisableRangeCheck()
						sRaidFrames.opt.ExtendedRangeCheckCombat = value
						if value  then
							sRaidFrames.opt.RangeCheck = not value
							sRaidFrames.opt.ExtendedRangeCheck = not value
						end	
					end,
					order = 3,		
				},
				
					debug = {
					name = L["Enable debug"],
					type = "toggle",
					desc = L["Range accuracy calculation, only for testing"],
					get = function() return sRaidFrames.opt.Debug end,
					set = function(value)
						sRaidFrames.opt.Debug = value
					end,
					order = 4,
				},
				
				alpha = {
					name = L["Alpha"],
					type = "range",
					desc = L["The alpha level for units who are out of range"],
					get = function() return sRaidFrames.opt.RangeAlpha end,
					set = function(value)
						sRaidFrames.opt.RangeAlpha = value
					end,
					min  = 0,
					max  = 1,
					step = 0.1,
					order = 5,
					--disabled = function() return not sRaidFrames.opt.RangeCheck end,
				},
				frequency1 = {
					name = L["Range frequency"],
					type = "range",
					desc = L["The interval between which range checks are performed"],
					get = function() return sRaidFrames.opt.RangeFrequency end,
					set = function(value)
						sRaidFrames.opt.RangeFrequency = value
						sRaidFrames:UpdateRangeFrequency(value)
					end,
					min  = 0.2,
					max  = 0.8,
					step = 0.1,
					order = 6,
					--disabled = function() return not sRaidFrames.opt.RangeCheck end,
				},
				
				frequency2 = {
					name = L["Accurate range frequency factor"],
					type = "range",
					desc = L["Increase or decrease time needed for full units scan - if you experience performance drop please increase the value"],
					get = function() return sRaidFrames.opt.AccurateRangeFactor end,
					set = function(value)
						sRaidFrames.opt.AccurateRangeFactor = value
					end,
					min  = 0.04,
					max  = 0.08,
					step = 0.01,
					order = 7,
					--disabled = function() return not sRaidFrames.opt.RangeCheck end,
				},
			},
		},

		filter = {
			name = L["Show Group/Class"],
			type = "group",
			desc = L["Toggle the display of certain Groups/Classes - Active if frames are locked"],
			args = {
				classes = {
					name = L["Classes"],
					type = "group",
					desc = L["Classes"],
					args = {
						warriors = {
							name = L["Warriors"],
							type = "toggle",
							desc = L["Toggle the display of Warriors"],
							get = function()
								return sRaidFrames.opt.ClassFilter["WARRIOR"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["WARRIOR"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						paladins = {
							name = L["Paladins"],
							type = "toggle",
							desc = L["Toggle the display of Paladins"],
							get = function()
								return sRaidFrames.opt.ClassFilter["PALADIN"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["PALADIN"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
							hidden = function() return UnitFactionGroup("player") == "Horde" end,
						},
						shamans = {
							name = L["Shamans"],
							type = "toggle",
							desc = L["Toggle the display of Shamans"],
							get = function()
								return sRaidFrames.opt.ClassFilter["SHAMAN"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["SHAMAN"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
							hidden = function() return UnitFactionGroup("player") == "Alliance" end,
						},
						hunters = {
							name = L["Hunters"],
							type = "toggle",
							desc = L["Toggle the display of Hunters"],
							get = function()
								return sRaidFrames.opt.ClassFilter["HUNTER"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["HUNTER"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						warlocks = {
							name = L["Warlocks"],
							type = "toggle",
							desc = L["Toggle the display of Warlocks"],
							get = function()
								return sRaidFrames.opt.ClassFilter["WARLOCK"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["WARLOCK"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						mages = {
							name = L["Mages"],
							type = "toggle",
							desc = L["Toggle the display of Mages"],
							get = function()
								return sRaidFrames.opt.ClassFilter["MAGE"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["MAGE"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						druids = {
							name = L["Druids"],
							type = "toggle",
							desc = L["Toggle the display of Druids"],
							get = function()
								return sRaidFrames.opt.ClassFilter["DRUID"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["DRUID"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						rogues = {
							name = L["Rogues"],
							type = "toggle",
							desc = L["Toggle the display of Rogues"],
							get = function()
								return sRaidFrames.opt.ClassFilter["ROGUE"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["ROGUE"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						priests = {
							name = L["Priests"],
							type = "toggle",
							desc = L["Toggle the display of Priests"],
							get = function()
								return sRaidFrames.opt.ClassFilter["PRIEST"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["PRIEST"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
					},
				},
				groups = {
					name = L["Groups"],
					type = "group",
					desc = L["Groups"],
					args = {
						group1 = {
							name = L["Group 1"],
							type = "toggle",
							desc = L["Toggle the display of Group 1"],
							get = function()
								return sRaidFrames.opt.GroupFilter[1]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[1] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group2 = {
							name = L["Group 2"],
							type = "toggle",
							desc = L["Toggle the display of Group 2"],
							get = function()
								return sRaidFrames.opt.GroupFilter[2]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[2] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group3 = {
							name = L["Group 3"],
							type = "toggle",
							desc = L["Toggle the display of Group 3"],
							get = function()
								return sRaidFrames.opt.GroupFilter[3]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[3] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group4 = {
							name = L["Group 4"],
							type = "toggle",
							desc = L["Toggle the display of Group 4"],
							get = function()
								return sRaidFrames.opt.GroupFilter[4]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[4] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group5 = {
							name = L["Group 5"],
							type = "toggle",
							desc = L["Toggle the display of Group 5"],
							get = function()
								return sRaidFrames.opt.GroupFilter[5]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[5] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group6 = {
							name = L["Group 6"],
							type = "toggle",
							desc = L["Toggle the display of Group 6"],
							get = function()
								return sRaidFrames.opt.GroupFilter[6]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[6] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group7 = {
							name = L["Group 7"],
							type = "toggle",
							desc = L["Toggle the display of Group 7"],
							get = function()
								return sRaidFrames.opt.GroupFilter[7]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[7] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group8 = {
							name = L["Group 8"],
							type = "toggle",
							desc = L["Toggle the display of Group 8"],
							get = function()
								return sRaidFrames.opt.GroupFilter[8]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[8] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
					},
				},
			},
		},

		growth = {
			name = L["Growth"],
			type = "text",
			desc = L["Set the growth of the raid frames"],
			get = function()
				return sRaidFrames.opt.Growth
			end,
			set = function(value)
				sRaidFrames:S("Growth", value)
				sRaidFrames:UpdateVisibility()
			end,
			validate = {["up"] = L["Up"], ["down"] = L["Down"], ["left"] = L["Left"], ["right"] = L["Right"]},
			order = 5,
		},

		border = {
			name = L["Border"],
			type = "toggle",
			desc = L["Toggle the display of borders around the raid frames"],
			get = function()
				return sRaidFrames.opt.Border
			end,
			order = 9,
			set = function(value)
				sRaidFrames:ResetHealIndicators()
				sRaidFrames:chatToggleBorder(value)
				sRaidFrames:LoadStyle()
			end
		},

		spacing = {
			name = L["Frame spacing"],
			type = "range",
			desc = L["Set the spacing between each of the raid frames"],
			min = -10,
			max = 10,
			step = 1,
			get = function()
				return sRaidFrames.opt.Spacing
			end,
			set = function(value)
				sRaidFrames:S("Spacing", value)
				sRaidFrames:Sort()
			end,
			order = 6,
		},
	}
}

function sRaidFrames:chatUpdateBuffMenu()
	self.options.args.buffsdebuffs.args.bufffilter.args["remove"] = {}
	self.options.args.buffsdebuffs.args.bufffilter.args["remove"].type = 'group'
	self.options.args.buffsdebuffs.args.bufffilter.args["remove"].name = 'Remove buff'
	self.options.args.buffsdebuffs.args.bufffilter.args["remove"].desc = 'Remove buffs from the list'
	self.options.args.buffsdebuffs.args.bufffilter.args["remove"].args = {}
	local i = 1
	--for buff in self.opt.BuffFilter do
	for buff in pairs(self.opt.BuffFilter) do
		local buffName = buff -- Odd hack, don't know
		self.options.args.buffsdebuffs.args.bufffilter.args["remove"].args["buff" .. i] = {}
		self.options.args.buffsdebuffs.args.bufffilter.args["remove"].args["buff" .. i].type = 'execute'
		self.options.args.buffsdebuffs.args.bufffilter.args["remove"].args["buff" .. i].name = buffName
		self.options.args.buffsdebuffs.args.bufffilter.args["remove"].args["buff" .. i].desc = 'Remove '.. buffName .. ' from the buff list'
		self.options.args.buffsdebuffs.args.bufffilter.args["remove"].args["buff" .. i].func = function() self.opt.BuffFilter[buffName] = nil self:chatUpdateBuffMenu()  end
		i = i + 1
	end
end

function sRaidFrames:chatUpdateDebuffMenu()
	self.options.args.buffsdebuffs.args.debufffilter.args["remove"] = {}
	self.options.args.buffsdebuffs.args.debufffilter.args["remove"].type = 'group'
	self.options.args.buffsdebuffs.args.debufffilter.args["remove"].name = 'Remove debuff'
	self.options.args.buffsdebuffs.args.debufffilter.args["remove"].desc = 'Remove debuffs from the list'
	self.options.args.buffsdebuffs.args.debufffilter.args["remove"].args = {}
	local i = 1
	--for buff in self.opt.debufffilter do
	for debuff in pairs(self.opt.DebuffFilter) do
		local debuffName = debuff -- Odd hack, don't know
		self.options.args.buffsdebuffs.args.debufffilter.args["remove"].args["debuff" .. i] = {}
		self.options.args.buffsdebuffs.args.debufffilter.args["remove"].args["debuff" .. i].type = 'execute'
		self.options.args.buffsdebuffs.args.debufffilter.args["remove"].args["debuff" .. i].name = debuffName
		self.options.args.buffsdebuffs.args.debufffilter.args["remove"].args["debuff" .. i].desc = 'Remove '.. debuffName .. ' from the debuff list'
		self.options.args.buffsdebuffs.args.debufffilter.args["remove"].args["debuff" .. i].func = function() self.opt.DebuffFilter[debuffName] = nil self:chatUpdateDebuffMenu()  end
		i = i + 1
	end
end

function sRaidFrames:chatSortBy(value)
	sRaidFrames:S("SortBy", value)
	sRaidFrames:Sort()
end

function sRaidFrames:chatBuffType(value)
	self:S("BuffType", value)

	self:UpdateBuffs(self.visible)
end

function sRaidFrames:chatToggleDispellable(value)
	self:S("ShowOnlyDispellable", value)
	if not value then
		self:S("ShowDebuffsOnlyRange", value)
	end
	self:UpdateBuffs(self.visible)
end

function sRaidFrames:chatToggleDispellableRange(value)
	self:S("ShowDebuffsOnlyRange", value)
	self:UpdateBuffs(self.visible)
end

function sRaidFrames:chatTexture(t)
	self.opt.Texture = t

	for i = 1, MAX_RAID_MEMBERS do
		self.frames["raid" .. i].hpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
		self.frames["raid" .. i].mpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
	end
end

function sRaidFrames:chatScale(t)
	self:S("Scale", t)

	self.master:SetScale(t)
	self:LoadStyle()
end

function sRaidFrames:chatBackgroundColor(r, g, b, a)
	self:S("BackgroundColor", {r = r, g = g, b = b, a = a})

	-- Need to do this, since someone might be debuffed, and so will need a diffirent background color
	self:UpdateBuffs(self.visible)
	self:LoadStyle()
end

function sRaidFrames:chatBorderColor(r, g, b, a)
	self:S("BorderColor", {r = r, g = g, b = b, a = a})

	for k,f in pairs(self.frames) do
		f:SetBackdropBorderColor(r, g, b, a)
	end
end

function sRaidFrames:chatSetLayout(layout)
	self:PositionLayout(layout, self.groupframes[1]:GetLeft(), self.groupframes[1]:GetTop()-UIParent:GetTop())
end

function sRaidFrames:chatToggleBorder(value)
	self:S("Border", value)
	
	for k,f in pairs(self.frames) do
			self:SetBackdrop(f)
	end

	self:UpdateBuffs(self.visible)
	self:ResetHealIndicators("force")
end

function sRaidFrames:DisableRangeCheck()
	--if not sRaidFrames.opt.ExtendedRangeCheck and not sRaidFrames.opt.RangeCheck then
		for unit in pairs(sRaidFrames.frames) do
			sRaidFrames.frames[unit]:SetAlpha(1)
			sRaidFrames.UnitRangeArray[unit] = ""
		end	
	--end					
end		

function sRaidFrames:ProfileFeed()
	sRaidFrames:chatSortBy("fixed")
	sRaidFrames.opt.SubSort = "class"
	
	sRaidFrames.opt.heal = true
	sRaidFrames.opt.RangeAlpha = 0.25
				
	sRaidFrames.opt.PowerFilter[0] = false
	sRaidFrames.opt.PowerFilter[1] = false
	sRaidFrames.opt.PowerFilter[2] = false
	sRaidFrames.opt.PowerFilter[3] = false
								
	sRaidFrames.opt.BackgroundColor.r = 0.3
	sRaidFrames.opt.BackgroundColor.g = 0.3
	sRaidFrames.opt.BackgroundColor.b = 0.3
	sRaidFrames.opt.BackgroundColor.a = 1
	
	
	sRaidFrames:S("unitname_color", true)
	sRaidFrames:S("aggro", true)
	sRaidFrames:S("red", true)
	sRaidFrames:S("redbar", false)

	sRaidFrames:S("Texture", "Gradient")

	sRaidFrames:LoadStyle()
end

					
function xxx()
DEFAULT_CHAT_FRAME:AddMessage(sRaidFrames.opt.BackgroundColor.r..sRaidFrames.opt.BackgroundColor.g..sRaidFrames.opt.BackgroundColor.b)

end