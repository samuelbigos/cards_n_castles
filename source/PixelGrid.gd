extends Node2D

export var grid_size : Vector2
export var cell_size : Vector2
export var cell_padding : int 
export var debug_render_grid : bool

func _ready():
	pass
	
func _draw():
	for x in range(0, grid_size.x):
		for y in range(0, grid_size.y):
			var rect = Rect2(x * (cell_size.x + cell_padding), y * (cell_size.y + cell_padding), cell_size.x, cell_size.y)
			draw_rect(rect, Color("96b2c1"), false)
