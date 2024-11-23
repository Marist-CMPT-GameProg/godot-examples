class_name Character
extends CharacterBody2D
## Base class for all game characters, whether player or AI-controlled.

## Movement rate for the character in pixels per second.
@export var speed = 300

# TODO Add additional Inspector-exported variables for configuring a
#     character's melee and ranged attacks, maximum stamina and health, and
#     rates of recovery-over-time for stamina and health.

# TODO Add current health and stamina properties, using setters to ensure that
#     stamina and health values are never outside the valid range.

# TODO Add a recovery timer variable.

# TODO Add methods for attack, shoot, and taking a hit/damage.


func _ready():
	# TODO Attach the melee attack node and revoery timer as children, then
	#    connect to the timer's timeout signal and start the timer
	pass


func _process(_delta):
	pass


func _physics_process(delta):
	move_and_collide(velocity * delta)


# TODO Add a callback to restore health and stamina when the recovery timer times out.
