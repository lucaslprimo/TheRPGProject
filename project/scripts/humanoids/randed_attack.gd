extends State

@export var atkcp:ShootingComponent
@export var dash_speed:int = 100
@export var weapon_node:Node2D
@export var arrow_sprite:Sprite2D

var is_aiming = false

func enter():
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
	if is_aiming:
		state_machine.animator.play_anim(&"aim")
		weapon_node.look_at(weapon_node.get_global_mouse_position())
	
func _fire_attack():
	arrow_sprite.visible = false
	atkcp.fire(weapon_node.transform.x.normalized())
	is_aiming = false
	state_machine.pop_state()
	
func exit():
	weapon_node.visible = false
	state_machine.animator.animation_finished.disconnect(_fire_attack)
	state_machine.input_handler.attack_release.disconnect(_start_fire_anim)
