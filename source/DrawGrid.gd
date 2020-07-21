extends Node2D
class_name DrawGrid
"""
Draws grid.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _draw():
	for x in range(0, Grid.GRID_SIZE.x):
		for y in range(0, Grid.GRID_SIZE.y):
			var rect = Rect2(x * (Grid.CELL_SIZE.x + Grid.CELL_PADDING), y * (Grid.CELL_SIZE.y + Grid.CELL_PADDING), Grid.CELL_SIZE.x, Grid.CELL_SIZE.y)
			draw_rect(rect, Globals.palette_darkergreen, false)	
				
""" PUBLIC """
