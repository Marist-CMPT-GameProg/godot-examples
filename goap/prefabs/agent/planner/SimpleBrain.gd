extends Node2D

##
@export var memory:WorkingMemory

##
@export var blackboard:Blackboard


func _ready():
	memory = memory if memory else $WorkingMemory
	blackboard = blackboard if blackboard else $Blackboard
	memory.knowledge_gained.connect(_on_knowledge_gained)


func _on_knowledge_gained(key:StringName):
	if key == &"targetpos":
		blackboard.post(&"angle", self.position.angle_to_point(memory.recall(key)))
