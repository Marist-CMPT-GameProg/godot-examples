class_name Coin extends Area2D
## Game objects representing collectible currency.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


## Collect this coin if the colliding node is the player.
func _on_coin_body_entered(body: Node2D) -> void:
	if body is Player:
		body.coins_collected += 1
		self.queue_free()
