bolotaur = Creature:new {	objectName = "@mob/creature_names:bolotaur",	socialGroup = "bolotaur",	faction = "",	level = 16,	chanceHit = 0.24,	damageMin = 40,	damageMax = 45,	baseXp = 62,	baseHAM = 16500,	baseHAMmax = 19500,	armor = 0,	resists = {0,0,0,0,0,0,0,-1,-1},	meatType = "",	meatAmount = 0,	hideType = "",	hideAmount = 0,	boneType = "",	boneAmount = 0,	milkType = "",	milk = 0,	tamingChance = 0.5,	ferocity = 0,	pvpBitmask = ATTACKABLE,	creatureBitmask = HERD,	optionsBitmask = AIENABLED,	diet = HERBIVORE,	templates = {"object/mobile/bolotaur.iff"},	controlDeviceTemplate = "object/intangible/pet/bolotaur.iff",	scale = 1,	lootGroups = {},	weapons = {},	conversationTemplate = "",	attacks = {	}}CreatureTemplates:addCreatureTemplate(bolotaur, "bolotaur")