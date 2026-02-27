class_name Character
extends CharacterBody2D
## Base class for all game characters, whether player or AI-controlled.

# Properties for this character
@export var stats:CharacterStats
## Prefab scene defining a close-range attack for the character.
@export var melee_attack:PackedScene = preload("res://scenes/combat/melee_attack.tscn")
## Prefab scene defining a long-range attack for the character.
@export var ranged_attack:PackedScene = preload("res://scenes/combat/ranged_attack.tscn")

## Instance of the melee attack prefab.
@onready var melee:Attack = melee_attack.instantiate()


## Perform a melee attack
func attack() -> void:
	if melee.stats.energy_cost > stats.energy:
		return
	stats.energy -= melee.stats.energy_cost
	melee.activate()


## Perform a ranged attack
func shoot() -> void:
	var projectile:Attack = ranged_attack.instantiate()
	if projectile.stats.energy_cost > stats.energy:
		return
	
	projectile.spawn($AttackOrigin.global_position, self.rotation)
	stats.energy -= projectile.stats.energy_cost
	get_parent().add_child(projectile)
	projectile.activate()


## Inflict damage on this character.
func take_hit(damage:int) -> void:
	stats.health -= damage
	if stats.health <= 0:
		queue_free()


func _ready() -> void:
	melee = melee_attack.instantiate()
	add_child(melee)
	stats.health = stats.max_health
	stats.energy = stats.max_energy


func _process(_delta) -> void:
	pass


func _physics_process(delta) -> void:
	move_and_collide(velocity * delta)
