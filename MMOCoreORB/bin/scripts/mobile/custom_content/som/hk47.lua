hk47 = Creature:new {
	customName = "HK-47",
	socialGroup = "townsperson",
	faction = "",
	level = 120,
	chanceHit = .90,
	damageMin = 1245,
	damageMax = 2400,
	baseXp = 9884,
	baseHAM = 79000,
	baseHAMmax = 90000,
	armor = 1,
	resists = {70,70,70,70,70,70,70,70,70},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/som/hk47.iff"},
	lootGroups = {},
	weapons = {"pirate_weapons_light"},
	conversationTemplate = "",
	attacks = merge(marksmannovice,brawlernovice)
}

CreatureTemplates:addCreatureTemplate(hk47, "hk47")
