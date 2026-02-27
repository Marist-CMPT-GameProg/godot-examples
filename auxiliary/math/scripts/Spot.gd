extends Zone
## Represents a cute, little, user-controlled dot.

## Color to use when Spot is above the boundary
@export var above_color:Color = Color.GREEN
## Color to use when Spot is below the boundary
@export var below_color:Color = Color.YELLOW

var on_color:Color

# Called when the state of an input device changes
func _input(event):
	if event is InputEventMouseMotion:
		center += event.relative
		boundary_test()
		queue_redraw()


# Called when the node enters the scene tree for the first time.
func _ready():
	on_color = color # remember the default color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass # Overrides Zone._process() to do nothing


## Change Spot's color depending on its position relative the boundary line.
func boundary_test():
	var d = PointTest.on_line_fuzzy(center, $"../Boundary".start, $"../Boundary".n, radius)
	if d > 0:
		color = above_color
	elif d < 0:
		color = below_color
	else:
		color = on_color
