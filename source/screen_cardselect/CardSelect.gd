extends Node2D
class_name CardSelect
"""
Card select screen.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

export var card_scene : PackedScene = null
export var map_scene_path : String

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	var viewport_center = get_viewport_rect().size * 0.5
	var reward_level = PlayerData.get_current_level()
	var rewards = Levels.levels[reward_level]["reward"]
	for i in range(0, rewards.size()):
		var card = card_scene.instance()
		card.setup(DatabaseCards.get_card_by_id(rewards[i]))
		var total_cards_width = card.get_width() * rewards.size() * 1.1
		card.position = viewport_center
		card.position.x += - (total_cards_width) * 0.5 + (total_cards_width / rewards.size() * (i + 0.5))
		card.position.y += 50
		card.hover_tween_distance = 10.0
		card.connect("on_card_unpicked", self, "_on_Card_on_card_unpicked")
		add_child(card)
		
	var story_text = Levels.levels[reward_level]["post-text"]
	$GUI/CenterContainer/VBoxContainer/StoryText.text = '"' + story_text + '"'

func _on_Card_on_card_unpicked(card_data, card):
	PlayerData.add_card_to_deck(card_data)
	PlayerData.complete_current_level()
	get_tree().change_scene(map_scene_path)
	
""" PUBLIC """
