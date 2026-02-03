extends State

@export var atkcp:ShootingComponent
@export var dash_speed:int = 200
@export var weapon_node:Node2D
@export var arrow_sprite:Sprite2D

var is_aiming = false

func enter():
	state_machine.movcp.apply_slow(0.8)
	weapon_node.visible = true
	arrow_sprite.visible = true
	state_machine.input_handler.attack_release.connect(_start_fire_anim)
	_aim_attack()

func _aim_attack():
	state_machine.animator.play_anim(&"attack")
	state_machine.animator.play_ranged_attack_anim(&"aim")
	is_aiming = true
	atkcp.aim()
	
func _start_fire_anim():
	state_machine.animator.animation_finished.connect(_fire_attack)
	state_machine.animator.play_ranged_attack_anim(&"fire")
	
func process(_delta:float):
	state_machine.input_handler.process()
	if is_aiming:
		state_machine.animator.play_anim(&"aim")
		weapon_node.look_at(state_machine.input_handler.get_target_pos())
		
func physics_process(_delta:float):
	if owner is CharacterBody2D:
		owner.velocity = state_machine.movcp.get_velocity_vector_smooth(check_input_vector(), owner.velocity, _delta)
		owner.move_and_slide()
	
func check_input_vector():
	var input_vector = state_machine.input_handler.get_movement_vector()
	
	return input_vector
	
func _fire_attack():
	arrow_sprite.visible = false
	atkcp.fire(weapon_node.transform.x.normalized())
	is_aiming = false
	state_machine.pop_state()
	
	if owner is CharacterBody2D:
		owner.velocity = Vector2.ZERO
		owner.velocity = (owner.global_position - state_machine.input_handler.get_target_pos()).normalized() * dash_speed
	
func exit():
	state_machine.input_handler.reset_movement()
	state_machine.movcp.reset_slow()
	weapon_node.visible = false
	state_machine.animator.animation_finished.disconnect(_fire_attack)
	state_machine.input_handler.attack_release.disconnect(_start_fire_anim)
