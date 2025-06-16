class_name Blackboard
extends Node
##

##
signal posted(StringName)


var instructions:Dictionary = {}


##
func post(key:StringName, instruction:Variant):
	instructions[key] = instruction
	posted.emit(key)


##
func fetch(key:StringName) -> Variant:
	return instructions[key]
