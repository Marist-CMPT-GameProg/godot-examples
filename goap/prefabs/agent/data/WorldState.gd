class_name WorldState
extends Resource
## "State cluster"

## A collection of properties that support fast lookup
var properties:Dictionary

const CONFLICT:WorldState = null

func _init(properties:Variant):
	if properties is Dictionary:
		self.properties = properties
	elif properties is Array:
		for prop in properties:
			self.properties[prop.to_key()] = prop


func _to_string():
	return str(properties)


func size():
	return properties.size()


func has(key):
	return properties.has(key)
	
	
func insert(prop:Fact):
	properties[prop.to_key()] = prop
	return true


func equals(other:WorldState):
	if self.size() != other.size(): return false
	for key in self.properties:
		if key not in other.properties or other.properties[key].value != self.properties[key].value:
			return false
	return true


func appears_in(collection:Dictionary) -> bool:
	for key in collection:
		if self.equals(key):
			return true
	return false


## Adds a property to this world state, or overwrites if already present
func add_property(key, prop):
	properties[key] = prop
	return true


func get_property(key):
	return properties.get(key)


func drop_property(key):
	properties.erase(key)


func drop_properties(keys:Array):
	for key in keys:
		properties.erase(key)

## Determine whether all properties of a goal state are present in this state
## with their required values.
func satisfies(goal:WorldState) -> bool:
	for key in goal.properties:
		if not self.has(key) or self.get_property(key).value != goal.get_property(key).value:
			return false
	return true

### Return a substate of the first state containing only those properties
### that are not satisfied (i.e., same in) the second state.
static func difference(a:WorldState, b:WorldState) -> WorldState:
	var c:WorldState = a.duplicate()
	for key in b.properties:
		var prop = a.get_property(key)
		if prop and prop.value == b.get_property(key).value:
			c.drop_property(key)
	return c


## Remove satisfied properties from a goal state as long as no conflict exists
static func reduce_by(goal:WorldState, effects:WorldState, forbid_conflict:bool = true):
	var new_goal:WorldState = goal.duplicate()
	for key in goal.properties:
		if effects.has(key):
			if effects.get_property(key).value == goal.get_property(key).value:
				new_goal.drop_property(key)
			elif forbid_conflict:
				return null # conflict!
	if new_goal.size() == goal.size(): return goal
	return new_goal


static func expand_by(goal:WorldState, preconditions:WorldState, forbid_conflict:bool = true):
	var new_goal:WorldState = goal.duplicate()
	for key in preconditions.properties:
		if not goal.has(key):
			new_goal.add_property(key, preconditions.get_property(key))
		elif forbid_conflict and goal.get_property(key).value != preconditions.get_property(key).value:
			return null # conflict!
	return new_goal
