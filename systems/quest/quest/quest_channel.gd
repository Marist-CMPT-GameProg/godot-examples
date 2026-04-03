extends Node
## Provides centralized management of quest state by routing quest events to all
## subscribed observers that need to know about such events, reducing coupling.


## Indicates that a quest has been unlocked
## Payload is the [param quest] that emitted the signal.
@warning_ignore("unused_signal")
signal quest_unlocked(quest:Quest)


## Indicates that a quest has been accepted.
## Payload is the [param quest] that emitted the signal.
@warning_ignore("unused_signal")
signal quest_accepted(quest:Quest)


## Indicates that a quest's objectives have been completed.
## Payload is the [param quest] that emitted the signal.
@warning_ignore("unused_signal")
signal quest_completed(quest:Quest)


## Indicates that a quest has been rewarded and closed.
## Payload is the [param quest] that emitted the signal.
@warning_ignore("unused_signal")
signal quest_rewarded(quest:Quest)


## The one and only globally-accessible instance of this channel.
static var instance:QuestChannelAutoload:
	get: return instance
	set(new_instance):
		assert(instance == null)
		instance = new_instance


## Calling this constructor more than once is an error.
func _init() -> void:
	instance = self
