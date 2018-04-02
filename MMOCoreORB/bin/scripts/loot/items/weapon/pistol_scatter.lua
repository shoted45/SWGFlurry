--Automatically generated by SWGEmu Spawn Tool v0.12 loot editor.

pistol_scatter = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "",
	directObjectTemplate = "object/weapon/ranged/pistol/pistol_scatter.iff",
	craftingValues = {
		{"mindamage",45,50,0},
		{"maxdamage",90,100,0},
		{"attackspeed",5.4,3.9,0},
		{"woundchance",10,24,0},
		{"hitpoints",750,750,0},
		{"attackhealthcost",24,12,0},
		{"attackactioncost",63,35,0},
		{"attackmindcost",24,12,0},
		{"roundsused",30,30,0},
		{"zerorangemod",-45,-25,0},
		{"maxrangemod",-95,-65,0},
		{"midrange",7,7,0},
		{"midrangemod",18,35,0},
	},
	customizationStringNames = {},
	customizationValues = {},

	-- randomDotChance: The chance of this weapon object dropping with a random dot on it. Higher number means less chance. Set to 0 to always have a random dot.
	randomDotChance = 375,
	junkDealerTypeNeeded = JUNKARMS,
	junkMinValue = 30,
	junkMaxValue = 55

}

addLootItemTemplate("pistol_scatter", pistol_scatter)
