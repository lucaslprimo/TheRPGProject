class_name Utils

static func should_collide_with(
	body:Node2D, 
	affects:Array[StringName], 
	ignores:Array[StringName]):
		# Verifica grupos permitidos
		for group in affects:
			if body.is_in_group(group):
				# Verifica exceções
				for ignore in ignores:
					if body.is_in_group(ignore):
						return false
				return true
		return false
		
static func flash(_sprite:Sprite2D, time = 0.2):
	_sprite.modulate = Color(5,5,5)
	await _sprite.get_tree().create_timer(time).timeout
	_sprite.modulate = Color.WHITE


static func shake(_sprite:Sprite2D, intensity := 1.0,time := 0.1):
	var tween = _sprite.create_tween()
	var offset = _sprite.offset
	tween.tween_property(_sprite,"offset",Vector2(-1,-1)*intensity,time/3)
	tween.tween_property(_sprite,"offset",Vector2.LEFT*intensity,time/3)
	tween.tween_property(_sprite,"offset",offset,time/3)
