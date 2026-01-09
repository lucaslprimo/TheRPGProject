class_name EquipmentController
extends Node

const PICKUP_TEXT := "[F] to pickup "
const MAX_WEAPON_SLOTS := 2

@export var item_drop_template:PackedScene
@export var inv:InventoryComponent
@export var weapon_skin:Sprite2D
@export var ui_pickup:Label

@export var weapon_audio_player:AudioStreamPlayer2D
@export var weapon_hit_player:AudioStreamPlayer2D
@export var weapon_animation:AnimationPlayer

var can_pickup:bool = false

var equiped_weapons:Array = []
var selected_weapon_slot = 1

signal equiped_weapon(weapon:WeaponData)
signal dropped_weapon()

func _ready() -> void:
	pass
	
func starting_weapons(primary_weapon:WeaponData, secondary_weapon:WeaponData):
	equiped_weapons.append(primary_weapon)
	equiped_weapons.append(secondary_weapon)
	equip_new_weapon(primary_weapon)

func allow_pickup(_info:String):
	can_pickup = true
	show_ui(_info)
	
func deny_pickup():
	can_pickup = false
	hide_ui()
				
func pickup(weapon:WeaponData):
	if not weapon:
		return
		
	drop_equiped_weapon()
	equip_new_weapon(weapon)
				
func drop_equiped_weapon():
	if get_selected_weapon().name != "unarmed":
		var drop:Item = item_drop_template.instantiate()
		drop.data = get_selected_weapon()
		drop.global_position = owner.global_position
		get_tree().root.add_child(drop)
		dropped_weapon.emit()
		
		
func equip_new_weapon(weapon:WeaponData):	
	set_weapon_to_selected_slot(weapon)
	weapon_animation.speed_scale = weapon.atk_speed
	weapon_skin.texture = weapon.sprite
	weapon_skin.flip_v = weapon.flip_v
	weapon_audio_player.stream = weapon.weapon_sound
	weapon_hit_player.stream = weapon.weapon_hit_sound
	equiped_weapon.emit(weapon)
	
func show_ui(item_name: String):
	if ui_pickup:
		ui_pickup.text = PICKUP_TEXT + item_name
		ui_pickup.visible = true
	
func hide_ui():
	if ui_pickup:
		ui_pickup.visible = false
		
func get_selected_weapon():
	return equiped_weapons[selected_weapon_slot-1]
	
func set_weapon_to_selected_slot(weapon:WeaponData):
	equiped_weapons[selected_weapon_slot-1] = weapon

func swap_weapon():
	selected_weapon_slot+=1
	if selected_weapon_slot > MAX_WEAPON_SLOTS:
		selected_weapon_slot = 1
