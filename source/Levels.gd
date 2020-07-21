class_name Levels

# hard-coding levels here for time. levels rotated -90 degrees in-game
const levels = [
	# 1
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
	
	#2
	{
		"pre-text": "Intel suggests the town ahead has a stable. If we could equip our men with horses, their speed would greatly aid us in battle.",
		"opponent": [	[ null, 		null, 		null, 		null, 		null,		null,		null],
						[ null, 		null, 		null, 		"maa", 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null,		null, 		null ],
						[ "cavalry", 	null,		null, 		null, 		null, 		null, 		"cavalry" ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ]],
		"post-text": "",
		"reward": [ "maa", "archer" ]
	},
	#3
	{
		"pre-text": "",
		"opponent": [	[ null, 		null, 		null, 		null, 		null,		null,		null ],
						[ null, 		null, 		"maa", 		null, 		"maa", 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ],
						[ null, 		null, 		null, 		null, 		null, 		null, 		null ]],
		"post-text": "",
		"reward": [ "maa", "archer" ]
	}
]
