>> sRaidFrames

patch_0.50 - 40 yard range check support
- 40y range check is only limited to healing classes due its mechanism
- 40y range check require certain spells to be on actionbar(you will be noticed by message if spell missing)
- 40y range check is compatible with standard blizzard target frame or modified agUnitFrames using any others unit_frame addons may cause target flicking and small perfomance drop

patch_0.58 - grid like healing Indicators 
- indicators can be colored differently, it depends on how many heals are casted on unit at same time
  - green: 1
  - yellow: 2
  - orange: 3
  - red: 4 and more

patch 0.61 - focus frame
- focus frame is independable frame that can be modified by adding/removing units
- to add/remove unit, bind key in keybinding menu then target unit and use the function
- added new group sorting method "Fixed Group" it helps to avoid gaps in raid frames when you move unit to focus
- to enable multidrag(moving all frames at once) press alt key

patch 0.66 - class colors
- added class color status bar
- greatly improved focus frame functionality

patch 0.70 - anti overheal focus sort
- reworked range 
- added anti overheal sorting to focus frame
- raid and focus frames are now resizable independably
- implemented agUnitFrames modification by Snelf
- fixed meni bugs

--== IF YOU'RE USING SRF 0.61 AND OLDER IT'S MANDATORY TO DELETE SRF FILES FROM SAVEDVARIABLES FOLDER !!!


>> ag_UnitFrames
 - this version of ag_UnitFrames is modified to be compatible with sRaidFrames 40 yard check

>> Zorlen
-sRaidFrames mandatory dependancy library

>> ClassicMouseover
- mouseover cast compatible with sRaidFrames
- use example /cmast Flash of Light

>> Clique
- everybody knows what clique is


-=cheers Ogrisch



