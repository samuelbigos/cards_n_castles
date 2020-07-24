extends Node2D
class_name Home
"""
Intro screen.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

export var map_scene_path : String

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	var level = PlayerData.get_current_level()
	var story_text = Levels.levels[level]["pre-text"]

func _input(event):
	if event.is_action_pressed("ui_select"):
		get_tree().change_scene(map_scene_path)
	
""" PUBLIC """
