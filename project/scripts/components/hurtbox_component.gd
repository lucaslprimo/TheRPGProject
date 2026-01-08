class_name Hurtbox
extends Area2D

@export var healthcp:HealthComponent
@export var knockcp:KnockbackComponent
@export var particles_fab:PackedScene

func take_damage(_damage:int, _push_force:float, _source_position:Vector2):
	healthcp.apply_damage(_damage)
	var direction:Vector2 = owner.global_position - _source_position
	knockcp.apply_force(direction.normalized(), _push_force)
	
	instantiate_blood(_damage, _source_position)
	
	PopupText.show(str(_damage), PopupText.InfoType.DAMAGE, owner.global_position)
	
	CameraShake.wiggle(float(_damage)/100)
	
func instantiate_blood(_amount:int, _hit_source_pos:Vector2):
	var direction_from_source = (owner.global_position - _hit_source_pos).normalized()
	
	var blood:BloodParticles = particles_fab.instantiate()
	blood.particles.amount = _amount
	print(_hit_source_pos)
	blood.particles.direction = direction_from_source
	blood.global_position = owner.global_position
	get_tree().root.add_child(blood)
	blood.particles.emitting = true
