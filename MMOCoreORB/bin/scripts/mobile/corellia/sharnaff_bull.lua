sharnaff_bull = Creature:new {
	objectName = "@mob/creature_names:sharnaff_bull",
	socialGroup = "sharnaff",
	faction = "",
	level = 38,
	chanceHit = 0.41,
	damageMin = 335,
	damageMax = 380,
	baseXp = 3733,
	baseHAM = 9400,
	baseHAMmax = 11400,
	armor = 0,
	resists = {25,25,25,120,120,120,120,150,-1},
	meatType = "meat_carnivore",
	meatAmount = 482,
	hideType = "hide_scaley",
	hideAmount = 335,
	boneType = "bone_mammal",
	boneAmount = 200,
	milk = 0,
	tamingChance = 0,
	ferocity = 8,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/sharnaff_bull.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 10000000}				
		},
			lootChance = 10000000
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
				{group = "sharnaff_common", chance = 10000000}
		},
			lootChance = 1000000
		}
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"dizzyattack",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(sharnaff_bull, "sharnaff_bull")
