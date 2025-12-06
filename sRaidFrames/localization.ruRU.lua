local L = AceLibrary("AceLocale-2.2"):new("sRaidFrames")

-------------------------------------------------------------------------------
-- Russian Localization by shikulja  (proofreading required)                                                   
-- Требуется вычитка 
-- на что стоит обратить внимание:
-- unit/s - игрок/и; frame/s - рамка/и (а не фреймы как многие любят); border/s - границ/ы;
-- 287/288 строка, стоит назвать как нибудь более логично
-- 59 строка не знаю что это, у меня с ошибкой в игре, в конце файла тоже много не переведено, т.к не знаю.
-------------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	["hidden"] = "скрыть",
	["shown"] = "показать",
	
	["_Aggro notification"] = "_Уведомления аггро",
	["Aggro notification"] = "Уведомления аггро",
	["Red name on aggro"] = "Красное имя при аггро",
	["Enable/Disable name color change on aggro"] = "Включить/Отключить изменение цвета имени при аггро",
	["Red status bar"] = "Красная строка состояния",
	["Enable/Disable statusbar color change on aggro"] = "Включить/Отключить изменение цвета строки состояния на аггро",
	["Red aura"] = "Красная аура",
	["Enable/Disable background color change on aggro"] = "Включить/Отключить изменение цвета фона на аггро",
	
	["_Pure view"] = "_Чистый вид", -- ??
	["Pure view"] = "Чистый вид",

	["Status bar - class color"] = "Строка состояния - цвет класса",
	["Class colored status bar"] = "Цвет класса - строка состояния",
	["Unit name - class color"] = "Имя игрока - цвет класса",
	["Class colored unit name"] = "Цвет класса - имя игрока",
	["Status bar - black color"] = "Строка состояния - черный цвет",
	["Black colored status bar when friendly unit is targeting you"] = "Черная строка состояния, когда дружественный игрок нацелен на вас",
	
	["Purple colored status bar when friendly unit is targeted by you"] = "Фиолетовая строка состояния, когда вы целитесь на дружественного игрока",
	["Status bar - purple color"] = "Строка состояния - фиолетовый цвет",
	
	["Vertical orientation"] = "Вертикальная ориентация",
	["Full size statusbar"] = "Полноразмерный статусбар",
	["_Healing indicators"] = "_Индикаторы исцеления",
	["Show/Hide incoming heal indicators"] = "Показать/Скрыть поступающие показатели исцеления",
	["Round"] = "Круг",
	["Square"] = "Квадрат",
	["None"] = "Нет",
	["Apply best settings"] = "Применить лучшие настройки",
	["Load predefined settings for best visual effect"] = "Загрузить готовые настройки для лучшего визуального эффекта",
	
	["_Load profiles"] = "_Загрузить профили",
	["Classic - 5 per column"] = "Классика - по 5 в колонку",
	["Classic - 8 per column"] = "Классика - по 8 в колонку",
	["Classic - 10 per column"] = "Классика - по 10 в колонку",
	["Classic - 20 per column"] = "Классика - по 20 в колонку",
	["Grid - Vertical 8 per column"] = "Сетка - Вертикальная по 8 в колонку",
	["Grid - Horizontal 8 per row"] = "Сетка - Горизонтальная по 8 в ряд",
	["Compact - Vertical 8 per column"] = "Компактная - Вертикальная по 8 в колонку",
	["Compact - Horizontal 8 per row"] = "Компактная - Горизонтальная по 8 в колонку",
	
	["_Focus frame"] = "_Рамка фокуса",
	["Use keybinding to add/remove focus units."] = "Используйте назначение клавиш для добавления/удаления игроков фокусировки.",
	["Add WSG carrier to focus"] = "Добавить WSG перевозчик для фокуса"; -- ??
	["Auto add WSG carrier to focus frame"] = "Автоматически добавлять WSG перевозчик в рамку фокуса", -- ??
	
	["Load predefined settings"] = "Загрузить готовые настройки",
	["Common"] = "Общий",
	["Aggro"] = "Агро",
	["Healer"] = "Лекарь",
	
	["Load focus profiles"] = "Загрузить профили фокусировки",
	["Load predefined profiles"] = "Загрузить готовые настройки",
	
	["Disable colored debuff aura"] = "Отключить цветные дебаффы ауры",
	["Disable background color change when unit has debuff"] = "Отключить изменение цвета фона, когда у игрока имеется дебафф",
	["Disable bottom buff name"] = "Отключить нижнее имя баффа",
	["Short unit names"] = "Короткие имена игроков",
	["Reduce unit name to three letters"] = "Уменьшить имена игроков до трех букв",
	["Show group number"] = "Показать номера групп",
	["Add group number to unit name string"] = "Добавить номер группы в строку имени игрока",
	
	["_Focus frames"] = "_Рамки фокуса",
	["Sort focus"] = "Сортировка фокуса",
	["Dynamic sort lvl1 - health"] = "Динамическая сортировка ур.1 - здоровье",
	["Dynamic sort lvl2 - range"] = "Динамическая сортировка ур.2 - дистанция",
	["Dynamic sort lvl3 - class"] = "Динамическая сортировка ур.3 - класс",
	["Dynamic sort lvl3 - anti overheal"] = "Динамическая сортировка ур.3 - недолеченые",
	["Aggro units on top"] = "Агро игроки сверху",
	
	["Focus aura"] = "Фокус ауры",
	
	["Frame size"] = "Размер рамки",
	["Size"] = "Размер",
	["Size of the raid frames"] = "Размер рейдовых рамок",
	["Scale"] = "Масштаб",
	["Width"] = "Ширина",
	
	
	["Special aura - Target"] = "Особая аура - Цель",
	["Change background color to blue of target unit"] = "Изменить цвет фона на синий цели игрока",
	
	["Special aura - Enemy target"] = "Особая аура - Цель враг",
	["Change background color to red of enemy target unit"] = "Изменить цвет фона на красный для вражеской цели",
	
	["Exclude target unit from sorting"] = "Исключить цель из сортировки",
	["Target on top"] = "Цель сверху" ,
	

	
	["Lock"] = "Зафиксировать";
	["Show group titles"] = "Показать названия групп",
	["Extra width"] = "Дополнительная ширина",
	["Focus frame extra width"] = "Дополнительная ширина для рамки фокуса",
	["Units limit number"] = "Ограничить количество игроков",
	["Units limit number"] = "Ограничить количество игроков",
	

	["Populate with range"] = "Заполнять по дистанции",
	["Automatically populate focus frame with units in range"] = "Автоматически заполнять рамку фокуса с игроками по дистанции",
	
	["Set unit HP filter"] = "Установить фильтр игроков по HP",
	["Unit filtering treshold"] = "Порог фильтрации игроков",
	
	["Requires UI reload"] = "Требуется перезагрузка интерфейса",
	
	["Lock"] = "Зафиксировать",
	["Lock/Unlock the raid frames"] = "Зафиксировать/Разблокировать рамки рейда",
	["Unlocked"] = "Разблокирован",
	["Locked"] = "Зафиксирован",

	["Hide party interface"] = "Скрыть интерфейс группы",
	["Hide party interface in raid - Blizzard's version may fail sometimes"] = "Скрыть интерфейс группы в рейде - версия Blizzard может иногда не работать",

	["Health text"] = "Текст здоровья",
	["Set health display type"] = "Установить тип отображения здоровья",
	["Current and max health"] = "Текущее и максимальное здоровье",
	["Health deficit"] = "Дефицит здоровья",
	["Health percentage"] = "Процент здоровья",
	["Current health"] = "Текущее здоровье",
	["Hide health text"] = "Скрыть текст здоровья",

	["Invert health bars"] = "Инвертировать полосы здоровья",
	["Invert the growth of the health bars"] = "Инвертировать прирост полос здоровья",

	["Buff filter"] = "Фильтр бафов",
	["Set buff filter"] = "Установить фильтр баффов",
	["Add buff"] = "Добавить бафф",
	["Add a buff"] = "Добавить бафф",
	["<name of buff>"] = "<название баффа>",
	
	["Debuff filter"] = "Фильтр дебафов",
	["Set debuff filter"] = "Установить фильтр дебафов",
	["Add debuff"] = "Добавить дебафф",
	["Add a debuff"] = "Добавить дебафф",
	["<name of debuff>"] = "<название дебаффа>",

	["Show group titles"] = "Показать названия групп",
	["Toggle display of titles above each group frame"] = "Переключить отображение заголовков над каждым групповым фреймом",
	["Group subsort"] = "Сортировка подгрупп", -- ??
	["Select how you wish to sort the members of each group"] = "Выбрать, как отсортировать членов каждой группы",
	["By name"] = "По имени",
	["By class"] = "По классу",
	["Grid like"] = "Как в Grid",
	["Blizzard default"] = "Стандартный Blizzard",
	["Group sort"] = "Сортировка групп",
	["Group method"] = "Метод группировки",
	["Dead and offline units sub sort"] = "Мертвые и оффлайн под-сортировка игроков",
	["Dead or offline units are moved to the bottom of frame"] = "Мертвые или оффлайн игроки перемещаются в конец списка",
	["Reverse sort"] = "Обратная сортировка",
	
	["Select how you wish to show the groups"] = "Выберите, как вы хотите показать группы",
	["By group"] = "По группе",
	["By class"] = "По классу",
	["By order"] = "По порядку",
	["Units per column"] = "Игроки на столбец",
	["Set max number of units in column - effect only if Grid like group sort is enabled"] = "Задать максимальное количество игроков в столбце - действует только в том случае, если включена сортировка группы по типу сетки",
	["Pyramid BottomRight"] = "Пирамидой снизу-справа",
	["Pyramid BottomLeft"] = "Пирамидой снизу-слева",
	["Pyramid TopRight"] = "Пирамидой сверху-справа",
	["Pyramid TopLeft"] = "Пирамидой вверху-слева",


	["Anchor"] = "Привязка",
	["Set the anchor of buffs/debuffs"] = "Установить привязку баффов/дебаффов",
	["Set size of buff/debuff texture"] = "Установить размер текстуры баффов/дебаффов",
	["Buff/debuff texture size"] = "Размер текстуры баффов/дебаффов",	
	["Buff/Debuff visibility"] = "Видимость баффов/дебаффов",
	["Show buffs or debuffs on the raid frames"] = "Показать баффы или дебаффы на рейд-рамках",
	["Only buffs"] = "Только баффы",
	["Only debuffs"] = "Только дебаффы",
	["Buffs and debuffs"] = "Баффы и дебаффы",
	["Nothing"] = "Ничего",
	["Power type visiblity"] = "Видимость типов полос силы", -- ??
	["Toggle the display of certain power types (Mana, Rage, Energy)"] = "Переключить отображение определенных типов силы (Мана, Ярость, Энергия)",
	["Mana"] = "Мана",
	["Toggle the display of mana bars"] = "Переключить отображение полос маны",
	["Energy & Focus"] = "Энергия и фокус",
	["Toggle the display of energy and focus bars"] = "Переключить отображение полос энергии и фокусировки",
	["Rage"] = "Ярость",
	["Toggle the display of rage bars"] = "Переключить отображение полос ярости",
	["Show dispellable debuffs"] = "Показать рассеиваемые дебаффы",
	["Toggle display of dispellable debuffs"] = "Переключить отображение рассеиваемых дебаффов",
	

	["Show filtered buffs"] = "Показать отфильтрованные баффы",
	["Toggle display of filtered buffs"] = "Переключить отображение отфильтрованных баффов",
	
	["Show dispellable debuffs within range"] = "Показать рассеиваемые дебаффы в радиусе действия",
	["Toggle display debuffs within 28Y range"] = "Переключить отображение дебаффов в диапазоне 28Y",
	["Show filtered debuffs"] = "Показать отфильтрованные дебаффы",
	["Toggle display of filtered debuffs"] = "Переключить отображение отфильтрованных дебаффов",
	
	["Buff/debuff slot number"] = "Количество баффов/дебаффов",
	["Set max number of buffs and debuffs"] = "Установить максимальное количество баффов и дебаффов",

	["Set the growth of the buffs/debuffs"] = "Установить прирост баффов/дебаффов",

	["Buffs/Debuffs"] = "Баффы/дебаффы",
	["_Buffs/Debuffs"] = "_Баффы/дебаффы",
	["Bar textures"] = "Текстура полос",
	["Set the texture used on health and mana bars"] = "Установить текстуру, используемую в полосе здоровья и маны",

	["Scale"] = "Маштаб",
	["Set the scale of the raid frames"] = "Установите масштаб рамок рейда",
	["Layout"] = "Положение",
	["Set the layout of the raid frames"] = "Установить положение рамок рейда",
	["Reset layout"] = "Сбросить положение",
	["Reset the position of sRaidFrames"] = "Сбросить положение sRaidFrames",
	["Predefined Layout"] = "Готовое размещение",
	["Set a predefined layout for the raid frames"] = "Установить готовое размещение для рамок рейда",
	["Sticky"] = "Прилипающий",
	["CT_RaidAssist"] = "CT_RaidAssist",
	["Horizontal"] = "Горизонтально",
	["Vertical"] = "Вертикально",

	["Background color"] = "Цвет фона",
	["Change the background color"] = "Изменить цвет фона",
	["Border color"] = "Цвет границ",
	["Change the border color"] = "Изменить цвет границ",
	["Border"] = "Границы",
	["Set about borders around the raid frames"] = "Установить границы вокруг рамок рейда",
	["Toggle border"] = "Переключить границы",
	["Toggle the display of borders around the raid frames"] = "Переключить отображение границ вокруг рамок рейда",
	["Border texture"] = "Текстура границ",
	["Select border texture"] = "Выбрать текстуру границ",
	["Original"] = "Оригинальная",
	["Ace"] = "Лед",
	["Santa"] = "Санта",
	["ThickEdge"] = "Толстые края",
	["Snow"] = "Снег",
	["Grid"] = "Grid",
	["Tooltip display"] = "Отображение всплывающей подсказки",
	["Determine when a tooltip is displayed"] = "Определить, когда отображается всплывающая подсказка",
	["Never"] = "Никогда",
	["Only when not in combat"] = "Только не в бою",
	["Always"] = "Всегда",
	["Highlight units with aggro"] = "Подсвечивать игроков с аггро",
	["Turn the border of units who have aggro red"] = "Сменить границу на красный игроков, у которых есть агро",
	["_Range"] = "_Дистанция",
	["Set about range"] = "Настройки дистанции",
	["Show estimated range"] = "Показать расчитываемую дистанцию",
	["Show estimated range next to player's name"] = "Показать расчитываемую дистанцию рядом с именем игрока",
	["Show estimated range only for focus units"] = "Показать расчитываемую дистанцию только для игроков в фокусе",
	["Enable light range check"] = "Включить легкую проверку дистанции",
	["Enable 28y range check in Instances and 40y coordinates dependant range check in Outdoors and Bgs - Suggested when you neither play healing class nor using Blizzard frames, agUnitFrames or LunaUnitFrames"] = "Включить проверку дистанции 28y в подземельях и проверку дистанции 40y, зависимые от координат, в открытом мире и на БГ - Рекомендуется, когда вы не играете классом Лекаря и не используете фреймы Blizzard, agUnitFrames или LunaUnitFrames",
	
	["Enable accurate range check"] = "Включить точную проверку дистанции",
	["Enable 40y range check that requires certain spells to be on actionbar and Blizzard frames, agUnitFrames or LunaUnitFrames to be present - Only healing classes can use accurate range check"] = "Включить проверку дистанции 40y, которая требуется при наличии определенных заклинаний на панели действий и в рамках Blizzard, agUnitFrames или LunaUnitFrames - только классы Лекаря могут использовать точную проверку дистанции",
	
	["Enable combined range check"] = "Включить комбинированную проверку дистанции",
	["Enable 40y accurate range check only in combat otherwise light range check is active"] = "Включить 40y точную проверку дистанции только в бою, иначе будет активна легкая проверка дистанции",


	["_Arrows"] = "_Стрелки",
	["Coordinates dependant functionality, won't work in instances"] = "Координаты зависимая функциональность, не работает в подземельях",
	["Enable arrows"] = "Включить стрелки",
	["Enable unit arrows"] = "Включить стрелки игроков",
	["Focus units only"] = "Только для игроков в фокусе",
	["Enable arrows only for focus units"] = "Включить стрелки только для игроков в фокусе",


	["_Debug"] = "_Отладка",
	["Set about debug"] = "Включить отладку",
	["Enable range calculation debug"] = "Включить отладку расчета дистанции",
	["Range accuracy calculation, only for testing"] = "Расчет точности дистанции, только для тестирования",
	["Enable incomming heal debug"] = "Включить отладку входящего лечения",
	["Incomming heal debug, only for testing. Prefixes: HCOM - HealComm, SRF - SRaidFrames, HBOT - HealBot, HAS - Healer Assist"] = "Отладка входящего исцеления, только для тестирования. Сокращения: HCOM - HealComm, SRF - SRaidFrames, HBOT - HealBot, HAS - Healer Assist",
	["Enable incomming resurrection debug"] = "Включить отладку входящего воскрешения",
	["Incomming resurrection debug, only for testing. Prefixes: HCOM - HealComm, SRF - SRaidFrames, HBOT - HealBot, HAS - Healer Assist"] = "Отладка входящего исцеления, только для тестирования. Сокращения: HCOM - HealComm, SRF - SRaidFrames, HBOT - HealBot, HAS - Healer Assist",
	
	
	["Alpha"] = "Альфа", --??
	["The alpha level for units who are out of range"] = "Альфа-уровень для игроков, находящихся вне дистанции", --??
	
	["Range frequency"] = "Частота дистанции",
	["The interval between which range checks are performed"] = "Интервал между проверками дистанции",
	
	["Accurate range frequency factor"] = "Точная частота коэффициента дистанции",
	["Increase or decrease time needed for full units scan - if you experience performance drop please increase the value"] = "Увеличить или уменьшить время, необходимое для полного сканирования игроков - если испытываете снижение производительности, увеличьте значение",

	["Show Group/Class"] = "Показать Группу/Класс",
	["Toggle the display of certain Groups/Classes - Active if frames are locked"] = "Переключить отображение определенных Групп/Классов - активно, если рамки заблокированы",
	["Classes"] = "Классы",
	["Warriors"] = "Воины",
	["Toggle the display of Warriors"] = "Переключить отображение Воинов",
	["Paladins"] = "Паладины",
	["Toggle the display of Paladins"] = "Переключить отображение Паладинов",
	["Shamans"] = "Шаманы",
	["Toggle the display of Shamans"] = "Переключить отображение Шаманов",
	["Hunters"] = "Охотники",
	["Toggle the display of Hunters"] = "Переключить отображение Охотников",
	["Warlocks"] = "Чернокнижники",
	["Toggle the display of Warlocks"] = "Переключить отображение Чернокнижников",
	["Mages"] = "Маги",
	["Toggle the display of Mages"] = "Переключить отображение Магов",
	["Druids"] = "Друиды",
	["Toggle the display of Druids"] = "Переключить отображение Друидов",
	["Rogues"] = "Разбойники",
	["Toggle the display of Rogues"] = "Переключить отображение Разбойников",
	["Priests"] = "Жрецы",
	["Toggle the display of Priests"] = "Переключить отображение Жрецов",

	["Groups"] = "Группы",
	["Group 1"] = "Группа 1",
	["Toggle the display of Group 1"] = "Переключить отображение Группы 1",
	["Group 2"] = "Группа 2",
	["Toggle the display of Group 2"] = "Переключить отображение Группы 2",
	["Group 3"] = "Группа 3",
	["Toggle the display of Group 3"] = "Переключить отображение Группы 3",
	["Group 4"] = "Группа 4",
	["Toggle the display of Group 4"] = "Переключить отображение Группы 4",
	["Group 5"] = "Группа 5",
	["Toggle the display of Group 5"] = "Переключить отображение Группы 5",
	["Group 6"] = "Группа 6",
	["Toggle the display of Group 6"] = "Переключить отображение Группы 6",
	["Group 7"] = "Группа 7",
	["Toggle the display of Group 7"] = "Переключить отображение Группы 7",
	["Group 8"] = "Группа 8",
	["Toggle the display of Group 8"] = "Переключить отображение Группы 8",
	["Group 9"] = "Группа 9",
	["Toggle the display of Group 9"] = "Переключить отображение Группы 9",		

	["Growth"] = "Возрастание",
	["Set the growth of the raid frames"] = "Установить возрастание рамок рейда",
	["Up"] = "Сверху",
	["Down"] = "Снизу",
	["Left"] = "Слева",
	["Right"] = "Справа",
	["Combined"] = "Комбинированный",
	["TopRight"] = "Сверху-справа",
	["BottomRight"] = "Снизу-справа",


	["Border"] = "Границы",
	["Toggle the display of borders around the raid frames"] = "Переключить отображение границ вокруг рамок рейда",
	["Frame spacing"] = "Интервал рамок",
	["Set the spacing between each of the raid frames"] = "Установить интервал между каждой из рамок рейда",

	["Offline"] = "Оффлайн",
	["Ghost"] = "Призрак",
	["Dead"] = "Умер",
	["Resurrected"] = "Воскрешен",
	["Can Recover"] = "Можно воскресить",
	["Feign Death"] = "Симуляция смерти",
	["Unknown"] = "Неизвестно",

	["Warrior"] = "Воин",
	["Mage"] = "Маг",
	["Paladin"] = "Паладин",
	["Shaman"] = "Шаман",
	["Druid"] = "Друид",
	["Hunter"] = "Охотник",
	["Rogue"] = "Разбойник",
	["Warlock"] = "Чернокнижник",
	["Priest"] = "Жрец",
	
	["Shield"] = "Бабл", --??
	["Carrier"] = "Carrier", --??
	["Rezzed"] = "Rezzed", --??
	["Soulstoned"] = "Камень души",
	["Intervened"] = "Вмешательство",
	["Innervate"] = "Озарение",
	["Spirit"] = "Дух", ---???---
	["Shield Wall"] = "Глухая оборона",
	["Last stand"] = "Ни шагу назад",
	["Gifted"] = "Gifted", --???
	["Ice block"] = "Ледяная глыба", --??
	["Vanished"] = "Исчезновение", --??
	["Stealthed"] = "Незаметность", --??
	["Infused"] = "Насыщение", --??
	["Fear Ward"] = "Защита от страха",
	["Protection"] = "Защита", --??
	["Divine Shield"] = "Божественный щит",

	["Right-click for options."] = "Щелкните правой кнопкой мыши для настроек.",
} end)
