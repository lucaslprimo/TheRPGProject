@tool
class_name HumanoidSettings
extends CharacterBody2D

@onready var skin: SkinManager = $Skin

@export var selected_skin:int = 1:
	set(value):
		if Engine.is_editor_hint():
			if skin.skins and value > 0 and value <= skin.skins.size():
				selected_skin = value
				skin.update_skin(selected_skin)
			else:
				selected_skin = 1
				skin.update_skin(1)
		else:
			selected_skin = value

func _ready():
	print(selected_skin)
	skin.update_skin(selected_skin)
