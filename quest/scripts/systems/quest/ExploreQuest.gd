class_name ExploreQuest
extends Quest
## A type of [Quest] that requires the player to visit one or more [Region]s of the game world.

## Names of places that must be visited
@export var places: Array[String]

## Exploration quests subscribe to event notifications from the exploration channel
var _event_channel: ExplorationChannel = ExplorationChannel.get_instance()


## Subscribes to [signal ExplorationChannel.region_entered] events. Overrides [method Quest._accept].
func _accept():
	_event_channel.region_entered.connect(_on_region_entered)
	super._accept()


## Unsubscribes from [signal ExplorationChannel.region_entered] events. Overrides [method Quest._complete].
func _complete():
	_event_channel.region_entered.disconnect(_on_region_entered)
	super._complete()


## While this quest is active, completes the quest when all required regions have been entered.
func _on_region_entered(region:Region):
	places.erase(region.name)
	if places.is_empty():
		_complete()
