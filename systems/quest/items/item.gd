class_name Item extends Resource
## Serializable resource for defining collectible items.

## Unique name for this item.
@export var name:StringName = &"Unknown Item"
## Detailed description of this item.
@export var description:String = ""
## Icon image representing this item.
@export var icon:Texture2D
## Determines whether more than one can occupy the same ivnentory slot.
@export var is_stackable:bool = true
## Determines how many of this item can occupy a given inventory slot.
@export var max_stack:int = 64


## Use this item on the indicated node. (Currently a placeholder.)
func use(player: Node) -> void:
	print("Used ", name, " on ", player.name)
