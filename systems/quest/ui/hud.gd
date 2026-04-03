class_name HUD extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.ready.connect(_on_root_ready)
	ExplorationChannel.region_entered.connect(_on_region_discovered)


func _on_root_ready():
	var discoverables = get_tree().get_nodes_in_group("discoverable")
	$ProgressBar.max_value = discoverables.size()


func _on_region_discovered(region:Node):
	$ProgressBar.value += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_player_collected(coins: int) -> void:
	$ScoreLabel.text = "Score: " + str(coins)
