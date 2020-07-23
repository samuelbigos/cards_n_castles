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
						[ "palisade", 	null, 		"archer",	"maa", 		"archer",	null, 		"palisade" ],
						[ "palisade", 	null, 		null, 		null, 		null, 		null, 		"palisade" ],
						[ "palisade", 	null, 		null, 		null, 		null, 		null, 		"palisade" ],
						[ "palisade", 	null, 		null, 		null, 		null, 		null, 		"palisade" ]],
		"post-text": "Great work, commander. Those static wooden palisades stood no chance!",
		"reward": [ "spearman", "archer", "cavalry", "maa" ]
	},
	#4
	{
		"pre-text": "The town ahead is fortified with palisade walls. These will provide an obstacle for our troops, but I'm sure we'll be able to punch through.",
		"opponent": [	[ null, 		null, 		null, 		"archer", 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ]],
		"post-text": "Great work, commander. Those static wooden palisades stood no chance!",
		"reward": [ "spearman", "archer", "cavalry", "maa" ]
	},
]
