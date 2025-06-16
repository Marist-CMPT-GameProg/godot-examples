extends Sense2D
## Vision

##
@export var range:float = 100
##
@export_range(0,360) var fov_degrees:float = 180

#@export_category("Tuning")
@export_subgroup("Sampling")
##n
@export_range(1,30) var scan_samples:int = 9
##
@export_range(0.1,10) var scan_time:float = 2.0

# TODO Remove this after initial testing
var scan_interval:float = scan_time / scan_samples #1.0 / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
var time_until_scan:float = 0

##
var fov:float = deg_to_rad(fov_degrees / 2)
var in_visual_range:Dictionary = {}
#var scan_increment:float = -1 # 2 * fov / scan_samples
#var scan_index:float = 0 # 2 * fov / scan_samples
var scan_increment:int = -1 # 2 * fov / scan_samples
var scan_index:int = 0 # 2 * fov / scan_samples
var scans_per_sec:float = scan_samples / scan_time
@onready var focus:Node2D = $Focus
@onready var los:RayCast2D = $LoS


func _ready():
	super._ready()
	los.rotation = -fov
	los.target_position.x = range
	fov = deg_to_rad(fov_degrees / 2)
	scan_interval = scan_time / scan_samples


func _process(delta):
	time_until_scan -= delta
	if time_until_scan <= 0:
		time_until_scan = scan_interval
		scan()


func scan():
	if los.is_colliding():
		var collider:Node = los.get_collider()
		if collider.is_in_group("Target"):
			memory.store("targetpos", los.get_collider().position)
	
	var next_rot:float = clamp(float(scan_index) / (scan_samples - 1) * 2 * fov - fov, -fov, fov)
	if scan_index == 0 or scan_index == (scan_samples - 1):
		scan_increment = -scan_increment
	scan_index += scan_increment
	#print("N:", scan_samples, " ; Idx: ", scan_index, " ; Incr:", scan_increment, " ; Curr:", los.rotation, " ; Next:", next_rot)
	los.rotation = next_rot


func get_visible_nodes():
	var visible_nodes:Array[Node2D]
	for n:Node2D in in_visual_range.values():
		los.target_position = n.global_position - position
		los.force_raycast_update()
		if n == los.get_collider():
			visible_nodes.append(n) 
	return visible_nodes


func _on_body_entered(body):
	in_visual_range[body.name] = body


func _on_body_exited(body):
	in_visual_range.erase(body.name)
