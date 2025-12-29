extends Node

@export var inv:InventoryComponent
@export var collector:CollectorComponent
@export var atkcp:AttackingComponent
@export var weapon_skin:Sprite2D
@export var ui_pickup:Label

var can_pickup:bool = false

func _ready() -> void:
	collector.allow_pickup.connect(_on_allow_pickup)
	collector.deny_pickup.connect(_on_deny_pickup)

func _on_allow_pickup(_info:String):
	can_pickup = true
	
func _on_deny_pickup():
	can_pickup = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var item = collector.pickup()
		if item is WeaponData:
			atkcp.damage = item.damage
			weapon_skin.texture = item.sprite
		
		
