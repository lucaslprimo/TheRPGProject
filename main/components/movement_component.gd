class_name MovementComponent extends Node

@export var speed:int = 300
@export var dash_force:int = 300
@export_range(0,100,1,"suffix:%") var resistence:int = 0
@export var external_force_multiplier = 3
@export_range(0.1,1,0.1,"suffix:rate") var external_force_decay_rate = 0.1

var external_force:Vector2 = Vector2.ZERO
var direction:Vector2 = Vector2.DOWN

func get_velocity_vector(move_vector:Vector2) -> Vector2:
	if(move_vector != Vector2.ZERO):
		direction = move_vector.normalized()
	
	var base_velocity =  move_vector * speed
	var total_velocity = base_velocity + external_force
	
	external_force = external_force - external_force*external_force_decay_rate
	return total_velocity
	
func dash(custom_direction):
	if(custom_direction):
		external_force += (custom_direction * dash_force)
	else:
		external_force += (direction * dash_force)
	
func apply_force(_direction: Vector2, force: float = 200):
	
	force -= force * resistence/100
	
	external_force += _direction * force * external_force_multiplier
