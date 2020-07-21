extends Node
"""
Stores player data
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _current_level = 0
var _deck = [ "maa", "maa", "maa" ]

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
