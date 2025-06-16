class_name Sense2D
extends Node2D

##
@export var memory:WorkingMemory

##
func _ready():
	memory = memory if memory else get_parent().get_node("WorkingMemory")
