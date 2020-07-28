extends Node2D
class_name PlayerHand
"""
Stores cards in the player's current hand.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _cards = []
var _player = null
var _card_picked = false

""" PUBLIC """

export var CardScene : PackedScene = null

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass
	
func _process(delta):	
	# update positions
	for i in range(_cards.size() - 1, -1, -1):
		if not _cards[i]:
			_cards.remove(i)
			continue
		var total_cards_width = _cards[i].get_width() * _cards.size() * 0.6
		_cards[i].position.x = - (total_cards_width) * 0.5 + (total_cards_width / _cards.size() * (i + 0.5))
	
	#_cards.sort_custom(self, "_sort_by_x")
	
func _on_Card_on_card_picked(card_data, card):
	for card in _cards:
		card.set_picking_enabled(false)
	
func _on_Card_on_card_unpicked(card_data, card):
	for card in _cards:
		card.set_picking_enabled(true)

func _sort_by_x(a, b):
	return a.position.x < b.position.x
	
func _on_Unit_on_unit_to_card(unit, card_data):
	var card = _add_card(card_data)
	card.set_as_picked()
	
func _add_card(card_data):
	var card_instance = CardScene.instance()
	card_instance.setup(card_data)
	card_instance.connect("on_card_picked", _player._game, "_on_Card_on_card_picked")
	card_instance.connect("on_card_unpicked", _player, "_on_Card_on_card_unpicked")
	card_instance.connect("on_card_force_deploy", _player, "_on_Card_on_card_force_deploy")
	card_instance.connect("on_card_unpicked", _player._game, "_on_Card_on_card_unpicked")
	card_instance.connect("on_card_picked", self, "_on_Card_on_card_picked")
	card_instance.connect("on_card_unpicked", self, "_on_Card_on_card_unpicked")
	add_child(card_instance)
	_cards.append(card_instance)
	return card_instance
	
func _on_Game_state_change(from, to):
	match to:
		Globals.State.DEPLOY:
			self.visible = true
			
	match from:
		Globals.State.DEPLOY:
			self.visible = false
	
""" PUBLIC """

func setup(cards, player): # array of CardData
	_player = player
	for card in cards:
		_add_card(card)
		
func deploy(grid_pos, card_id):
	for card in _cards:
		if card._card_data.id != card_id:
			continue
		
		card.deploy(grid_pos)
		break
