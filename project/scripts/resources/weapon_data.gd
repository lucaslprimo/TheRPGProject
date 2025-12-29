class_name WeaponData
extends ItemData

enum WeaponType{
	MELEE,
	RANGED
}

@export var damage:int
@export var weapon_type:WeaponType
