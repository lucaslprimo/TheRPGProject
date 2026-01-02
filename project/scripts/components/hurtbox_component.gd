class_name Hurtbox
extends Area2D

@export var healthcp:HealthComponent
@export var knockcp:KnockbackComponent
@export var particles:CPUParticles2D

func take_damage(_damage:int, _push_force:float, _source_position:Vector2):
	healthcp.apply_damage(_damage)
	var direction:Vector2 = owner.global_position - _source_position
	knockcp.apply_force(direction.normalized(), _push_force)
	particles.amount = _damage
	particles.rotation_degrees = randi_range(0,360)
	particles.restart()
	particles.emitting = true
	
	
	PopupText.show(str(_damage), PopupText.InfoType.DAMAGE, owner.global_position)
	
	CameraShake.wiggle(float(_damage)/100)
