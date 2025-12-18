class_name WalkState
extends State

@export var movcp:MovementComponent
	
func process(_delta:float):
	state_machine.animator.play_anim(&"walk")
	check_input_vector()

func physics_process(_delta:float):
	var input_vector = check_input_vector()
	
	if owner is CharacterBody2D:
		owner.velocity = movcp.get_velocity_vector_smooth(input_vector, owner.velocity, _delta)
		owner.move_and_slide()
	
func check_input_vector():
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector.length() < 0.1:
		state_machine.change_state(&"idle")
	
	return input_vector
	
func exit():
	pass
