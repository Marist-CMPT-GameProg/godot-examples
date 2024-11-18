class_name Quest
extends Resource
## Abstract base class to be extended by all concrete quest types.
##
## @tutorial(Implementing a Scalable Quest System): https://betterprogramming.pub/implementing-a-scalable-quest-system-7f36ea4cfe22

## The various states that a quest can be in
enum Status {
	## Not yet visible to the hero
	PENDING = -1,
	## Available to be take on by the hero
	UNLOCKED,
	## In-progress by the hero
	ACTIVE,
	## Completion requirements have been met
	COMPLETE,
	## Turned in for a reward and closed out
	DONE
}

## Descriptive title for this quest
@export var name: String
## How much gold player receives for completing the quest
@export_range(0, 1000000) var reward: int

## Property indicating the current state of the quest.
## Note that the setter also emits corresponding signals for each status change.
@export var status: Status = Status.PENDING:
	set(new_status):
		status = new_status
		match status:
			Status.UNLOCKED:
				_quest_channel.quest_unlocked.emit(self)
			Status.ACTIVE:
				_quest_channel.quest_accepted.emit(self)
			Status.COMPLETE:
				_quest_channel.quest_completed.emit(self)
			Status.DONE:
				_quest_channel.quest_rewarded.emit(self)

## Unique identifer distinguishing this specific quest
var uid: int

## Quests subscribe to event notifications from the quest channel
var _quest_channel: QuestChannel = QuestChannel.get_instance()


## Workaround for Godot initialization order, since a quest is not a [Node].
## This ensures that observers are notified of any initial quest state other than pending.
func ready():
	status = status


func _init():
	self.uid = generate_uid()


## Accept an unlocked quest. More specifically, transition from [constant UNLOCKED] to [constant ACTIVE],
## notifying the [member _quest_channel] in the process. When overriding this virtual function in a
## derived quest types, be sure also to invoke this method via the [code]super[/code] reference.
func _accept():
	print("Quest '", name,"' accepted!") # TODO Logging, remove before production build
	status = Status.ACTIVE

## Complete an active quest. More specifically, transition from [constant ACTIVE] to [constant COMPLETE],
## notifying the [member _quest_channel] in the process. When overriding this virtual function in a
## derived quest types, be sure also to invoke this method via the [code]super[/code] reference.
func _complete():
	print("Quest '", name,"' completed!") # TODO Logging, remove before production build
	status = Status.COMPLETE

## Turn in and close out a completed quest. Transition from [constant COMPLETE] to [constant DONE],
## notifying the [member _quest_channel] in the process. When overriding this virtual function in a
## derived quest types, be sure also to invoke this method via the [code]super[/code] reference.
func _reward():
	print("Quest '", name,"' rewarded!") # TODO Logging, remove before production build
	status = Status.DONE

## Unlock a previously locked quest. Transition from [constant PENDING] to [constant UNLOCKED],
## notifying the [member _quest_channel] in the process. When overriding this virtual function in a
## derived quest types, be sure also to invoke this method via the [code]super[/code] reference.
func _unlock():
	print("Quest '", name,"' unlocked!") # TODO Logging, remove before production build
	status = Status.UNLOCKED


## Contains the previously assigned unique identifier
static var lastUID: int = -1


## Returns a simple, incremental integer identifier that is unique for each new quest instance.
static func generate_uid():
	lastUID += 1
	return lastUID
