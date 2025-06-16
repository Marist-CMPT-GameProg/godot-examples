extends Node2D
##

##
@export var subject:Node2D

##
@export var blackboard:Blackboard

##
@export var key:StringName = &"angle"

var tween:Tween


##
func _ready():
	subject = subject if subject else get_parent()
	blackboard = blackboard if blackboard else subject.get_node("Blackboard")
	blackboard.posted.connect(_on_posted)


##
func _on_posted(key:StringName):
	if key == self.key:
		if tween: tween.stop()
		tween = create_tween()
		#tween.tween_property(subject, "rotation", blackboard.fetch(key), 0.1)
		var target_rotation:float = lerp_angle(subject.rotation, blackboard.fetch(key), 1)
		tween.tween_property(subject, "rotation", target_rotation, 0.1)
