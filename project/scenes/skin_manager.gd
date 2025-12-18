@tool
class_name SkinManager
extends Sprite2D

enum SkinHumanoid{
	HUNTER,
	FIGHTER,
	MAGE,
	ROGUE
}

@export var selected_skin:int = 1:
	set(value):
		if skins and value > 0 and value <= skins.size():
			selected_skin = value
			update_skin(selected_skin)
		else:
			selected_skin = 1
			update_skin(1)

@export var skins:Array[Texture2D]

func _ready() -> void:
	update_skin(selected_skin)
	
func update_skin(skin:int):
	texture = skins[skin -1]
	
	
