class_name EquipmentController
extends Node

const PICKUP_TEXT := "[F] to pickup "
const MAX_WEAPON_SLOTS := 2

@export var weapon_skin:Sprite2D
@export var ui_pickup:Label

@export var weapon_audio_player:AudioStreamPlayer2D
@export var weapon_hit_player:AudioStreamPlayer2D
@export var weapon_animation:AnimationPlayer

var can_pickup:bool = false

var equiped_weapons:Array[WeaponData] = []
var selected_weapon_slot = 1

func _ready() -> void:
	pass
	
func set_starting_weapons(primary_weapon:WeaponData, secondary_weapon:WeaponData):
	equiped_weapons.append(primary_weapon)
	equiped_weapons.append(secondary_weapon)

func allow_pickup(_info:String):
	can_pickup = true
	show_ui(_info)
	
func deny_pickup():
	can_pickup = false
	hide_ui()

func equip_new_weapon(weapon:WeaponData):	
	set_weapon_to_selected_slot(weapon)
	weapon_animation.speed_scale = weapon.atk_speed
	weapon_skin.texture = weapon.sprite
	weapon_skin.flip_v = weapon.flip_v
	weapon_audio_player.stream = weapon.weapon_sound
	weapon_hit_player.stream = weapon.weapon_hit_sound
	
func show_ui(item_name: String):
	if ui_pickup:
		ui_pickup.text = PICKUP_TEXT + item_name
		ui_pickup.visible = true
	
func hide_ui():
	if ui_pickup:
		ui_pickup.visible = false
		
func get_selected_weapon() -> WeaponData:
	return equiped_weapons[selected_weapon_slot-1]
	
func set_weapon_to_selected_slot(weapon:WeaponData):
	equiped_weapons[selected_weapon_slot-1] = weapon
	
func get_unselected_weapon():
	if selected_weapon_slot == 1:
		return equiped_weapons[selected_weapon_slot]
	else:
		return equiped_weapons[0]
		

func swap_weapon():
	selected_weapon_slot+=1
	if selected_weapon_slot > MAX_WEAPON_SLOTS:
		selected_weapon_slot = 1
	
	equip_new_weapon(get_selected_weapon())
