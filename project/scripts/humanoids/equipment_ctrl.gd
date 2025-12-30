extends Node

@export var item_drop_template:PackedScene
@export var inv:InventoryComponent
@export var collector:CollectorComponent
@export var atkcp:AttackingComponent
@export var weapon_skin:Sprite2D
@export var ui_pickup:Label
@export var equiped_weapon:WeaponData
@export var weapon_audio_player:AudioStreamPlayer2D
@export var weapon_hit_player:AudioStreamPlayer2D
@export var weapon_animation:AnimationPlayer

var can_pickup:bool = false

func _ready() -> void:
	collector.allow_pickup.connect(_on_allow_pickup)
	collector.deny_pickup.connect(_on_deny_pickup)
	
	equip_new_weapon(equiped_weapon)

func _on_allow_pickup(_info:String):
	can_pickup = true
	
func _on_deny_pickup():
	can_pickup = false

func _input(event: InputEvent) -> void:
	if owner.is_in_group(&"players"):
		if event.is_action_pressed("interact"):
			pickup()
				
func pickup():
	var item = collector.pickup()
	if item is Item:
		if item.data is WeaponData:
			drop_equiped_weapon()
			equip_new_weapon(item.data)
				
func drop_equiped_weapon():
	if equiped_weapon.name != "unarmed":
		var drop:Item = item_drop_template.instantiate()
		drop.data = equiped_weapon
		drop.global_position = owner.global_position
		get_tree().root.add_child(drop)
		
		
func equip_new_weapon(weapon:WeaponData):
	equiped_weapon = weapon
	atkcp.damage = weapon.damage
	atkcp.kockback_force = weapon.kockback_force
	weapon_animation.speed_scale = weapon.atk_speed
	weapon_skin.texture = weapon.sprite
	weapon_skin.flip_v = weapon.flip_v
	weapon_audio_player.stream = weapon.weapon_sound
	weapon_hit_player.stream = weapon.weapon_hit_sound
