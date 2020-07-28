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
	$BG.scale = Globals.SCREEN_SIZE
	$BG.modulate = Globals.palette_ground
	
	# draw paths between nodes.
	var current_level = PlayerData.get_current_level()
	var nodes = $Nodes.get_children()
	for i in range(0, nodes.size()):
		if i > 0:
			var path = Line2D.new()
			path.default_color = Globals.palette_dirt
			path.add_point(nodes[i - 1].position + (nodes[i].position - nodes[i - 1].position).normalized() * 2.0)
			path.add_point(nodes[i].position + (nodes[i - 1].position - nodes[i].position).normalized() * 2.0)
			path.width = 2
			add_child(path)
			
		nodes[i].modulate = Globals.palette_player
		nodes[i].connect("on_activate", self, "on_node_activated")
			
	nodes[current_level].play()
	
	if not MusicManager.is_playing():
		MusicManager.play_menu()

func on_node_activated(node):
	if node.id == PlayerData.get_current_level():
		get_tree().change_scene(intro_scene_path)

""" PUBLIC """
