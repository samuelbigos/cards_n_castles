extends Node
class_name MapNode
"""
Does XXX.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

signal on_activate(node)

export var id = -1

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass

""" PUBLIC """

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_released("ui_select"):
		emit_signal("on_activate", self)
