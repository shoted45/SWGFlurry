fbase_scout_trooper = Creature:new {
	objectName = "@mob/creature_names:fbase_scout_trooper",
	randomNameType = NAME_SCOUTTROOPER,
	randomNameTag = true,
	socialGroup = "imperial",
	faction = "imperial",
	level = 33,
	chanceHit = 0.41,
	damageMin = 310,
	damageMax = 330,
	baseXp = 3300,
	baseHAM = 8700,
	baseHAMmax = 10700,
	armor = 0,
	resists = {115,115,10,10,10,-1,10,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = NONE,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.05,
	templates = {"object/mobile/dressed_scout_trooper_white_white.iff"},

--Imperial Stormtrooper Loot Template	
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 7500000},
				{group = "stormtrooper_common", chance = 2500000},
		},
			lootChance = 500000 

		},
		{
			groups = {
				{group = "g_rebel_credit", chance = 10000000}
		},
			lootChance = 200000 
		},
		{
			groups = {
				{group = "artifact", chance = 10000000}			
		},
			lootChance = 1000000
		},
		{
			groups = {
				{group = "tierone", chance = 10000000}
		},
			lootChance = 750000
		},
		{
			groups = {
				{group = "tiertwo", chance = 10000000}
		},
			lootChance = 100000
		},
		{
			groups = {
				{group = "tierthree", chance = 10000000}
		},
			lootChance = 50000
		},
		{
			groups = {
				{group = "rebpoints", chance = 10000000}
		},
			lootChance = 100000 
		},
	},
	weapons = {"imperial_weapons_light"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/stormtrooper",
	attacks = merge(brawlermaster,marksmanmaster,pistoleernovice)
}

CreatureTemplates:addCreatureTemplate(fbase_scout_trooper, "fbase_scout_trooper")
