class_name Quest extends Resource
## Abstract base class to be extended by all concrete quest types.

## The various states that a quest can be in
enum Status {
	## Not yet visible to the hero
	PENDING = -1,
	## Available to be taken on by the hero
	UNLOCKED,
	# In-progress by the hero
	ACTIVE,
	## Completion requirements have been met
	COMPLETE,
	## Turned in for a reward and closed out
	REWARDED
}

## Descriptive title for this quest
@export var name:StringName
## How many coins the player receives for completing the quest
@export_range(0, 1000) var reward:int

## Property indicating the current state of this quest
@export var status:Status = Status.PENDING:
	set(new_status):
		status = new_status
		# OR: emit a signal indicating state change (signal carries the new state)
		match status:
			Status.UNLOCKED:
				QuestChannel.quest_unlocked.emit(self) # emit signal indicating the quest was unlocked
			Status.ACTIVE:
				QuestChannel.quest_accepted.emit(self) # emit signal indicating the quest is now active
			Status.COMPLETE:
				QuestChannel.quest_completed.emit(self) # emit signal indicating the quest was completed
			Status.REWARDED:
				QuestChannel.quest_rewarded.emit(self) # emit signal indicating the quest was turned in


## Calling this in the [method Node._ready] function of a containing [Node] ensures that observers are notified of any initial quest state other than pending.
## This is a workaround for Godot initialization order, since a quest in not a [Node].
func ready():
	status = status


## Unlock a previously locked quest.
func _unlock():
	print("Quest '", name, "' unlocked!") # TODO Logging, remove before production build
	status = Status.UNLOCKED


## Accept an unlocked quest.
func _accept():
	print("Quest '", name, "' accepted!") # TODO Logging, remove before production build
	status = Status.ACTIVE


## Complete an active quest.
func _complete():
	print("Quest '", name, "' completed!") # TODO Logging, remove before production build
	status = Status.COMPLETE


## Turn in and close out a completed quest.
func _reward():
	print("Quest '", name, "' rewarded!") # TODO Logging, remove before production build
	status = Status.REWARDED
