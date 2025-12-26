extends State

@export var atkcp:AttackingComponent
@export var dash_speed:int = 100
@export var weapon_node:Node2D

func enter():
	if atkcp.is_on_cooldown():
		state_machine.pop_state()
		return
	
	if owner is CharacterBody2D:
		owner.velocity = Vector2.ZERO
		var mouse_pos = owner.get_global_mouse_position()
		weapon_node.look_at(mouse_pos)

	state_machine.animator.animation_finished.connect(_attack_finished)
	
	state_machine.animator.play_anim(&"attack")
	atkcp.start_attack()
	
	
	
func _attack_finished():
	state_machine.pop_state()
	
func physics_process(_delta:float):
	pass
	
