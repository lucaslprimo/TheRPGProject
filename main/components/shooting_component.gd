class_name ShootingComponent extends Node

@export var ammo: int = -1
@export var ammo_consumption: int = 1
@export var projectile: PackedScene
@export var shooting_point: Node2D
@export var cooldown_time: float = 1.0
var timer = Timer

signal not_ready_to_shoot()
signal out_of_ammo()
signal fired()

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = cooldown_time
	timer.one_shot = true

func fire(direction:Vector2):
	if timer.time_left > 0:
		not_ready_to_shoot.emit()
		return

	if not _has_ammo():
		out_of_ammo.emit()
		return

	if(projectile):
		var p_instance = projectile.instantiate()
		p_instance.global_position = shooting_point.global_position
		p_instance.rotation = direction.angle()
		p_instance.get_node("ProjectileComponent").direction = direction
		get_tree().root.add_child(p_instance)
		_decrease_ammo()
		fired.emit()
		timer.start()
		
func _has_ammo() -> bool:
	if ammo == -1 || ammo > 0 :
		return true
	else:
		return false
		
func _decrease_ammo():
	if ammo == -1:
		return
		
	ammo -= ammo_consumption
	if ammo < 0:
		ammo = 0

func is_on_cooldown() -> bool:
	return timer.time_left > 0
