class_name Hero
extends Area2D
## Represents a the player-controlled protagonist.

## Indicates when the player has gained or lost gold.
signal gold_changed(count: int)
## Indicates when an enemy has been defeated by the player.
signal enemy_slain(count: int)
## Indicates when an item has been collected by the player.
signal item_collected(count: int)

## How much gold the hero currently has.
var gold:int = 0:
	set(amount):
		gold = amount
		gold_changed.emit(gold)

## How many items the hero has collected in total.
var item_count:int = 0:
	set(count):
		item_count = count
		item_collected.emit(item_count)

## How many enemies the hero has slain in total.
var kill_count:int = 0:
	set(count):
		kill_count = count
		enemy_slain.emit(kill_count)


# Called when the state of an input device changes
func _input(event):
	if event is InputEventMouseMotion:
		global_position += event.relative
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area: Area2D):
	if area.is_in_group("region"):
		(area as Region).enter(self)
	elif area.is_in_group("item"):
		item_count += 1
		item_collected.emit(item_count)
		area.queue_free()
	elif area.is_in_group("enemy"):
		kill_count += 1
		enemy_slain.emit(kill_count)
		area.queue_free()


func _on_area_exited(area: Area2D):
	if area.is_in_group("region"):
		(area as Region).exit(self)
