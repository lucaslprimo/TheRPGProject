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
		
	
