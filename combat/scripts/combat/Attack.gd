class_name Attack
extends Area2D
## Base class for all attacks that a character can make
## Each attack progresses through three phases: activation, execution, and cooldown.
## An attack also has a collider that determines which objects are affected by the attack.


# TODO Implement this base class before implementing specific attack sub-classes
#    Each phase must have an Inspector-configurable duration variable as well as
#    a function that governs that phase and invokes the next one.
#    When a body enters the attack's collider, then the entering body takes damage.
