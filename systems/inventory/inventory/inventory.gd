class_name Inventory extends Node
## Game object holding an inventory data structure for use with charactera and containers.

## Indicates that the contents of the inventory have changed.
signal inventory_updated

## This inventory may hold no more than this many slots.
@export var max_slots:int = 20

## Underlying data strcucture for storing item data.
var slots:Array[Dictionary] = []  # { "item": GameItem, "quantity": int }


## Add one or more of a given Item to this inventory.
func add_item(new_item:Item, quantity:int = 1) -> bool:
	if not new_item: return false
	var remaining = quantity
	
	# Try to stack first
	if new_item.is_stackable:
		for slot in slots:
			if slot and slot.item.name == new_item.name and slot.quantity < new_item.max_stack:
				var qty_to_add = min(remaining, new_item.max_stack - slot.quantity)
				slot.quantity += qty_to_add
				remaining -= qty_to_add
				if remaining <= 0: break
	
	# Place in empty slot(s)
	var i = 0
	while remaining > 0 and i < max_slots:
		if not slots[i] and remaining > 0:
			var qty_to_add = min(remaining, new_item.max_stack)
			slots[i] = { &"item": new_item, &"quantity": qty_to_add }
			remaining -= qty_to_add
		i += 1
	
	inventory_updated.emit()
	return remaining == 0  # partial success still emits


func _ready() -> void:
	slots.resize(max_slots)  # all empty initially
