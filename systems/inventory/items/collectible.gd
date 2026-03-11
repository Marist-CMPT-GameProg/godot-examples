class_name Collectible extends Area2D
## Game object representing an item that can be collected in an inventory.

## Item resource assigned to this collectible object.
@export var item:Item #= preload("res://items/red_mushroom.tres")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = item.icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


## Collect the associated item if the colliding node has an inventory.
func _on_body_entered(body: Node2D) -> void:
	if body.has_node(^"Inventory"):
		var inv = body.get_node(^"Inventory")
		if inv.add_item(item):
			queue_free()
