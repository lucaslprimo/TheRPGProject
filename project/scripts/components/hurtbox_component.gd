class_name Hurtbox
extends Area2D

@export var healthcp:HealthComponent

func take_damage(_damage:int, _push_force:float, _source_position:Vector2):
	healthcp.apply_damage(_damage)
