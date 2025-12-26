extends State

@export var sprite:Sprite2D

func enter():
	state_machine.animator.play_anim(&"died")
	Utils.flash(sprite)

func physics_process(_delta:float):
	if owner is CharacterBody2D:
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO,_delta * 300)
		owner.move_and_slide()
