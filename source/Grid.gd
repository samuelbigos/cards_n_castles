extends Node2D
"""
Defines and stores info about the grid.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _draw = false
var _grid = [] # store objects at each grid loc
var _grid_map = {} # dictionary to store object locations for quick grid operations

""" PUBLIC """

export var grid_size : Vector2
export var cell_size : Vector2
export var cell_padding : int 
	
###########
# METHODS #
###########

""" PRIVATE """
	
func _ready():
	for x in range(0, grid_size.x):
		_grid.append([])
		for _y in range(0, grid_size.y):
			_grid[x].append(null)
	
""" PUBLIC """

func set_draw(draw):
	_draw = draw
	update()

func get_at(x:int, y:int):
	return _grid[x][y]

func has(object:Node):
	return _grid_map.has(object)
	
func get_unit_pos(object:Node):
	assert(_grid_map.has(object))
	return _grid_map[object]
	
func add(x:int, y:int, object:Node):
	if not get_at(x, y):
		_grid_map[object] = Vector2(x, y)
		_grid[x][y] = object
		return true
	else:
		push_warning("Object already exists at this location, check before calling this function.")
		return false
				
func move(object:Node, x:int, y:int):
	if not _grid_map.has(object):
		push_warning("Trying to move object that doesn't exist.")
		return false
	
	if _grid[x][y] != null:
		push_warning("Trying to move object into a non-empty grid cell.")
		return false
		
	var current_pos = _grid_map[object]
	_grid[x][y] = object
	_grid[current_pos.x][current_pos.y] = null
	_grid_map[object] = Vector2(x, y)
	return true
	
func remove(object:Node):
	if not _grid_map.has(object):
		push_warning("Trying to remove object that doesn't exist in grid.")
		return false
	
	var pos = _grid_map[object]
	_grid[pos.x][pos.y] = null
	_grid_map.erase(object)
	return true

func cells_between(pos1:Vector2, pos2:Vector2):
	return abs(pos1.x - pos2.x) + abs(pos1.y - pos2.y)

func pos_to_snapped_pos(pos:Vector2):
	return grid_pos_to_snapped_pos(pos_to_grid_pos(pos))
	
func grid_pos_to_snapped_pos(pos:Vector2):
	return pos * (cell_size + ((Vector2(1.0, 1.0) * cell_padding))) + cell_size * 0.5
		
func pos_to_grid_pos(pos:Vector2):
	return Vector2(int(pos.x / (cell_size.x + cell_padding)),
					int(pos.y / (cell_size.y + cell_padding)))
