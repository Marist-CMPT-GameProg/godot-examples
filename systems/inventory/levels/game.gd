extends Node

@export var inventory_ui:Control
#@export var gameover_scene:PackedScene = preload("res://Scenes/gameover.tscn")


# Called when there is an input event.
func _input(event: InputEvent) -> void:
	if inventory_ui and event.is_action_pressed(&"toggle_inventory"):
		get_viewport().set_input_as_handled()
		inventory_ui.open()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not inventory_ui:
		inventory_ui = $InventoryLayer/InventoryUI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## 
func _on_poi_body_entered(body: Node2D) -> void:
	if body is Player:
		# Deletes the current scene and replaces it with the new scene
		# at the next break in the game loop (the idle time)
		#get_tree().call_deferred(&"change_scene_to_packed", gameover_scene)
		get_tree().call_deferred(&"reload_current_scene")
