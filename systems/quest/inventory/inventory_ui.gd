class_name InventoryUI extends Control
## Visual representation of items held by a character or container.

## Reference to an inventory node.
@export var inventory: Inventory

## Reference to the visual grid control.
@onready var grid: GridContainer = $Grid


## Pauses the game and displays the inventory user interface.
func open() -> void:
	get_tree().paused = true
	self.visible = true


## Un-pauses the game and hides the inventory user interface.
func close() -> void:
	self.visible = false
	get_tree().paused = false


## Synchronize the user interface with the current contents of the attached inventory.
func refresh_ui() -> void:
	# Clear old slots
	for child in grid.get_children():
		child.queue_free()
	
	for slot in inventory.slots:
		var slot_panel = Panel.new()
		slot_panel.custom_minimum_size = Vector2(96, 96)
		var mbox = MarginContainer.new()
		var vbox = VBoxContainer.new()
		vbox.custom_minimum_size = Vector2(80, 80)
		vbox.alignment = VBoxContainer.ALIGNMENT_CENTER
		
		if slot:
			var tex = TextureRect.new()
			tex.texture = slot.item.icon
			tex.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
			tex.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
			tex.custom_minimum_size = Vector2(64, 64)
			vbox.add_child(tex)
		
			var label = Label.new()
			label.text = str(slot.quantity)
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			vbox.add_child(label)
		else: # empty or null
			var empty = Label.new()
			empty.text = "—"
			vbox.add_child(empty)
		
		mbox.add_child(vbox)
		slot_panel.add_child(mbox)
		grid.add_child(slot_panel)


# Called when the object's script is instantiated.
func _init() -> void:
	visible = false # hide by default


# Called when there is an input event.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_inventory"):
		get_viewport().set_input_as_handled()
		self.close()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory = $"/root/Game/Level1/Characters/Player/Inventory"
	refresh_ui()
