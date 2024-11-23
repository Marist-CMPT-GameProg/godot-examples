class_name Hero
extends Area2D
## Represents a the player-controlled protagonist.

## Indicates when the player has gained or lost gold.
signal gold_changed(count: int)
# TODO Move these signals into the appropriate channels
## Indicates when an enemy has been defeated by the player.
signal enemy_slain(count: int)
## Indicates when an item has been collected by the player.
signal item_collected(count: int)

## Hero subscribes to event notifications from the quest channel
var _quest_channel: QuestChannel = QuestChannel.get_instance()
# TODO The hero must also be able to receive notifications from Combat and Inventory channels

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
	_quest_channel.quest_rewarded.connect(_on_quest_rewarded)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area: Area2D):
	if area.is_in_group("region"):
		(area as Region).enter(self)
	elif area.is_in_group("npc"):
		(area as NPC).talk(self)
	elif area.is_in_group("item"):
		item_count += 1
		area.queue_free()
	elif area.is_in_group("enemy"):
		kill_count += 1
		area.queue_free()


func _on_area_exited(area: Area2D):
	if area.is_in_group("region"):
		(area as Region).exit(self)


func _on_quest_rewarded(quest: Quest):
	gold += quest.reward
