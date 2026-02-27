class_name Zone
extends Node2D
## Represents a circular region of space that can detect whether "Spot" is
## inside it or outside, and respond accordingly.

const Test = preload("res://scripts/PointTest.gd")

## Location of the center of the zone
@export var center:Vector2 = Vector2.ZERO
## Size of zone from center to edge
@export_range(1, 100) var radius:float = 5.0
## Initial color of the zone
@export var color:Color = Color.CYAN


# Called when redraw is requested for this node
func _draw():
	draw_circle(center, radius, color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if PointTest.on_circle($"../Spot".center, center, radius) <= 0:
		color.a = 0.5
	else:
		color.a = 1
	queue_redraw()
