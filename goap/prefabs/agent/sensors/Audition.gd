extends Node2D
##

##
@export var sensitivity:float = 1.0
##
@export var accuracy:float = 1.0

func _ready():
	get_tree().get_nodes_in_group("sound_source")

func _on_sound(source:Node2D):
	source
	pass
