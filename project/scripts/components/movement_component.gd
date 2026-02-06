class_name MovementComponent extends Node

@export var max_speed: int = 100

var direction: Vector2 = Vector2.DOWN

var slow_amount: float = 0.0

func apply_slow(amount: float):
	slow_amount = amount
	
func reset_slow():
	slow_amount = 0

func get_velocity(move_vector: Vector2) -> Vector2:
	if (move_vector != Vector2.ZERO):
		direction = move_vector.normalized()
	
	return move_vector.normalized() * (max_speed - max_speed * slow_amount)
