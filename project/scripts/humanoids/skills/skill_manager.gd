class_name SkillManager
extends Node2D

var selected_weapon: WeaponData
@export var skills_axe: Dictionary[String, SkillBase] = {}
@export var skills_bow: Dictionary[String, SkillBase] = {}
@export var skills_hand: Dictionary[String, SkillBase] = {}
@export var skills_sword: Dictionary[String, SkillBase] = {}

@export var anim_ctrl: AnimController
@export var input_handler: InputHandler = InputHandler.new()

signal skill_finished()

func _ready() -> void:
	for skill in skills_axe.values():
		skill.input_handler = input_handler
		skill.anim_ctrl = anim_ctrl
		skill.finished.connect(on_skill_finished)
	for skill in skills_bow.values():
		skill.input_handler = input_handler
		skill.anim_ctrl = anim_ctrl
		skill.finished.connect(on_skill_finished)
	for skill in skills_hand.values():
		skill.input_handler = input_handler
		skill.anim_ctrl = anim_ctrl
		skill.finished.connect(on_skill_finished)
	for skill in skills_sword.values():
		skill.input_handler = input_handler
		skill.anim_ctrl = anim_ctrl
		skill.finished.connect(on_skill_finished)

func use_skill(
	skill_name: String,
	direction: Vector2 = Vector2.ZERO,
	target_pos: Vector2 = Vector2.ZERO):
	var skill: SkillBase

	match selected_weapon.weapon_type:
		WeaponData.WeaponType.AXE:
			skill = skills_axe[skill_name]
		WeaponData.WeaponType.BOW:
			skill = skills_bow[skill_name]
		WeaponData.WeaponType.HAND:
			skill = skills_hand[skill_name]
		WeaponData.WeaponType.SWORD:
			skill = skills_sword[skill_name]

	if skill:
		skill.direction = direction
		skill.target_pos = target_pos
		skill.use()

func on_skill_finished():
	skill_finished.emit()
