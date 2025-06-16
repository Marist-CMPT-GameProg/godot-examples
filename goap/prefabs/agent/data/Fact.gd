class_name Fact
extends Resource
##

##
@export var subject:StringName
##
@export var descriptor:StringName
##
@export var value:Variant = null

func _init():
	assert(subject)
