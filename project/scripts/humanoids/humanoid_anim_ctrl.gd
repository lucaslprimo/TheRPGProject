class_name HumanoideAnimController
extends AnimController

@export var animator:AnimationPlayer
@export var weapon_animator:AnimationPlayer
@export var skin_sprite:Sprite2D
@export var weapon_node:Node2D
@export var input_hanlder:InputHandler = InputHandler.new()
@export var weapon_sound_player:AudioStreamPlayer2D

func _ready() -> void:
	weapon_animator.animation_finished.connect(_anim_finished)
	
func _anim_finished(_animName):
	animation_finished.emit()
	
func reset():
	weapon_animator.stop()
	animator.stop()

func play_anim(_name:StringName):
	var anim_name = _name + get_sprite_suffix_by_direction(input_hanlder.get_target_dir())

	if animator.has_animation(_name):
		animator.play(_name)
	else:
		animator.play(anim_name)

func play_attack_anim(_name:StringName):
	if weapon_animator.has_animation(_name):
		weapon_animator.play(_name)
		play_sound()

func play_sound():
	weapon_sound_player.pitch_scale = randf_range(0.8, 1.2)
	weapon_sound_player.play()

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
	
func get_sprite_suffix_by_direction(direction: Vector2) -> StringName:
	if direction.length_squared() < 0.01:  # Threshold pequeno
		return "_down"
	
	var dir = direction.normalized()
   
	var angle_rad = dir.angle()
	var angle_deg = rad_to_deg(angle_rad)
	
	# Normaliza para 0-360
	if angle_deg < 0:
		angle_deg += 360
	
	# Agora aplica a mesma lógica da sua função original
	if angle_deg >= 45 and angle_deg < 135:
		# DOWN (90° ± 45°)
		weapon_node.scale.x = 1
		return "_down"
	elif angle_deg >= 135 and angle_deg < 225:
		# LEFT (180° ± 45°)
		skin_sprite.flip_h = true
		weapon_node.scale.x = -1
		return "_side"
	elif angle_deg >= 225 and angle_deg < 315:
		# UP (270° ± 45°)
		weapon_node.scale.x = 1
		return "_up"
	else:
		# RIGHT (0°/360° ± 45°)
		skin_sprite.flip_h = false
		weapon_node.scale.x = 1
		return "_side"
	
	
