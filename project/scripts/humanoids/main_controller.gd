class_name MainController
extends Node

const UNARMED_NAME := "unarmed"

@export var player_ui:PlayerUI:
	set(value):
		player_ui = value

@export var equipment_ctrl:EquipmentController
@export var hpcp:HealthComponent
@export var atkcp:AttackingComponent
@export var rangedcp:ShootingComponent
@export var collectorcp:CollectorComponent
@export var item_drop_template:PackedScene

@export var starting_weapon_primary:WeaponData
@export var starting_weapon_secondary:WeaponData


func _ready() -> void:
	equipment_ctrl.set_starting_weapons(starting_weapon_primary, starting_weapon_secondary) 
	_equip_weapon(starting_weapon_primary)
	
	collectorcp.allow_pickup.connect(_on_allow_pickup)
	collectorcp.deny_pickup.connect(_on_deny_pickup)
	
	hpcp.hp_changed.connect(_on_health_changed)
	
	if player_ui:
		player_ui.setup_hp(hpcp.max_hp)
		player_ui.update_primary_slot(starting_weapon_primary)
		player_ui.update_primary_slot(starting_weapon_secondary)
	
func _needs_swaping():
	return equipment_ctrl.get_selected_weapon().name != UNARMED_NAME and equipment_ctrl.get_unselected_weapon().name == UNARMED_NAME
	
func _equip_weapon(_weapon:WeaponData):
	if _needs_swaping():
		equipment_ctrl.swap_weapon()
		if player_ui:
			player_ui.swap_slots()
	else:
		_drop_weapon(equipment_ctrl.get_selected_weapon())
	
	equipment_ctrl.equip_new_weapon(_weapon)
	
	match _weapon.weapon_type:
		WeaponData.WeaponType.MELEE:
			atkcp.damage = _weapon.damage
			atkcp.knockback_force = _weapon.knockback_force
		WeaponData.WeaponType.RANGED:
			rangedcp.damage = _weapon.damage
			rangedcp.knockback_force = _weapon.knockback_force
	
	if player_ui:
		player_ui.update_primary_slot(_weapon)
		
func _drop_weapon(_weapon:WeaponData):
	if _weapon.name != UNARMED_NAME:
		var drop:Item = item_drop_template.instantiate()
		drop.data = _weapon
		drop.global_position = owner.global_position
		get_tree().root.add_child(drop)

func _input(event: InputEvent) -> void:
	if owner.is_in_group(&"players"):
		if event.is_action_pressed("interact"):
			var item = collectorcp.pickup()
			if item is Item:
				if item.data is WeaponData:
					_equip_weapon(item.data)
			
		if event.is_action_pressed("swap_weapons"):
			equipment_ctrl.swap_weapon()
			player_ui.swap_slots()


func _update_primary_weapon_ui(_weapon:WeaponData):
	if not player_ui:
		return
	
	player_ui.update_primary_slot(_weapon)
	
func _on_swaped_weapon():
	if not player_ui:
		return
		
	player_ui.swap_slots()
	
func _on_dropped_weapon():
	if not player_ui:
		return
		
	player_ui.clear_primary_slot()
		
	
func _on_health_changed(_old_hp, _new_hp):
	if not player_ui:
		return
		
	player_ui.update_hp(_new_hp)
	
func _on_allow_pickup(_info:String):
	equipment_ctrl.allow_pickup(_info)
	
func _on_deny_pickup():
	equipment_ctrl.deny_pickup()
