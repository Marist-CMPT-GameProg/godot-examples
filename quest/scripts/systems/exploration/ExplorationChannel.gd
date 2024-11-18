class_name ExplorationChannel
extends Object
## Provides centralized management of exploration events by routing them to all
## subscribed observers that need to know about such events, reducing coupling.
## This class is a fundamental part of the exploration system in this game.
##
## Implements a
## [url=https://github.com/godotengine/godot-docs-user-notes/discussions/5#discussioncomment-8124099]Signal Bus[/url],
## which borrows from the
## [url=https://en.wikipedia.org/wiki/Observer_pattern]Observer[/url],
## [url=https://en.wikipedia.org/wiki/Mediator_pattern]Mediator[/url], and
## [url=https://en.wikipedia.org/wiki/Singleton_pattern]Singleton[/url] patterns.
## Note that channels could be autoload Nodes, in which case observers subscribing to the channel could
## obtain a reference via @export or @onready variables. This latter design support multiple instances
## of the same kind of channel if needed, such as in a multi-player game or when NPCs themselves have
## their own inventories, quests, etc.
##
## @tutorial(Using signals): https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
## @tutorial(Singletons - Autoload): https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
## @tutorial(Singleton pattern): https://refactoring.guru/design-patterns/singleton
## @tutorial(Observer pattern): https://refactoring.guru/design-patterns/observer
## @tutorial(Mediator pattern): https://refactoring.guru/design-patterns/mediator


## Indicates that a given region has been explored.
## Payload is the [param region] that emitted the signal.
signal region_entered(region:Region)

## Indicates that a given region has been left.
## Payload is the [param region] that emitted the signal.
signal region_exited(region:Region)


## Calling this constructor more than once is an error.
func _init():
	assert(_instance == null)


## Returns the one unique [member _instance] of this channel, instantating it the first time.
static func get_instance() -> ExplorationChannel:
	if not _instance:
		_instance = ExplorationChannel.new()
	return _instance


## The single globally-acessible instance of this channel.
static var _instance: ExplorationChannel = null
