extends Node2D
class_name BattleAutomator
"""
Manages the automation of a battle.
"""

enum State {
	BEGIN_TURN,
	UNIT_PROCESSING,
	END_TURN
}

###########
# MEMBERS #
###########

""" PRIVATE """

var _running = false
var _units = []
var _current_unit = null
var _state = State.BEGIN_TURN

""" PUBLIC """

signal on_battle_end(winner)

###########
# METHODS #
###########

""" PRIVATE """

func _process(_delta):
	if not _running:
		return
		
	match _state:
		State.BEGIN_TURN:
			assert(_current_unit)
			_current_unit.connect("on_turn_over", self, "_on_Unit_on_turn_over")
			_current_unit.do_turn()
			_state = State.UNIT_PROCESSING
				
		State.UNIT_PROCESSING:
			pass
			
		State.END_TURN:
			# clear out any units that may have been freed
			for i in range(_units.size() - 1, 0, -1):
				if not is_instance_valid(_units[i]):
					_units.remove(i)
			
			# check there are still units in the battle
			if _units.size() == 0:
				_end_battle(-1)
			
			# put our current unit to the back of the queue and process next one
			_current_unit.disconnect("on_turn_over", self, "_on_Unit_on_turn_over")
			_units.erase(_current_unit)
			_units.push_back(_current_unit)
			_current_unit = _units[0]
			_state = State.BEGIN_TURN
			
func _end_battle(winner:int):
	_running = false
	emit_signal("on_battle_end", winner)
	
func _on_Unit_on_turn_over():
	_state = State.END_TURN
	
func _sort_by_initiative(a, b):
	return a._cached_data.initiative > b._cached_data.initiative

""" PUBLIC """

func begin(units):
	assert(units.size() > 0)
	_running = true
	_state = State.BEGIN_TURN
	_units = units
	# sort units by initiative
	_units.sort_custom(self, "_sort_by_initiative")
	if units.size() > 0:
		_current_unit = _units[0]
