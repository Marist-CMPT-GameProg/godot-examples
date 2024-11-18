class_name QuestChannel
extends Object
## Provides centralized management of quest state by routing quest events
## to all subscribed observers that need to know about such changes. This relaxes
## coupling and is a fundamental part of the quest system for this game.
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
## @tutorial(Implementing a Scalable Quest System): https://betterprogramming.pub/implementing-a-scalable-quest-system-7f36ea4cfe22
## @tutorial(Using signals): https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
## @tutorial(Singletons - Autoload): https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
## @tutorial(Singleton pattern): https://refactoring.guru/design-patterns/singleton
## @tutorial(Observer pattern): https://refactoring.guru/design-patterns/observer
## @tutorial(Mediator pattern): https://refactoring.guru/design-patterns/mediator

# TODO Implement this channel by loosely following the design idea at https://betterprogramming.pub/implementing-a-scalable-quest-system-7f36ea4cfe22
