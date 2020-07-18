extends Node2D
"""
Defines and stores info about the grid.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _grid = [] # store objects at each grid loc
var _grid_map = {} # dictionary to store object locations for quick grid operations

""" PUBLIC """

export var grid_size : Vector2
export var cell_size : Vector2
export var cell_padding : int 
export var debug_render_grid : bool
	
###########
# METHODS #
###########

""" PRIVATE """
	
func _ready():
	for x in range(0, grid_size.x):
		_grid.append([])
		for _y in range(0, grid_size.y):
			_grid[x].append(null)
	
	
func _draw():
	for x in range(0, grid_size.x):
		for y in range(0, grid_size.y):
			var rect = Rect2(x * (cell_size.x + cell_padding), y * (cell_size.y + cell_padding), cell_size.x, cell_size.y)
			draw_rect(rect, Color("96b2c1"), false)
		
	
""" PUBLIC """

func get_at(x:int, y:int):
	return _grid[x][y]


func has(object:Node):
	return _grid_map.has(object)
	

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
