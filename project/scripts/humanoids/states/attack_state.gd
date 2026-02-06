extends State

@export var atkcp: AttackingComponent
@export var dash_speed: int = 10
@export var dash_duration: float = 0.1
@export var weapon_node: Node2D

var attack: int

func enter():
	super.enter()
	state_machine.input_handler.reset_movement()
	state_machine.input_handler.attack.connect(_should_attack)
	state_machine.animator.attack_animation_finished.connect(_attack_finished)
	
	if atkcp.is_on_cooldown():
		state_machine.pop_state()
		return

	attack = 1
	play_attack_anim()
	atkcp.start_attack()
	
func _attack_finished():
	if atkcp.has_attack_on_queue():
		attack += 1
		play_attack_anim()
	else:
		attack = 1
		state_machine.pop_state()
	
func physics_process(_delta: float):
	if owner is CharacterBody2D:
		owner.velocity = state_machine.movcp.get_velocity(Vector2.ZERO)
		owner.move_and_slide()
	
func _should_attack():
	atkcp.combo_attack()
	
func play_attack_anim():
	if owner is CharacterBody2D:
		owner.velocity = Vector2.ZERO
		weapon_node.look_at(state_machine.input_handler.get_target_pos())
		
		var tween = create_tween()
		tween.tween_property(owner, "position", owner.global_position + (state_machine.input_handler.get_target_dir() * dash_speed), dash_duration)
	
	state_machine.animator.play_anim(&"attack")
	state_machine.animator.play_attack_anim(&"attack_" + str(attack))
	
func exit():
	super.exit()
	state_machine.input_handler.attack.disconnect(_should_attack)
	state_machine.animator.attack_animation_finished.disconnect(_attack_finished)
