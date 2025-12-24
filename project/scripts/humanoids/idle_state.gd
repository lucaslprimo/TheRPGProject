class_name IdleState
extends State

@export var movcp:MovementComponent

func enter():
	state_machine.animator.play_anim(&"idle")
	
func process(_delta:float):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector.length() > 0:
		state_machine.change_state(&"walk")
		
func physics_process(_delta:float):
	if owner is CharacterBody2D:
		owner.velocity = movcp.get_velocity_vector_smooth(Vector2.ZERO, owner.velocity, _delta)
		owner.move_and_slide()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		state_machine.stack_state(&"attack")
	
