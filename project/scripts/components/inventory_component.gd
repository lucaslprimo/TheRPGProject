class_name InventoryComponent
extends Node

@export var item_drop_template:PackedScene
@export var collector:CollectorComponent

var items:Array[ItemData] = []

var equiped_weapon_pos:int

signal updated_weapon(weapon:WeaponData)

func add_item(item:ItemData):
	items.append(item)
	
func remove_item(position:int):
	items.remove_at(position)
	
func equip_weapon(pos:int):
	if items[pos] is WeaponData: 
		if items[pos].name != "unarmed": 
			var drop:Item = item_drop_template.instantiate()
			drop.data = items[pos]
			drop.global_position = owner.global_position
			
		equiped_weapon_pos = pos
		updated_weapon.emit(items[pos])

	
