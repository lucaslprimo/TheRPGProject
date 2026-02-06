extends State

@export var equip_ctrl: EquipmentController
	
func enter():
	super.enter()
	state_machine.input_handler.attack.connect(_should_attack)
	state_machine.input_handler.skill.connect(_should_skill)
	
func process(_delta: float):
	if not is_active:
		return
		
	state_machine.input_handler.process()
	state_machine.animator.play_anim(&"walk")
	check_input_vector()
	
func _should_attack():
	match equip_ctrl.get_selected_weapon().range_type:
		WeaponData.RangeType.MELEE:
			state_machine.stack_state(&"attack", false)
		WeaponData.RangeType.RANGED:
			state_machine.stack_state(&"ranged_attack", false)

func _should_skill(skill_name: String):
	state_machine.states[&"skill"].current_skill = skill_name
	state_machine.stack_state(&"skill", false)

func physics_process(_delta: float):
	if not is_active:
		return
	
	var input_vector = check_input_vector()
	
	if owner is CharacterBody2D:
		owner.velocity = state_machine.movcp.get_velocity(input_vector)
		owner.move_and_slide()
	
func check_input_vector():
	if not is_active:
		return
		
	var input_vector = state_machine.input_handler.get_movement_vector()
	
	if input_vector.length() < 0.1:
		state_machine.change_state(&"idle")
	
	return input_vector
	
func exit():
	super.exit()
	state_machine.input_handler.attack.disconnect(_should_attack)
	state_machine.input_handler.skill.disconnect(_should_skill)
