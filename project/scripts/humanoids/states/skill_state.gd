extends State

@export var skillManager: SkillManager
@export var equipmentCtrl: EquipmentController

var current_skill: String

func enter():
	var direction = state_machine.input_handler.get_target_dir()
	skillManager.skill_finished.connect(_on_anim_finished)
	skillManager.selected_weapon = equipmentCtrl.get_selected_weapon()
	skillManager.use_skill(current_skill, direction)
	
func process(_delta: float):
	pass
	
func _on_anim_finished():
	state_machine.pop_state()
	
func exit():
	state_machine.input_handler.reset_movement()
	skillManager.skill_finished.disconnect(_on_anim_finished)
