extends Node2D
class_name Map
"""
Map screen.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

export var game_scene : PackedScene = null
export var intro_scene_path : String

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	# draw paths between nodes.
	var current_level = PlayerData.get_current_level()
	var nodes = $Nodes.get_children()
	for i in range(0, nodes.size()):
		if i > 0:
			var path = Line2D.new()
			path.default_color = Globals.palette_green
			path.add_point(nodes[i - 1].position + (nodes[i].position - nodes[i - 1].position).normalized() * 2.0)
			path.add_point(nodes[i].position + (nodes[i - 1].position - nodes[i].position).normalized() * 2.0)
			path.width = 2
			add_child(path)
			
		nodes[i].modulate = Globals.palette_pale
		nodes[i]._connect_input_event("_on_Area2D_input_event", self)
			
	nodes[current_level].play()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ui_select"):
		get_tree().change_scene(intro_scene_path)

""" PUBLIC """
