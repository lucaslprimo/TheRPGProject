extends State

@export var atkcp:AttackingComponent
@export var dash_speed:int = 100
@export var weapon_node:Node2D
@export var attack_number = 3

var in_combo = false

var attack:int

func enter():
	if atkcp.is_on_cooldown():
		state_machine.pop_state()
		return
	
	state_machine.input_handler.melee_attack.connect(_should_attack)

	state_machine.animator.animation_finished.connect(_attack_finished)
	
	attack = 1
	play_attack_anim()
	atkcp.attack()
	
func _attack_finished():
	if in_combo:
		play_attack_anim()
	else:
		state_machine.pop_state()
	
func physics_process(_delta:float):
	if owner is CharacterBody2D:
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO,_delta * dash_speed)
		owner.move_and_slide()
	
func _should_attack():
	if atkcp.combo_timer.time_left > 0:
		attack +=1
		if attack > attack_number:
			attack = 1
		in_combo = true
		
func play_attack_anim():
	if owner is CharacterBody2D:
		owner.velocity = Vector2.ZERO
		weapon_node.look_at(state_machine.input_handler.get_target_pos())
		owner.velocity = (state_machine.input_handler.get_target_pos() - owner.global_position).normalized() * 200
	
	state_machine.animator.play_anim(&"attack")
	state_machine.animator.play_attack_anim(&"attack_" + str(attack))
	in_combo = false
		
	
func exit():
	state_machine.input_handler.melee_attack.disconnect(_should_attack)
	
