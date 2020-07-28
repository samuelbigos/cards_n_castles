extends Node
"""
Stores player data
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _SAVE_KEY = "player_data"

var _data = {}

#var _current_level = 0
# 0
#var _deck = [ "maa", "maa", "archer" ]
# 1
#var _deck = [ "maa", "maa", "archer", "archer" ]
# 2
#var _deck = [ "maa", "maa", "archer", "cavalry", "archer" ]
# 3
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "archer" ]
# 4
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry", "archer" ]
# 5
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry", "mangonel", "archer" ]
# 6
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry", "mangonel", "ram", "archer" ]
# 7
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry", "mangonel", "ram", "skirm", "archer" ]

""" PUBLIC """



###########
# METHODS #
###########

""" PRIVATE """

func _init():
	add_to_group("persistent")
	_do_create_new()
	
func _do_create_new():
	_data["current_level"] = 0
	_data["deck"] = [ "maa", "maa", "archer" ]
	_data["begin_battle_state"] = []
	
func save_begin_battle_state(data):
	_data["begin_battle_state"] = data
	
func load_begin_battle_state():
	return _data["begin_battle_state"]

""" PUBLIC """

func reset():
	_do_create_new()

func get_current_level():
	return _data["current_level"]

func complete_current_level():
	_data["current_level"] += 1
	SaveManager.do_save()

func get_starting_hand():
	return _data["deck"]

func add_card_to_deck(card_data):
	_data["deck"].append(card_data.id)
	SaveManager.do_save()
	
func do_save():
	var save_data = {}
	
	# save misc data
	save_data["data"] = _data.duplicate(true)
	return save_data
	
###
func do_load(save_data : Dictionary):
	_do_create_new()
	_data = save_data["data"].duplicate(true)
