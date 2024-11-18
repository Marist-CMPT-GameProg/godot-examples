class_name QuestJournal
extends CanvasLayer
## User interface component for displaying the status of unlocked quests.

## The hero, a.k.a. protagonist, a.k.a. player-character.
@export var hero: Hero
## Status icons for conveying the statuses of quests in the journal.
@export var icons: Array[Texture2D]
## Custom text colors to help convey the statuses of quests in the journal.
@export var colors: Array[Color]

## The list control where known quests are displayed.
@onready var quest_chooser: ItemList = $Chooser/QuestList

## Quests subscribe to event notifications from the quest channel.
var _quest_channel: QuestChannel = QuestChannel.get_instance()


## Hides the journal and unpauses the hero character.
func close():
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hero.set_process_input(true)


## Pauses the hero character and shows the journal.
func open():
	hero.set_process_input(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	self.visible = true


## Populates the journal with newly unlocked quests.
func add_quest(quest:Quest):
	quest_chooser.add_item(quest.name, icons[quest.status])
	quest_chooser.set_item_custom_fg_color(quest_chooser.item_count - 1, colors[quest.status])


## Ensures that the icon displayed matches the status of the quest.
func update_quest(quest:Quest):
	for i in quest_chooser.item_count:
		if quest_chooser.get_item_text(i) == quest.name:
			quest_chooser.set_item_icon(i, icons[quest.status])
			quest_chooser.set_item_custom_fg_color(i, colors[quest.status])
			return


func _init():
	print("Subscribing to quest channel")
	_quest_channel.quest_unlocked.connect(add_quest)
	_quest_channel.quest_accepted.connect(update_quest)
	_quest_channel.quest_completed.connect(update_quest)
	_quest_channel.quest_rewarded.connect(update_quest)


func _input(event):
	if event.is_action_pressed("journal"):
		if self.visible:
			close()
		else:
			open()


func _ready():
	self.visible = false
