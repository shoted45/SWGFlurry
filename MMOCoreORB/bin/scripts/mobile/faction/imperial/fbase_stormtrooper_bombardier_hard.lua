fbase_stormtrooper_bombardier_hard = Creature:new {
	objectName = "@mob/creature_names:fbase_stormtrooper_bombardier_hard",
	randomNameType = NAME_STORMTROOPER,
	randomNameTag = true,
	socialGroup = "imperial",
	faction = "imperial",
	level = 74,
	chanceHit = 0.74,
	damageMin = 515,
	damageMax = 740,
	baseXp = 7400,
	baseHAM = 14000,
	baseHAMmax = 20500,
	armor = 1,
	resists = {110,110,140,25,25,25,25,-1,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.05,

	templates = {"object/mobile/dressed_stormtrooper_bombardier_m.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 8500000},
				{group = "clothing_attachments", chance = 500000},
				{group = "armor_attachments", chance = 500000},
				{group = "stormtrooper_common", chance = 500000},
					
			},
			lootChance = 10000000 
			},
			{
			groups = {
				{group = "g_rebel_credit", chance = 10000000},
				},
			lootChance = 20000 
			},
			{
			groups = {
				{group = "rebpoints", chance = 10000000},
				},
			lootChance = 100000 
			}
	},
	weapons = {"st_bombardier_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/stormtrooper",
	attacks = merge(commandomid,marksmanmaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(fbase_stormtrooper_bombardier_hard, "fbase_stormtrooper_bombardier_hard")
