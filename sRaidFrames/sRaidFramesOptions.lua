BINDING_HEADER_sRaidFrames = "sRaidFrames"

local L = AceLibrary("AceLocale-2.2"):new("sRaidFrames")
local surface = AceLibrary("Surface-1.0") 

sRaidFrames.options = {
	type = "group",
	args = {

		
		aggro_notification = {
			name = L["_Aggro notification"],
			type = "group",
			desc = L["Use keybinding to add/remove units"],
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
					name = L["Red names on aggro"],
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
					desc = L["Enable/Disable name color change on aggro"],
					get = function()
						return sRaidFrames.opt.redbar
					end,
					set = function(red)
						sRaidFrames:S("redbar", red)
						
					end,
				},	
				
				
			
			
			}
			

			
			
			
		},
		
		
		

		
		
		
		
		
		class_color = {
					name = L["_Class colors"],
					type = "toggle",
					desc = L["Status Bar - Class colors"],
					get = function()
						return sRaidFrames.opt.class_color
					end,
					set = function(class_color)
						sRaidFrames:S("class_color", class_color)
					end,
				},

		focus = {
			name = L["_Focus frame"],
			type = "group",
			desc = L["Use keybinding to add/remove units"],
			args = {

				growth_focus = {
					name = L["Growth"],
					type = "text",
					desc = L["Set the growth of the raid frames"],
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
					name = L["1) Lock"],
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
				},
				
				titles_focus = {
					name = L["2) Show group titles"],
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
				},
				
				
				
				sort_focus = {
				name = L["Sort focus"],
				type = "group",
				desc = L["Use keybinding to add/remove units"],
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
								sRaidFrames.opt.dynamic_class_sort = sort
								sRaidFrames.opt.dynamic_group_sort = sort
								--sRaidFrames.opt.dynamic_aggro_sort = sort
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
								sRaidFrames.opt.dynamic_class_sort = sort
								sRaidFrames.opt.dynamic_group_sort = sort
								--sRaidFrames.opt.dynamic_aggro_sort = sort
							end		
						end,
					},
					
					
					sort_focus_class = {
						name = L["Dynamic sort lvl3 - class"],
						type = "toggle",
						desc = L["Dynamic sort lvl3 - class"],
						get = function()
							return sRaidFrames.opt.dynamic_class_sort
						end,
						set = function(sort)
							sRaidFrames:S("dynamic_class_sort", sort)
							if sort  then
								sRaidFrames.opt.dynamic_sort = sort
								sRaidFrames.opt.dynamic_range_sort = sort
								sRaidFrames.opt.dynamic_group_sort = not sort
								--sRaidFrames.opt.dynamic_aggro_sort = not sort
							end		
						end,
					},
					
					
					sort_focus_group = {
						name = L["Dynamic sort lvl3 - group"],
						type = "toggle",
						desc = L["Dynamic sort lvl3 - group"],
						get = function()
							return sRaidFrames.opt.dynamic_group_sort
						end,
						set = function(sort)
							sRaidFrames:S("dynamic_group_sort", sort)
							if sort  then
								sRaidFrames.opt.dynamic_sort = sort
								sRaidFrames.opt.dynamic_range_sort = sort
								sRaidFrames.opt.dynamic_class_sort = not sort
								--sRaidFrames.opt.dynamic_aggro_sort = not sort
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
							--if sort  then
								--sRaidFrames.opt.dynamic_sort = sort
								--sRaidFrames.opt.dynamic_range_sort = sort
								--sRaidFrames.opt.dynamic_class_sort = not sort
								--sRaidFrames.opt.dynamic_group_sort = not sort
							--end		
						end,
					},
					
					
				}
			},
	
			--[[
			focus_aura = {
				name = L["Focus aura"],
				type = "group",
				desc = L["Use keybinding to add/remove units"],
				args = {	
	
				
					aura_target_focus = {
						name = L["Special aura - Target"],
						type = "toggle",
						desc = L["Change background color to blue of target unit"],
						get = function()
							return sRaidFrames.opt.aura
						end,
						set = function(aura)
							sRaidFrames:S("aura", aura)
							
						end,
					},
					
					aura_targettarget_focus = {
						name = L["Special aura - Enemy target"],
						type = "toggle",
						desc = L["Change background color to red of enemy target unit"],
						get = function()
							return sRaidFrames.opt.aurax
						end,
						set = function(aurax)
							sRaidFrames:S("aurax", aurax)
							
						end,
					},
					}
				},
				--]]
				
				range_populate = {
				name = L["Populate with range"],
				type = "group",
				desc = L["Automatically populate focus frame with units in range"],
				args = {
					
					
					fill_range = {
						name = L["Populate with range"],
						type = "toggle",
						desc = L["Automatically populate focus frame with units in range"],
						get = function()
							return sRaidFrames.opt.fill_range
						end,
						set = function(set)
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
					
				
				
				extra_width_focus = {
					name = L["3) Extra width"],
					type = "toggle",
					desc = L["Focus frame extra width"],
					get = function()
						return sRaidFrames.opt.extra_width
					end,
					set = function(set)
						sRaidFrames:S("extra_width", set)
						sRaidFrames:LoadProfile()
						sRaidFrames:LoadStyle()
					end,
				},
			}
			
		},	

		compact = {
			name = L["_Pure view"],
			type = "group",
			desc = L["Clear and compact raid frames"],
			args = {
				style = {
					name = L["Compact style"],
					type = "toggle",
					desc = L["Compact style"],
					get = function()
						return sRaidFrames.opt.style
					end,
					set = function(style)
						sRaidFrames:S("style", style)
						
						sRaidFrames:UpdateVisibility()
						sRaidFrames:LoadProfile()
						sRaidFrames:LoadStyle()
						
					end,
				},
			
				profile1 = {
						name = L["Load profile - Normal"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile1
						end,
						set = function(value)
							if value then
								sRaidFrames.opt.profile2 = not value
								sRaidFrames.opt.healthDisplayType = "none"
								sRaidFrames.opt.TooltipMethod = "never"
								sRaidFrames:chatToggleBorder(not value)
								sRaidFrames:chatTexture("BantoBar")
								sRaidFrames:chatSortBy("fixed")
								sRaidFrames.opt.SubSort = "class"
								sRaidFrames.opt.class_color = value
								sRaidFrames.opt.dynamic_sort = value
								sRaidFrames.opt.Spacing = 0
								
								sRaidFrames.opt.PowerFilter[0] = false
								sRaidFrames.opt.PowerFilter[1] = false
								sRaidFrames.opt.PowerFilter[2] = false
								sRaidFrames.opt.PowerFilter[3] = false
								
								sRaidFrames.opt.BackgroundColor.r = 0
								sRaidFrames.opt.BackgroundColor.g = 0
								sRaidFrames.opt.BackgroundColor.b = 0
								sRaidFrames.opt.BackgroundColor.a = 1
								
								sRaidFrames.opt.RangeCheck = value
								sRaidFrames.opt.ExtendedRangeCheck = value
								sRaidFrames.opt.RangeAlpha = 0.3
								sRaidFrames.opt.BuffType = "debuffs"
								sRaidFrames.opt.Invert = not value

								sRaidFrames:UpdateAll()
								sRaidFrames:Sort()

							end
							sRaidFrames:S("profile1", value)
						end,
					},
				
				--[[
				profile2 = {
						name = L["Load profile - Inverted"],
						type = "toggle",
						desc = L["Load predefined settings"],
						get = function()
							return sRaidFrames.opt.profile2
						end,
						set = function(value)
							if value then
								sRaidFrames.opt.profile1 = not value
								sRaidFrames.opt.healthDisplayType = "none"
								sRaidFrames.opt.TooltipMethod = "never"
								sRaidFrames:chatToggleBorder(not value)
								sRaidFrames:chatTexture("BantoBar")
								sRaidFrames:chatSortBy("fixed")
								sRaidFrames.opt.SubSort = "class"
								sRaidFrames.opt.dynamic_sort = value
								sRaidFrames.opt.Spacing = 0
								
								sRaidFrames.opt.PowerFilter[0] = false
								sRaidFrames.opt.PowerFilter[1] = false
								sRaidFrames.opt.PowerFilter[2] = false
								sRaidFrames.opt.PowerFilter[3] = false
								
								sRaidFrames.opt.BackgroundColor.r = 0
								sRaidFrames.opt.BackgroundColor.g = 0
								sRaidFrames.opt.BackgroundColor.b = 0
								sRaidFrames.opt.BackgroundColor.a = 1
								
								sRaidFrames.opt.RangeCheck = value
								sRaidFrames.opt.ExtendedRangeCheck = value
								sRaidFrames.opt.RangeAlpha = 0.3
								sRaidFrames.opt.BuffType = "debuffs"
								sRaidFrames.opt.Invert = value
								
								sRaidFrames:UpdateAll()
								sRaidFrames:Sort()

							end
							sRaidFrames:S("profile2", value)
						end,
					},
					
						--]]
			}
			
		},
	
	
		heal = {
			name = L["_Healing indicators"],
			type = "toggle",
			desc = L["Show/Hide incoming heal indicators"],
			get = function()
				return sRaidFrames.opt.heal
			end,
			set = function(heal)
				sRaidFrames:S("heal", heal)
				
			end,
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
			disabled = function() return (sRaidFrames.opt.BuffType == "debuffs") end,
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
			validate = {["name"] = L["By name"], ["class"] = L["By class"], ["none"] = L["Blizzard default"]},
		},

		sort = {
			name = L["Group by"],
			type = "text",
			desc = L["Select how you wish to show the groups"],
			get = function()
				return sRaidFrames.opt.SortBy
			end,
			set = "chatSortBy",
			validate = {["group"] = L["By group"], ["class"] = L["By class"], ["fixed"] = L["Fixed group"]},
		},

		bufftype = {
			name = L["Buff/Debuff visibility"],
			type = "text",
			desc = L["Show buffs or debuffs on the raid frames"],
			get = function()
				return sRaidFrames.opt.BuffType
			end,
			set = "chatBuffType",
			validate = {["buffs"] = L["Only buffs"], ["debuffs"] = L["Only debuffs"], ["buffsifnotdebuffed"] = L["Buffs if not debuffed"]},
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
						sRaidFrames:UpdateAll()
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
						sRaidFrames:UpdateAll()
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
						sRaidFrames:UpdateAll()
					end,
					map = {[false] = L["hidden"], [true] = L["shown"]},
				},
			},
		},

		filterdebuffs = {
			name = L["Filter dispellable debuffs"],
			type = "toggle",
			desc = L["Toggle display of dispellable debuffs only"],
			get = function()
				return sRaidFrames.opt.ShowOnlyDispellable
			end,
			set = "chatToggleDispellable",
			disabled = function() return not (sRaidFrames.opt.BuffType ~= "buffs") end,
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

		layout = {
			name = L["Layout"],
			type = "group",
			desc = L["Set the layout of the raid frames"],
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
					name = L["Enable range check"],
					type = "toggle",
					desc = L["Enable 40y range check - Outdoors and BGs"],
					get = function() return sRaidFrames.opt.RangeCheck end,
					set = function(value)
						sRaidFrames.opt.RangeCheck = value
						if not value then
							sRaidFrames.opt.ExtendedRangeCheck = value
							for unit in pairs(sRaidFrames.frames) do
								sRaidFrames.frames[unit]:SetAlpha(1)
								sRaidFrames.UnitRangeArray[unit] = ""
							end
						end
					end,
					order = 1,
				},
				enable40y = {
					name = L["Enable dungeon range check"],
					type = "toggle",
					desc = L["Enable 40y range check in Dungeons, requires certain spells to be on actionbar and Blizzard target frame or modifiied agUnitFrames"],
					get = function() return sRaidFrames.opt.ExtendedRangeCheck end,
					set = function(value)
						if value  then
							sRaidFrames.opt.RangeCheck = value
						end	
						sRaidFrames.opt.ExtendedRangeCheck = value
					end,
					order = 2,
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
					disabled = function() return not sRaidFrames.opt.RangeCheck end,
				},
				frequency = {
					name = L["Frequency"],
					type = "range",
					desc = L["The interval between which range checks are performed"],
					get = function() return sRaidFrames.opt.RangeFrequency end,
					set = function(value)
						sRaidFrames.opt.RangeFrequency = value
						sRaidFrames:UpdateRangeFrequency(value)
					end,
					min  = 0.25,
					max  = 1,
					step = 0.25,
					disabled = function() return not sRaidFrames.opt.RangeCheck end,
				},
			},
		},

		filter = {
			name = L["Show Group/Class"],
			type = "group",
			desc = L["Toggle the display of certain Groups/Classes"],
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
		},

		border = {
			name = L["Border"],
			type = "toggle",
			desc = L["Toggle the display of borders around the raid frames"],
			get = function()
				return sRaidFrames.opt.Border
			end,
			set = "chatToggleBorder",
		},

		spacing = {
			name = L["Frame Spacing"],
			type = "range",
			desc = L["Set the spacing between each of the raid frames"],
			min = -5,
			max = 5,
			step = 1,
			get = function()
				return sRaidFrames.opt.Spacing
			end,
			set = function(value)
				sRaidFrames:S("Spacing", value)
				sRaidFrames:Sort()
			end,
		},
	}
}

