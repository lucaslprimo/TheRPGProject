class_name MovementComponent extends Node

@export var max_speed:int = 300
@export var acceleration:int = 1200
@export var dash_force:int = 300

@export_range(0.1,1,0.1,"suffix:rate") var external_force_decay_rate = 0.1

var target_velocity:Vector2 = Vector2.ZERO

var external_force:Vector2 = Vector2.ZERO
var direction:Vector2 = Vector2.DOWN

func get_velocity_vector_smooth(move_vector:Vector2, current_velocity:Vector2, delta:float) -> Vector2:
	if(move_vector != Vector2.ZERO):
		direction = move_vector.normalized()
	
	target_velocity = move_vector * max_speed
	
	return current_velocity.move_toward(target_velocity, acceleration * delta)
	


	
