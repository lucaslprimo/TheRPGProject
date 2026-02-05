class_name WeaponData
extends ItemData

enum RangeType {
	MELEE,
	RANGED
}

enum WeaponType {
	BOW,
	SWORD,
	AXE,
	HAND
}

@export var damage: int
@export var range_type: RangeType
@export var weapon_type: WeaponType
@export var atk_speed: float = 1
@export var flip_v: bool = false
@export var scale_modifier: float = 1
@export var knockback_force: int = 10
@export var weapon_sound: AudioStream
@export var weapon_hit_sound: AudioStream
