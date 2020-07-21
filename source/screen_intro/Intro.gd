extends Node2D
class_name Intro
"""
Intro screen.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

export var game_scene_path : String

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	var level = PlayerData.get_current_level()
	var story_text = Levels.levels[level]["pre-text"]
	$GUI/CenterContainer/VBoxContainer/StoryText.text = '"' + story_text + '"'

func _input(event):
	if event.is_action_pressed("ui_select"):
		get_tree().change_scene(game_scene_path)
	
""" PUBLIC """
