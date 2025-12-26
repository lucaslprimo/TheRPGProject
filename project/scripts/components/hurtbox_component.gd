class_name Hurtbox
extends Area2D

@export var healthcp:HealthComponent
@export var knockcp:KnockbackComponent

func take_damage(_damage:int, _push_force:float, _source_position:Vector2):
	healthcp.apply_damage(_damage)
	var direction:Vector2 = owner.global_position - _source_position
	knockcp.apply_force(direction.normalized(), _push_force)
