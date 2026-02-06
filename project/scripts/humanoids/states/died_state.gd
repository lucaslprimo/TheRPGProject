extends State

@export var sprite: Sprite2D

func enter():
	state_machine.animator.play_anim(&"died")
	Utils.flash(sprite)

func physics_process(_delta: float):
	if owner is CharacterBody2D:
		owner.velocity = state_machine.movcp.get_velocity(Vector2.ZERO)
		owner.move_and_slide()
