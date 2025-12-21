class_name Hurtbox
extends Area2D

@export var healthcp:HealthComponent

func take_damage(damage:int, push_force:float, source_position:Vector2):
	healthcp.apply_damage(damage)
