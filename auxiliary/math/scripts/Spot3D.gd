extends CSGSphere3D
## Represents a cute, little, user-controlled dot.

const Test = preload("res://scripts/PointTest.gd")

## Initial speed of "Spot" in units/sec
@export_range(1, 100) var speed:float = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var xy_motion:Vector2 = Input.get_vector(&"fwd_x", &"rev_x", &"down_y", &"up_y")
	var z_motion:float = Input.get_axis(&"fwd_z", &"rev_z")
	global_position += speed * Vector3(xy_motion.x, xy_motion.y, z_motion) * delta
	boundary_test()


## Change Spot's color depending on its position relative the boundary plane.
func boundary_test():
	var d = PointTest.on_plane_fuzzy(global_position, $"../Boundary".global_position, $"../Boundary".basis.y, radius)
	if d > 0:
		material.albedo_color.r = 0
		material.albedo_color.g = 1
	elif d < 0:
		material.albedo_color.r = 1
		material.albedo_color.g = 1
	else:
		material.albedo_color.r = 1
		material.albedo_color.g = 0
