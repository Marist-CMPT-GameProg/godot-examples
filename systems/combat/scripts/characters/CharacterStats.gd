class_name CharacterStats
extends Resource
## Base resource class for holding properties common to all attacks

## Health cannot exceed this value (unless altered by an effect).
@export var max_health:int
## Energy cannot exceed this value (unless altered by an effect)
@export var max_energy:int
## Movement rate for the character in pixels per second.
@export var speed:int

## Energy recovery rate in points per sec
@export  var energy_recoverry:int
## Health recovery rate in points per second
@export var health_recovery:int

## Current health level (must be initialized in the character).
var health:int
## Current energy level (must be initialized in the character).
var energy:int
