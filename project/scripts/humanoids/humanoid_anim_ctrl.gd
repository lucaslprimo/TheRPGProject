class_name HumanoideAnimController
extends AnimController

@export var animator:AnimationPlayer
@export var weapon_animator:AnimationPlayer
@export var skin_sprite:Sprite2D
@export var weapon_node:Node2D
@export var movcp:MovementComponent

func _ready() -> void:
	weapon_animator.animation_finished.connect(_anim_finished)
	
func _anim_finished(_animName):
	animation_finished.emit()
	
func reset():
	weapon_animator.stop()
	animator.stop()

func play_anim(_name:StringName):
	var anim_name = _name + get_string_by_direction(movcp.direction)

	if animator.has_animation(_name):
		animator.play(_name)
	else:
		animator.play(anim_name)

func play_attack_anim(_name:StringName):
	if weapon_animator.has_animation(_name):
		weapon_animator.play(_name)

func get_string_by_direction(direction:Vector2) -> StringName:
	if direction.y > 0:
		weapon_node.scale.x = 1
		return "_down"
	elif direction.y < 0:
		weapon_node.scale.x = 1
		return "_up"
	
	if direction.x > 0:
		skin_sprite.flip_h = false
		weapon_node.scale.x = 1
		return "_side"
	elif direction.x < 0:
		weapon_node.scale.x = -1
		skin_sprite.flip_h = true
		return "_side"
		
	return "_down"
	
	
	
	
		
