class_name Levels

# hard-coding levels here for time. levels rotated -90 degrees in-game
const levels = [
	# 0
	{
		"pre-text": "Sir, we've sighted an enemy scout patrol. Our conquest of France will be doomed from the start should they report our invasion to the French capital. We must neutralise them at once!",
		"opponent": [	[ null, 		null, 		null, 		null, 		null,		null,		null ],
						[ null, 		null, 		null, 		"maa", 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		"archer",	null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ]],
		"post-text": "Great work, we'll capture one of them and force them to fight for us! We'll need to bolster our numbers if we're to emerge victorious in the battles to come.",
		"reward": [ "maa", "archer" ]
	},
	
	#1
	{
		"pre-text": "Intel suggests the town ahead has a stable. If we could equip our men with horses, their speed would greatly aid us in battle.",
		"opponent": [	[ null, 		null, 		null, 		null, 		null,		null,		null],
						[ null, 		null, 		null, 		"maa", 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null,		null, 		null ],
						[ "cavalry", 	null,		null, 		null, 		null, 		null, 		"cavalry" ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ]],
		"post-text": "Well done commander, the town guard stood no change against us.",
		"reward": [ "cavalry", "maa" ]
	},
	#2
	{
		"pre-text": "The outpost ahead has men equipped with spears. These soldiers will deal great damage to our cavalry units, make sure they don't engage directly!",
		"opponent": [	[ null, 		null, 		null, 		"spearman", null,		null,		null ],
						[ null, 		null, 		null, 		null, 		null,		null, 		null ],
						[ null, 		null, 		"cavalry", 	null,		"maa", 		null, 		null ],
						[ null, 		null, 		null, 		"archer", 	null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ]],
		"post-text": "Commander, our tacticians have discovered that units can be deployed even after the battle has started! You could use this tactic to more precisely time when units engage the enemy.",
		"reward": [ "spearman", "archer", "cavalry" ]
	},
	#3
	{
		"pre-text": "The town ahead is fortified with palisade walls. These will provide an obstacle for our troops, but I'm sure we'll be able to punch through.",
		"opponent": [	[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		"palisade", "palisade", "palisade", "palisade",	"palisade",	null ],
						[ null, 		"palisade", "archer",	"maa", 		"archer",	"palisade", 		null ],
						[ null, 		"palisade", null, 		null, 		null, 		"palisade", 		null ],
						[ null, 		"palisade", null, 		null, 		null, 		"palisade", 		null ],
						[ null,  		"palisade", null, 		null, 		null, 		"palisade", 		null ]],
		"post-text": "Great work, commander. Those static wooden palisades stood no chance!",
		"reward": [ "spearman", "archer", "cavalry", "maa" ]
	},
	#4
	{
		"pre-text": "Scouts report a strange sort of siege engine in the village up ahead. We need to take it!",
		"opponent": [	[ null, 		"palisade",	null,		"maa",		null, 		"palisade",	null],
						[ null, 		null, 		"maa", 		null, 		"maa", 		null, 		null ],
						[ null,			null, 		null, "mangonel",	null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null,		null,		null ],
						[ null, 		null, 		null, 		null,		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ "cavalry", 	null, 		null, 		null, 		null, 		null, 		null ]],
		"post-text": "It appears to do damage in a wide area, though it can't attack units that are too close. With proper placement, this could turn even the toughest battles in our favour!",
		"reward": [ "mangonel" ]
	},
	#5
	{
		"pre-text": "Before we take the capital we'll need an engine to break through the outer walls. Our patrol reports such a machine at an outpost nearby, we must make haste!",
		"opponent": [	[ null, 		null,		null,		null,		null, 		null,		null],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null,			null, 		null, 		null,		null, 		null, 		null ],
						[ null, 		null, 		null, 		"palisade",	null,		null,		null ],
						[ null, 		null, 		"palisade", "archer",	"palisade", null, 		null ],
						[ null, 		"palisade",	"archer",	"spearman", "archer",	"palisade", null ],
						[ "palisade", 	"archer", 	null, 		"ram", 		null, 		"archer",	"palisade" ]],
		"post-text": "This will help us punch through the stone walls of the French capital!",
		"reward": [ "ram" ]
	},
	#6
	{
		"pre-text": "We've finally made it to the capital, time to take her for England! Be sure to make use of our new siege equipment to break through the outer defenses.",
		"opponent": [	[ "stonewall", 	"stonewall","stonewall","stonewall","stonewall","stonewall","stonewall"],
						[ "stonewall", 		"archer", 	null, 		"archer",	null, 		"archer", 	"stonewall" ],
						[ "stonewall",		null, 		null, 		null,		null, 		null, 		"stonewall" ],
						[ "stonewall", 		null, 		"maa", 		null,		"spearman",	null,		"stonewall" ],
						[ "stonewall", 		null, 		null, 		"cavalry",	null, 		null, 		"stonewall" ],
						[ "stonewall", 		null,		"skirm",	null, 	 	"skirm",	null,		"stonewall" ],
						[ "stonewall", 		null, 		null, 		"maa", 		null, 		null,		"stonewall"]],
		"post-text": "We've breached the defenses and captured a unit of enemy skirmishers! These troops do bonus damage to archers.",
		"reward": [ "skirm" ]
	},
	#7
	{
		"pre-text": "We made it to the keep! One more victory and France is ours! FOR ENGLAND!",
		"opponent": [	[ null, 	"stonewall","stonewall","stonewall","stonewall","stonewall",		null],
						[ null, 	"stonewall","skirm", 	"archer", 	"skirm",	"stonewall", 		null ],
						[ null,		"stonewall", "archer", 	"skirm",	"archer", 	"stonewall", 		null ],
						[ null, 	"stonewall", "spearman","mangonel",	"spearman",	"stonewall",		null ],
						[ null, 	"stonewall", "maa", 	"cavalry",	"maa", 		"stonewall", 		null ],
						[ null, 	"stonewall", "maa",		"cavalry", 	 "maa",		"stonewall",		null ],
						[ "stonewall", 	"stonewall", "cavalry", "maa", 		"cavalry", 	"stonewall",		"stonewall"]],
		"post-text": "We've breached the defenses and captured a unit of enemy skirmishers! These troops do bonus damage to archers.",
		"reward": [ "skirm" ]
	},
]
