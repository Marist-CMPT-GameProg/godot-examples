class_name QuestJournal extends CanvasLayer
## User interface component for displaying the status of unlocked quests.


## Status icons for conveying the statuses of quests in the journal.
@export var icons:Array[Texture2D]
## Custom text colors to help convey the statuses of quests in the journal.
@export var colors:Array[Color]

## The list control where known quests are displayed.
@onready var quest_chooser:ItemList = $Chooser/QuestList


## Hides the quest journal and unpauses the game.
func close() -> void:
	self.visible = false
	get_tree().paused = false


## Pauses the game and displays the quest journal.
func open() -> void:
	get_tree().paused = true
	self.visible = true


## Populates the journal with a newly unlocked quest.
func add_quest(quest:Quest):
	quest_chooser.add_item(quest.name, icons[quest.status])
	quest_chooser.set_item_custom_fg_color(quest_chooser.item_count - 1, colors[quest.status])


## Ensures that the icon displayed matches the status of the quest.
func update_quest(quest:Quest):
	for i in quest_chooser.item_count:
		if quest_chooser.get_item_text(i) == quest.name:
			quest_chooser.set_item_icon(i, icons[quest.status])
			quest_chooser.set_item_custom_fg_color(i, colors[quest.status])
			return # short-circuit to be done after finding the matching quest


# Called when there is an input event.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_quest_journal"):
		get_viewport().set_input_as_handled()
		self.close()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	QuestChannel.quest_accepted.connect(update_quest)
	QuestChannel.quest_completed.connect(update_quest)
	QuestChannel.quest_rewarded.connect(update_quest)
	QuestChannel.quest_unlocked.connect(add_quest)
