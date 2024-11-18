class_name HUD
extends CanvasLayer
## Simple text-only heads-up display for this demo

## HUD subscribes to event notifications from the exploration channel
var _exploration_events: ExplorationChannel = ExplorationChannel.get_instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	_exploration_events.region_entered.connect(_on_region_entered)
	_exploration_events.region_exited.connect(_on_region_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta): pass


func _on_hero_gold_changed(count: int):
	$GoldCounter.text = "Gold: " + str(count)
	print("Gold earned!")


func _on_region_entered(region: Node2D):
	$CurrentRegion.text = "Region: " + region.name
	print("Location entered!")


func _on_region_exited(_region: Node2D):
	$CurrentRegion.text = "Region: none"
	print("Location exited!")


func _on_hero_enemy_slain(count: int):
	$KillCounter.text = "Slain: " + str(count)
	print("Enemy slain!")


func _on_hero_item_collected(count: int):
	$ItemCounter.text = "Collected: " + str(count)
	print("Item collected!")
