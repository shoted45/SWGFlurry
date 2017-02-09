ep3_loot_eventide = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "",
	directObjectTemplate = "object/weapon/melee/sword/ep3_loot_eventide.iff",
	craftingValues = {
		{"mindamage",99,191,0},
		{"maxdamage",198,342,0},
		{"attackspeed",5.9,4,1},
		{"woundchance",11,21,0},
		{"hitpoints",1550,2500,0},
		{"zerorangemod",-15,5,0},
		{"maxrangemod",-15,5,0},
		{"midrange",3,3,0},
		{"midrangemod",-15,5,0},
		{"maxrange",7,7,0},
		{"attackhealthcost",58,30,0},
		{"attackactioncost",31,15,0},
		{"attackmindcost",10,4,0},
	},
	customizationStringNames = {},
	customizationValues = {},

	-- randomDotChance: The chance of this weapon object dropping with a random dot on it. Higher number means less chance. Set to 0 to always have a random dot.
	randomDotChance = 500,
	junkDealerTypeNeeded = JUNKWEAPONS,
	junkMinValue = 30,
	junkMaxValue = 55
}

addLootItemTemplate("ep3_loot_eventide", ep3_loot_eventide)
