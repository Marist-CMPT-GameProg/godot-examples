extends Node
## Provides centralized management of exploration events by routing them to all
## subscribed observers that need to know about such events, reducing coupling.


## Indicates that the given area has been entered for the first time. This should not emit more than once for the same region.
## Payload is the [param region] that emitted the signal.
@warning_ignore("unused_signal")
signal region_discovered(region:Node)


## Indicates that a given area has been explored.
## Payload is the [param region] that emitted the signal.
@warning_ignore("unused_signal")
signal region_entered(region:Node)


## Indicates that a given area has been left.
## Payload is the [param region] that emitted the signal.
@warning_ignore("unused_signal")
signal region_exited(region:Node)


## The one and only globally-accessible instance of this channel.
static var instance:Node:
	get: return instance
	set(new_instance):
		assert(instance == null)
		instance = new_instance


## Calling this constructor more than once is an error.
func _init() -> void:
	instance = self