function sRaidFrames:chatUpdateBuffMenu()
	self.options.args.bufffilter.args["remove"] = {}
	self.options.args.bufffilter.args["remove"].type = 'group'
	self.options.args.bufffilter.args["remove"].name = 'Remove buff'
	self.options.args.bufffilter.args["remove"].desc = 'Remove buffs from the list'
	self.options.args.bufffilter.args["remove"].args = {}
	local i = 1
	for buff in self.opt.BuffFilter do
		local buffName = buff -- Odd hack, don't know
		self.options.args.bufffilter.args["remove"].args["buff" .. i] = {}
		self.options.args.bufffilter.args["remove"].args["buff" .. i].type = 'execute'
		self.options.args.bufffilter.args["remove"].args["buff" .. i].name = buffName
		self.options.args.bufffilter.args["remove"].args["buff" .. i].desc = 'Remove '.. buffName .. ' from the buff list'
		self.options.args.bufffilter.args["remove"].args["buff" .. i].func = function() self.opt.BuffFilter[buffName] = nil self:chatUpdateBuffMenu()  end
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
end

function sRaidFrames:chatBackgroundColor(r, g, b, a)
	self:S("BackgroundColor", {r = r, g = g, b = b, a = a})

	-- Need to do this, since someone might be debuffed, and so will need a diffirent background color
	self:UpdateBuffs(self.visible)
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
end
