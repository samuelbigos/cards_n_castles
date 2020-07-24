extends Node
"""
Stores player data
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _current_level = 7
# 0
#var _deck = [ "maa", "maa" ]
# 1
#var _deck = [ "maa", "maa", "archer" ]
# 2
#var _deck = [ "maa", "maa", "archer", "cavalry" ]
# 3
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman" ]
# 4
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry" ]
# 5
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry", "mangonel" ]
# 6
#var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry", "mangonel", "ram" ]
# 7
var _deck = [ "maa", "maa", "archer", "cavalry", "spearman", "cavalry", "mangonel", "ram", "skirm" ]

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
