extends Node
class_name Game
"""
Base scene for all game components.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

export var unit_scene : PackedScene = null

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Player.setup(self)

""" PUBLIC """

func get_card_database():
	return $DatabaseCards
