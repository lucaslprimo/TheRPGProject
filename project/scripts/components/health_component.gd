class_name HealthComponent extends Node

@export var max_hp = 100
var current_hp = max_hp
var alive = true

signal hp_changed(old_value,new_value)
signal hurt(value)
signal healed(value)
signal died()

func _ready() -> void:
	current_hp = max_hp

func apply_damage(damage:int):
	var old_hp = current_hp
	current_hp-= damage
	
	if(current_hp <= 0):
		current_hp = 0
		alive = false
		died.emit()
		
	hp_changed.emit(old_hp,current_hp)
	hurt.emit(damage)
	
func apply_heal(healing:int):
	var old_hp = current_hp
	current_hp+= healing
	
	if(current_hp>healing):
		current_hp = max_hp
		
	hp_changed.emit(old_hp,current_hp)
	healed.emit(healing)
