extends Node2D


## First endpoint of the line segment
@export var start:Vector2 = Vector2.ZERO
## Second endpoint of the line segment
@export var end:Vector2 = Vector2.ONE
## Color of the line
@export var color:Color = Color.BLACK
## Width of the line in pixels
@export var width:float = 5

## Normal vector perpendicular to the line
var n:Vector2

# Called when CanvasItem has been requested to redraw
func _draw():
	draw_line(start, end, color, width)


# Called when the node enters the scene tree for the first time.
func _ready():
	n = end - start
	var tmp = -n.x
	n.x = n.y
	n.y = tmp
	n = n.normalized()
