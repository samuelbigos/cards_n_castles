extends Node
"""
Stores player data
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _current_level = 0
# 0
var _deck = [ "maa", "maa", "archer" ]
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

""" PUBLIC """

func get_current_level():
	return _current_level

func complete_current_level():
	_current_level += 1

func get_starting_hand():
	return _deck

func add_card_to_deck(card_data):
	_deck.append(card_data.id)
