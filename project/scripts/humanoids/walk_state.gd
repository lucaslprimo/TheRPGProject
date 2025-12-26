extends State
	
func enter():
	state_machine.input_handler.melee_attack.connect(_should_attack)
	
func process(_delta:float):
	state_machine.animator.play_anim(&"walk")
	check_input_vector()
	
func _should_attack():
	state_machine.stack_state(&"attack")

func physics_process(_delta:float):
	var input_vector = check_input_vector()
	
	if owner is CharacterBody2D:
		owner.velocity = state_machine.movcp.get_velocity_vector_smooth(input_vector, owner.velocity, _delta)
		owner.move_and_slide()
	
func check_input_vector():
	var input_vector = state_machine.input_handler.get_movement_vector()
	
	if input_vector.length() < 0.1:
		state_machine.change_state(&"idle")
	
	return input_vector
	
func exit():
	state_machine.input_handler.melee_attack.disconnect(_should_attack)
