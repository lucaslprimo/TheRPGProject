extends State

@export var hurt_duration:float
@export var sprite:Sprite2D
@export var atkcp:AttackingComponent

func enter():
	atkcp.stop()
	state_machine.animator.play_anim(&"idle")
	Utils.flash(sprite)
	await get_tree().create_timer(hurt_duration).timeout
	state_machine.pop_state()

func physics_process(_delta:float):
	if owner is CharacterBody2D:
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO,_delta)
		owner.move_and_slide()


	
