class_name Region
extends Area2D
## A bounded area representing a region of the game world that can be explored.

## Color of the visible boundary for this region
@export var color:Color = Color.GRAY

## Determines the boundary of the region
@onready var collider:CollisionShape2D = $Collider


## Regions may publish exploration events through the relevant channel.
var _event_channel: ExplorationChannel = ExplorationChannel.get_instance()


## Visit the region, emitting an appropriate signal via the [member _event_channel].
## Takes a reference to the [param _character] [Node] that entered the region.
func enter(_character:Node):
	_event_channel.region_entered.emit(self)


## Leave the region, emitting an appropriate signal via the [member _event_channel].
## Takes a reference to the [param _character] [Node] that left the region.
func exit(_character:Node):
	_event_channel.region_exited.emit(self)


func _draw():
	draw_rect(collider.shape.get_rect(), color, false)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
