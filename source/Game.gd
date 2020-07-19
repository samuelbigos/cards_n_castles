extends Node
class_name Game
"""
Base scene for all game components and state management.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _state = Globals.State.NONE
var _winner = -1

""" PUBLIC """

export var unit_scene : PackedScene = null
export var blood_scene : PackedScene = null

signal state_change(from, to)

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Player.setup(self)
	$Opponent.setup(self)
	for unit in get_all_units():
		unit.connect("on_death", self, "on_Unit_on_death")
		
	change_state(Globals.State.DEPLOY)
	
func _process_results(winner):
	if winner:
		pass
	
func _on_Game_state_change(_from, to):
	match to:
		Globals.State.DEPLOY:
			pass
			
		Globals.State.BATTLE:
			$BattleAutomator.begin(get_all_units())
			
		Globals.State.RESULTS:
			_process_results(_winner)
	
func _on_ToBattle_pressed():
	change_state(Globals.State.BATTLE)

func _on_BattleAutomator_on_battle_end(winner):
	_winner = winner
	change_state(Globals.State.RESULTS)
	
func on_Unit_on_death(unit):
	var blood = blood_scene.instance()
	blood.position = unit.position
	$Env.add_child(blood)	

""" PUBLIC """

func get_card_database():
	return $DatabaseCards
		
func change_state(to):
	emit_signal("state_change", _state, to)
	_state = to	
	
func get_state():
	return _state
	
func get_all_units():
	return $Player.get_units() + $Opponent.get_units()
