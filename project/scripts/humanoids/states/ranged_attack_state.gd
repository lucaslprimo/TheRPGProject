extends State

@export var atkcp: ShootingComponent
@export var dash_speed: int = 10
@export var dash_duration: float = 0.1
@export var weapon_node: Node2D
@export var arrow_sprite: Sprite2D

var is_aiming = false

func enter():
	state_machine.movcp.apply_slow(0.8)
	weapon_node.visible = true
	arrow_sprite.visible = true
	state_machine.input_handler.attack_release.connect(_start_fire_anim)
	_aim_attack()

func _aim_attack():
	state_machine.animator.play_anim(&"attack")
	state_machine.animator.play_ranged_attack_anim(&"aim", true)
	is_aiming = true
	atkcp.aim()
	
func _start_fire_anim():
	state_machine.animator.attack_animation_finished.connect(_fire_attack)
	state_machine.animator.play_ranged_attack_anim(&"fire")
	
func process(_delta: float):
	state_machine.input_handler.process()
	if is_aiming:
		state_machine.animator.play_anim(&"aim")
		weapon_node.look_at(state_machine.input_handler.get_target_pos())
	
	
func check_input_vector():
	var input_vector = state_machine.input_handler.get_movement_vector()
	
	return input_vector
	
func _fire_attack():
	arrow_sprite.visible = false
	
	if atkcp.aiming_time > 0.2:
		var tween = create_tween()
		tween.tween_property(owner, "position", owner.global_position + (state_machine.input_handler.get_target_dir() * dash_speed * -1), dash_duration)
	
	atkcp.fire(weapon_node.transform.x.normalized())
	is_aiming = false
	state_machine.pop_state()
	
	
	
	
func exit():
	state_machine.input_handler.reset_movement()
	state_machine.movcp.reset_slow()
	weapon_node.visible = false
	state_machine.animator.attack_animation_finished.disconnect(_fire_attack)
	state_machine.input_handler.attack_release.disconnect(_start_fire_anim)
