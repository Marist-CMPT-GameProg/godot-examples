class_name World
extends Node2D
## Representation of a simple grid-based world.

## Reference to the tile-map layer containing the obstacles in this world.
@export var obstacles:TileMapLayer

## Internal Boolean representation of the obstacle grid for this world.
var cells:Array[bool] = []
## Dimensions of the world in discrete tile coordinates.
var size:Vector2i
## Size in pixels of each square tile in the world.
var tile_size:int


## Return the cost of moving from a source cell to a destination cell
## This represents direct edges in the "graph" so only immediately adjacent
## cells have a finite cost. For now, if the destination is immediately adjacent
## to the source and it is not an obstacle, then assign a cost of 1, otherwise
## assign it an infinite cost (see built-in INF constant).
func cost(src:Vector2i, dst:Vector2i):
	# TODO  Fill in the implementation of this function.
	pass


## Creates a 2D array that represents a discrete world.
## We build this programmatically from the TileMapLayer so that it is easy to
## design the world in the Godot editor by simply placing tiles appropriately.
func initialize_grid():
	# TODO Fill in the implementation of this function.
	#	Resize and initialize the elements of the `cells` 2D-array.
	#	Each cell should be a Boolean value indicating obstacle (True) or not.
	#	Look up `get_cell_source_id` in the documentation for TileMapLayer
	#	and use this function to determine whether an obstacle is present.
	pass

## Returns the coordinates of the immediate neighbors for the specified cell.
func neighbors(cell:Vector2i):
	var ns = []
	# TODO Fill the ns array with the coordinates of the 2-4 adjacent cells.
	#	Remember that edges and corners will not have neighbors on all sides.
	#	You may treat obstacles as neighbors with infinite cost to reach, or
	#	simply ignore them and don't treat them as neighbors.
	return ns

# Called when the node enters the scene tree for the first time.
func _ready():
	if not obstacles:
		obstacles = $Obstacles
	tile_size = obstacles.rendering_quadrant_size
	size = get_viewport_rect().size / tile_size
	print("world has " + str(size.y) + " rows and " + str(size.x) + " cols")
	initialize_grid()

# Called when the state of an input device changes
func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
