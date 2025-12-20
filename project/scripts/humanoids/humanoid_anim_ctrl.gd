class_name HumanoideAnimController
extends AnimController

@export var anim_skin:AnimationPlayer
@export var skin_sprite:Sprite2D
@export var movcp:MovementComponent

func play_anim(_name:StringName):
	anim_skin.play(_name + get_string_by_direction(movcp.direction))

func get_string_by_direction(direction:Vector2) -> StringName:
	if direction.y > 0:
		return "_down"
	elif direction.y < 0:
		return "_up"
	
	if direction.x > 0:
		skin_sprite.flip_h = false
		return "_side"
	elif direction.x < 0:
		skin_sprite.flip_h = true
		return "_side"
		
	return "_down"
	
	
	
	
		
