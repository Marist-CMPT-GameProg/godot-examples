class_name Zone3D
extends CSGSphere3D
## Represents a spherical region of space that can detect whether "Spot3D" is
## inside it or outside, and respond accordingly.

const Test = preload("res://scripts/PointTest.gd")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if PointTest.on_sphere($"../Spot3D".global_position, global_position, radius) <= 0:
		material.albedo_color.a = 0.5
	else:
		material.albedo_color.a = 1
