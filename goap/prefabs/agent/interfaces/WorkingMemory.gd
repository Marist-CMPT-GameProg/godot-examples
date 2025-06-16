class_name WorkingMemory
extends Node
##

##
signal knowledge_gained(StringName)
##
signal knowledge_lost(StringName)

##
var known_facts:Dictionary = {}


##
func store(key:StringName, fact:Variant):
	known_facts[key] = fact
	knowledge_gained.emit(key)


##
func forget(key:StringName):
	known_facts.erase(key)
	knowledge_lost.emit(key)


##
func recall(key:StringName) -> Variant:
	return known_facts[key]
