class_name MovementComponent extends Node

@export var max_speed:int = 100
@export var acceleration:int = 500
@export var desceleration:int = 500

var target_velocity:Vector2 = Vector2.ZERO

var direction:Vector2 = Vector2.DOWN

func get_velocity_vector_smooth(move_vector:Vector2, current_velocity:Vector2, delta:float) -> Vector2:
	if(move_vector != Vector2.ZERO):
		direction = move_vector.normalized()
	
	target_velocity = move_vector.normalized() * max_speed
	
	if target_velocity == Vector2.ZERO:
		return current_velocity.move_toward(target_velocity, desceleration * delta)
	else:
		return current_velocity.move_toward(target_velocity, acceleration * delta)
	
	
	


	
