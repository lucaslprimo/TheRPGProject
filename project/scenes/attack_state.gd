class_name Attack_State
extends State

@export var movcp:MovementComponent

func enter():
	state_machine.animator.animation_finished.connect(_attack_finished)
	state_machine.animator.play_anim(&"attack")
	
func _attack_finished():
	state_machine.pop_state()
	
func physics_process(_delta:float):
	if owner is CharacterBody2D:
		owner.move_and_slide()
