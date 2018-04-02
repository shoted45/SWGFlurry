--Automatically generated by SWGEmu Spawn Tool v0.12 loot editor.

two_handed_sword_katana = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "",
	directObjectTemplate = "object/weapon/melee/2h_sword/2h_sword_katana.iff",
	craftingValues = {
		{"mindamage",45,50,0},
		{"maxdamage",90,100,0},
		{"attackspeed",4.6,3.1,0},
		{"woundchance",15,27,0},
		{"hitpoints",750,1500,0},
		{"zerorangemod",-4,6,0},
		{"maxrangemod",-4,6,0},
		{"midrange",3,3,0},
		{"midrangemod",-4,6,0},
		{"maxrange",7,7,0},
		{"attackhealthcost",27,15,0},
		{"attackactioncosrt",65,35,0},
		{"attackmindcost",33,18,0},
	},
	customizationStringNames = {},
	customizationValues = {},

	-- randomDotChance: The chance of this weapon object dropping with a random dot on it. Higher number means less chance. Set to 0 to always have a random dot.
	randomDotChance = 375,
	junkDealerTypeNeeded = JUNKARMS,
	junkMinValue = 25,
	junkMaxValue = 45

}

addLootItemTemplate("two_handed_sword_katana", two_handed_sword_katana)
