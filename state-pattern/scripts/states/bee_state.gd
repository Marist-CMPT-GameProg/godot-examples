class_name BeeState
extends Resource

@export var controlled_bee = null

func _initialize(bee):
	self.controlled_bee = bee

func enter():
	pass

func exit():
	pass
	
func handleEvent(event) -> BeeState:
	return null

func update(delta:float):
	pass
