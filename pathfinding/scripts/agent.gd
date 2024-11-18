class_name Agent
extends Sprite2D
## Simple computer-controlled agent that navigates a grid-based world using the A* Search algorithm.

## Required for the agent to know about the world
@export var world:World
## Required for the agent to have a goal to go to
@export var goal:Node
## How many seconds between movement steps (smaller is faster)
@export var step_delay:float = 2

## Ensures the desired [member step_delay] between moves.
var step_timer:Timer
## Sequence of intermediate positions between the current position and the goal position.
var current_path:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	step_timer = Timer.new()
	step_timer.one_shot = true
	step_timer.timeout.connect(self.step)
	add_child(step_timer)

# Called when there is an input event.
func _input(event):
	if event.is_action_released("ui_accept"):
		var start_coords:Vector2i = position / world.tile_size
		var goal_coords:Vector2i = goal.position / world.tile_size
		print(start_coords, goal_coords)
		current_path = AStar.search(world, start_coords, goal_coords)
		if not current_path.is_empty():
			step_timer.start(step_delay)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Not currently used but left here for later

## Moves the agent to the next position on its current path, then restarts the timer for the next step.
func step():
	var next_coords = current_path.pop_back()
	position = next_coords * world.tile_size
	if len(current_path) > 0:
		step_timer.start(step_delay)
