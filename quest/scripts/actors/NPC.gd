class_name NPC
extends Area2D
## A simple non-player character that can bestow a quest.

## The quest offered by this character.
@export var quest:Quest


## Interacting with this NPC unlocks, accepts, or turns-in their associated quest.
func talk(_hero:Hero):
	match quest.status:
		Quest.Status.PENDING:
			quest._unlock()
		Quest.Status.UNLOCKED:
			quest._accept()
		Quest.Status.COMPLETE:
			quest._reward()


# Called when the node enters the scene tree for the first time.
func _ready():
	quest.ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
