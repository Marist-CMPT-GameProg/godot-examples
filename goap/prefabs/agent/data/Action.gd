class_name Action
extends Resource
##

##
@export var name:StringName
##
@export var cost:int = 1
##
@export var preconditions:WorldState
##
@export var postconditions:WorldState

#
var procedural_condition:Callable
#
var procedural_effect:Callable

func init():
	assert(name != null)


#					  U V W X Y Z
#   Initial:		[ _ _ _ _ _ _ ]
#	Effects: 		[ e f _ _ _ c ]
#	Goal:			[ _ _ d a   c ]
#	Unsatisfied:	[ _ _ d a _ _ ]		Add difference (Goal \ Effects)
#	---
#	Initial:		[ _ _ d a _ _ ]
#	Unsatisfied		[ _ _ d a _ _ ]
#	Preconds:		[ _ _ d _ b _ ]
#	Predecessor:	[ _ _ d a b _ ]		Add difference (Preconds \ Unsatisfied)


#					  U V W X Y Z
#   Initial:		[ _ _ _ _ _ _ ]
#	Goal:			[ _ _ d a   c ]
#	Effects: 		[ e f _ _ _ c ]
#	Unsatisfied:	[ _ _ d a _ _ ]		Add filtered not appearing in Effects
#	---
#	Initial:		[ _ _ d a _ _ ]
#	Unsatisfied		[ _ _ d a _ _ ]
#	Preconds:		[ _ _ d _ b _ ]
#	Predecessor:	[ _ _ d a b _ ]		Add filtered not appearing in Unsatisfied


## Determines whether the goal state is a possible result of applying this
## action and returns the predecessor state.
## then we return a minimal substate of all states in which this
## action could have been applied to yield the goal state.
func reconstruct(goal:WorldState):
	#var unsatisfied:WorldState
	#for key in goal.properties:
		#var prop = postconditions.get(key)
		#if prop == null:
			#unsatisfied.properties[key] = goal.properties[key]
		#elif prop.value != goal.properties[key].value:
			#return WorldState.CONFLICT
	#for key in preconditions.properties:
		#var prop = unsatisfied.get(key)
		#if prop == null:
			#unsatisfied.properties[key] = preconditions.properties[key]
		#elif prop.value != preconditions.properties[key].value:
			#return WorldState.CONFLICT
	#return unsatisfied

	var unsatisfied = diff(goal, postconditions, WorldState.new({}))
	var predecessor = diff(preconditions, unsatisfied, unsatisfied)
	return predecessor

# If prop in A is missing from B, then insert into C
# Otherwise, if A and B conflict about prop, then FAIL
func diff(a:WorldState, b:WorldState, c:WorldState):
	if c != WorldState.CONFLICT:
		for key in a.properties:
			var prop = b.get(key)
			if prop == null:
				c.properties[key] = a.properties[key]
			elif prop.value != a.properties[key].value:
				return WorldState.CONFLICT
	return c
	# If prop in A is missing from B, then insert into C
	# Otherwise, if A and B conflict about prop, then FAIL

func difference(a:WorldState, b:WorldState, forbid_conflict:bool = true):
	var c:WorldState
	for key in a.properties:
		var prop = b.get(key)
		if prop == null:
			c.properties[key] = a.properties[key]
		elif forbid_conflict and prop.value != a.properties[key].value:
			return WorldState.CONFLICT
	return c

func filter(a:WorldState, b:WorldState, forbid_conflict:bool = true):
	var c:WorldState
	for key in a.properties:
		var prop = b.get(key)
		if prop == null:
			c.properties[key] = a.properties[key]
		elif forbid_conflict and prop.value != a.properties[key].value:
			return WorldState.CONFLICT
	return c
