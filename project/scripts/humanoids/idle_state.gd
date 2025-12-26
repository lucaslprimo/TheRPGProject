extends State

func enter():
	state_machine.input_handler.melee_attack.connect(_should_attack)
	state_machine.animator.play_anim(&"idle")
	
func _should_attack():
	state_machine.stack_state(&"attack")
	
func process(_delta:float):
	var input_vector = state_machine.input_handler.get_movement_vector()
	
	if input_vector.length() > 0:
		state_machine.change_state(&"walk")
		
func physics_process(_delta:float):
	if owner is CharacterBody2D:
		owner.velocity = state_machine.movcp.get_velocity_vector_smooth(Vector2.ZERO, owner.velocity, _delta)
		owner.move_and_slide()
		
func exit():
	state_machine.input_handler.melee_attack.disconnect(_should_attack)
