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
	if not MusicManager.is_playing():
		MusicManager.play_menu(1)
		
	$GUI/Button.modulate = Globals.palette_player
	$GUI/Button/Sprite.modulate = Globals.palette_blood
	if SaveManager.has_save():
		$GUI/CenterContainer/VBoxContainer/Continue.visible = true
	
""" PUBLIC """

func _on_Button_pressed():
	MusicManager.set_enabled(not MusicManager.get_enabled())
	if MusicManager.get_enabled():
		$GUI/Button/Sprite.visible = false
	else:
		$GUI/Button/Sprite.visible = true

func _on_Button_mouse_entered():
	$GUI/Button.modulate = Globals.palette_blood

func _on_Button_mouse_exited():
	$GUI/Button.modulate = Globals.palette_player

func _on_Continue_pressed():
	SaveManager.do_load()
	get_tree().change_scene(map_scene_path)

func _on_NewGame_pressed():
	get_tree().change_scene(map_scene_path)
