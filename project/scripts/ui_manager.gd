class_name PlayerUI
extends CanvasLayer

@export var sprite_primary:Sprite2D
@export var sprite_secondary:Sprite2D
@export var hp_bar:TextureProgressBar
@export var hp_label:Label

@export var unarmed_sprite:Texture2D

func _ready() -> void:
	update_primary_slot(null)
	update_secondary_slot(null)
	
func update_primary_slot(weapon:WeaponData):
	if weapon:
		sprite_primary.texture = weapon.sprite
	else:
		sprite_primary.texture = unarmed_sprite
	
func update_secondary_slot(weapon:WeaponData):
	if weapon:
		sprite_secondary.texture = weapon.sprite
	else:
		sprite_secondary.texture = unarmed_sprite
		
func clear_primary_slot():
	update_primary_slot(null)

func clear_secondary_slot():
	update_secondary_slot(null)
		
func setup_hp(max_hp:int):
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp
	hp_label.text = str(max_hp)

func update_hp(hp:int):
	if hp >= 0:
		hp_bar.value = hp
		hp_label.text = str(hp)
		
func swap_slots():
	var temp = sprite_primary.texture
	sprite_primary.texture = sprite_secondary.texture
	sprite_secondary.texture = temp
	
