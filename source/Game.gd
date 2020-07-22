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
var _was_victorious = false

""" PUBLIC """

export var unit_scene : PackedScene = null
export var blood_scene : PackedScene = null
export var map_scene_path : String
export var card_select_scene_path : String

signal state_change(from, to)

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Player.setup(self)
	$Opponent.setup(self)
		
	VisualServer.set_default_clear_color(Globals.palette_darkgreen)
	change_state(Globals.State.DEPLOY)
	
	$Player/CanvasLayer/PlayerHand.position = Vector2(Globals.SCREEN_SIZE.x * 0.5, Globals.SCREEN_SIZE.y)
	
	$Player.connect("on_all_units_dead", self, "_on_Player_on_all_units_dead")
	$Opponent.connect("on_all_units_dead", self, "_on_Opponent_on_all_units_dead")
	
	Globals.rng.randomize()
	
func _process_results():
	if _was_victorious:
		$GUI/Widget_Popup.setup("VICTORY!", "continue", self, "_on_Widget_Popup_pressed")
		$GUI/Widget_Popup.visible = true
	else:
		$GUI/Widget_Popup.setup("DEFEAT...", "retry", self, "_on_Widget_Popup_pressed")
		$GUI/Widget_Popup.visible = true
	
func _on_Game_state_change(_from, to):
	match to:
		Globals.State.DEPLOY:
			pass
			
		Globals.State.BATTLE:
			$BattleAutomator.begin(get_all_units())
			
		Globals.State.RESULTS:
			$BattleAutomator.end()
			_process_results()
	
func _on_ToBattle_pressed():
	if $GUI/Widget_ToBattle.visible:
		$GUI/Widget_ToBattle.visible = false
		change_state(Globals.State.BATTLE)
	
func _on_Unit_on_death(unit):
	var blood = blood_scene.instance()
	blood.position = unit.position
	$Env.add_child(blood)
	
func _on_Unit_on_picked(unit):
	$DrawGrid.set_visible(true)
	$AreaHighlights.animate_deploy = true
	$AreaHighlights._draw_deploy = true
	$AreaHighlights.update()
	
func _on_Card_on_card_picked(card_data):
	$DrawGrid.set_visible(false)
	$AreaHighlights.animate_deploy = true
	$AreaHighlights._draw_deploy = true
	$AreaHighlights.update()
	
func _on_Unit_on_unpicked(unit):
	$DrawGrid.set_visible(false)
	$AreaHighlights.animate_deploy = false
	$AreaHighlights._draw_deploy = false
	$AreaHighlights.update()
	
func _on_Card_on_card_unpicked(card_data, card):
	$DrawGrid.set_visible(false)
	$AreaHighlights.animate_deploy = false
	$AreaHighlights._draw_deploy = false
	$AreaHighlights.update()
	
func _on_Player_on_all_units_dead():
	_was_victorious = false
	change_state(Globals.State.RESULTS)
	
func _on_Opponent_on_all_units_dead():
	_was_victorious = true	
	change_state(Globals.State.RESULTS)
	
func _on_Widget_Popup_pressed():
	if _state == Globals.State.RESULTS:
			$GUI/Widget_Popup.visible = false
			if _was_victorious:
				get_tree().change_scene(card_select_scene_path)
			else:
				get_tree().reload_current_scene()
	
""" PUBLIC """

func get_card_database():
	return $DatabaseCards
		
func change_state(to):
	print(to)
	emit_signal("state_change", _state, to)
	_state = to	
	
func get_state():
	return _state
	
func get_all_units():
	return $Player.get_units() + $Opponent.get_units()
