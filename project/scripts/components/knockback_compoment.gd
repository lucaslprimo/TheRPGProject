# knockback_component.gd
class_name KnockbackComponent
extends Node

@export_range(0,100,1,"suffix:%") var resistence:int = 0
@export var external_force_multiplier = 1

func apply_force(_direction: Vector2, _force: float = 200):
	if owner is CharacterBody2D:
		_force -= _force * resistence/100
		owner.velocity = _direction * _force * external_force_multiplier
