extends Node

const SaveGame = preload('res://source/SaveGame.gd')
var SAVE_FOLDER = "user://savegame.save"
var SAVE_FORMAT = "save_%03d.tres"

func _ready():
	pass

func do_save():
	var id = ProjectSettings.get_setting("application/config/save_version")
	var save_game = SaveGame.new()
	save_game.save_version = ProjectSettings.get_setting("application/config/save_version")
	
	for node in get_tree().get_nodes_in_group("persistent"):
		save_game.data[node.name] = node.do_save()
		
	var directory = Directory.new()
	if not directory.dir_exists(SAVE_FOLDER):
		directory.make_dir_recursive(SAVE_FOLDER)
		
	var save_path = SAVE_FOLDER.plus_file(SAVE_FORMAT % id)
	var error : int = ResourceSaver.save(save_path, save_game)
	if error != OK:
		print("Save Error!")
		
func do_load():
	var id = ProjectSettings.get_setting("application/config/save_version")
	var save_path = SAVE_FOLDER.plus_file(SAVE_FORMAT % id)
	var file = File.new()
	if not file.file_exists(save_path):
		return
		
	var save_game = load(save_path)
	for node in get_tree().get_nodes_in_group("persistent"):
		node.do_load(save_game.data[node.name])

func has_save():
	var id = ProjectSettings.get_setting("application/config/save_version")
	var save_path = SAVE_FOLDER.plus_file(SAVE_FORMAT % id)
	var file = File.new()
	if file.file_exists(save_path):
		return true
	return false
