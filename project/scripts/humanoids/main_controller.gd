class_name MainController
extends Node

@export var player_ui:PlayerUI:
	set(value):
		player_ui = value

@export var equipment_ctrl:EquipmentController
@export var hpcp:HealthComponent
@export var atkcp:AttackingComponent
@export var rangedcp:ShootingComponent
@export var collectorcp:CollectorComponent

@export var starting_weapon_primary:WeaponData
@export var starting_weapon_secondary:WeaponData


func _ready() -> void:
	equipment_ctrl.equiped_weapon.connect(_on_equiped_weapon)
	equipment_ctrl.dropped_weapon.connect(_on_dropped_weapon)
	
	equipment_ctrl.starting_weapons(starting_weapon_primary, starting_weapon_secondary) 
	
	collectorcp.allow_pickup.connect(_on_allow_pickup)
	collectorcp.deny_pickup.connect(_on_deny_pickup)
	
	hpcp.hp_changed.connect(_on_health_changed)
	
	if player_ui:
		player_ui.setup_hp(hpcp.max_hp)
	
func _on_equiped_weapon(_weapon:WeaponData):
	match _weapon.weapon_type:
		WeaponData.WeaponType.MELEE:
			atkcp.damage = _weapon.damage
			atkcp.knockback_force = _weapon.knockback_force
		WeaponData.WeaponType.RANGED:
			rangedcp.damage = _weapon.damage
			rangedcp.knockback_force = _weapon.knockback_force


func _input(event: InputEvent) -> void:
	if owner.is_in_group(&"players"):
		if event.is_action_pressed("interact"):
			var item = collectorcp.pickup()
			if item is Item:
				if item.data is WeaponData:
					equipment_ctrl.pickup(item.data)
			
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
