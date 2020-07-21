extends Node
"""
Defines and stores info about the grid.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _grid = [] # store objects at each grid loc
var _grid_map = {} # dictionary to store object locations for quick grid operations
var _grid_astar_id_map = {} # maps astar node ids onto grid locations
var _astar

""" PUBLIC """

const GRID_SIZE = Vector2(32, 32)
const CELL_SIZE = Vector2(16, 16)
const CELL_PADDING = 4
	
###########
# METHODS #
###########

""" PRIVATE """
	
func _ready():
	_astar = AStar.new()
	
	for x in range(0, GRID_SIZE.x):
		_grid.append([])
		for y in range(0, GRID_SIZE.y):
			_grid[x].append(null)
			
			var id = _astar.get_point_count()
			_astar.add_point(id, Vector3(x, y, 0))
			_grid_astar_id_map[Vector2(x, y)] = id
			if x > 0:
				_astar.connect_points(id, _grid_astar_id_map[Vector2(x - 1, y)])
			if y > 0:
				_astar.connect_points(id, _grid_astar_id_map[Vector2(x, y - 1)])
	
	
""" PUBLIC """

func update_grid():
	for x in range(0, GRID_SIZE.x):
		for y in range(0, GRID_SIZE.y):
			_astar.set_point_disabled(_grid_astar_id_map[Vector2(x, y)], get_at(x, y) != null)
			
func get_astar_path(from:Vector2, to:Vector2):
	var from_grid = pos_to_grid_pos(from)
	var to_grid = pos_to_grid_pos(to)
	_astar.set_point_disabled(_grid_astar_id_map[from_grid], false)
	_astar.set_point_disabled(_grid_astar_id_map[to_grid], false)
	var from_id = _grid_astar_id_map[from_grid]
	var to_id = _grid_astar_id_map[to_grid]
	var id_path = _astar.get_id_path(from_id, to_id)
	_astar.set_point_disabled(_grid_astar_id_map[from_grid], true)
	_astar.set_point_disabled(_grid_astar_id_map[to_grid], true)
	if id_path.size() < 2:
		return to
	var first_id_pos = _astar.get_point_position(id_path[1])
	return grid_pos_to_snapped_pos(Vector2(first_id_pos.x, first_id_pos.y))

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
	return pos * (CELL_SIZE + ((Vector2(1.0, 1.0) * CELL_PADDING))) + CELL_SIZE * 0.5
		
func pos_to_grid_pos(pos:Vector2):
	return Vector2(int(pos.x / (CELL_SIZE.x + CELL_PADDING)),
					int(pos.y / (CELL_SIZE.y + CELL_PADDING)))
		
