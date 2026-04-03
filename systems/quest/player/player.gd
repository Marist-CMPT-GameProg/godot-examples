class_name Player extends CharacterBody2D
## Simple player behavior for a side-scrolling platformer.

## Sent whenever the player collects coins
signal collected(coins:int)

## Player walk speed in pixels/sec.
@export_range(0, 1000, 5) var SPEED:float = 300.0
## Vertical jump speed in pixels/sec.
@export_range(-1000, 0, 5) var JUMP_VELOCITY:float = -500.0
## Grace period, in seconds, to permit jumping at the start of a fall.
@export var FALL_DELAY:float = 0.2:
	set(_val): return # effectively const


var coins_collected:int = 0:
	set(val):
		coins_collected = val
		collected.emit(coins_collected)

var direction:float = 0
var is_falling:bool = false
var time_to_fall:float = FALL_DELAY

## Check whether the player is grounded or falling.
func ground_check(delta:float):
	if is_on_floor():
		if is_falling:
			$Avatar.play(&"landed")
			time_to_fall = FALL_DELAY
		is_falling = false
	else:
		velocity += get_gravity() * delta
		time_to_fall -= delta
		is_falling = time_to_fall <= 0


## Apply a vertical velocity to make the player jump if they are on the floor
func jump():
	velocity.y = JUMP_VELOCITY
	$Avatar.play(&"jump")


## Move the player left or right.
func move():
	direction = Input.get_axis(&"move_left", &"move_right")
	if is_falling: return
	if direction:
		$Avatar.play(&"walk")
		$Avatar.flip_h = (direction < 0)
	else:
		$Avatar.play(&"idle")


func _on_quest_rewarded(quest:Quest):
	coins_collected += quest.reward

func _ready() -> void:
	QuestChannel.quest_rewarded.connect(_on_quest_rewarded)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"jump"):
		if not is_falling: #and not $Avatar.animation == &"jump"
			$Avatar.play(&"crouch")
	if event.is_action(&"move"):
		move()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PAUSED:
		direction = 0
		$Avatar.play(&"idle")


func _physics_process(delta: float) -> void:
	ground_check(delta)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_avatar_animation_finished() -> void:
	match $Avatar.animation:
		&"crouch":
			jump()
		&"landed":
			$Avatar.play(&"idle")


func _on_poi_body_entered(body: Node2D) -> void:
	if body == self:
		print("POI reached!")
		jump()
