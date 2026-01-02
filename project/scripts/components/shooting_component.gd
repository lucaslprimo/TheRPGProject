class_name ShootingComponent extends Node

@export var ammo: int = -1
@export var ammo_consumption: int = 1
@export var damage:int
@export var knockback_force:int
@export var accuracy:float = 0.5
@export var projectile: PackedScene
@export var shooting_point: Node2D
@export var cooldown_time: float = 1.0
@export var aiming_time_limit:float = 2

var colddown_timer = Timer
var aiming_time:float = 0

var damage_

var is_aiming = false

signal not_ready_to_shoot()
signal out_of_ammo()
signal fired()

func _ready() -> void:
	colddown_timer = Timer.new()
	add_child(colddown_timer)
	colddown_timer.wait_time = cooldown_time
	colddown_timer.one_shot = true
	
func aim():
	aiming_time = 0
	is_aiming = true
	
func _process(delta: float) -> void:
	if is_aiming:
		aiming_time += delta
 
func fire(direction:Vector2):
	if colddown_timer.time_left > 0:
		not_ready_to_shoot.emit()
		return
		
	var final_damage = calculate_charge_value(damage, aiming_time, aiming_time_limit)
	var final_knockback = calculate_charge_value(knockback_force, aiming_time, aiming_time_limit)
	
	var final_direction = direction.rotated(calculate_shot_accuracy(aiming_time, aiming_time_limit))
	
	print("final_damage", final_damage)
	
	aiming_time = 0
	is_aiming = false

	if not _has_ammo():
		out_of_ammo.emit()
		return

	if(projectile):
		var p_instance = projectile.instantiate()
		p_instance.global_position = shooting_point.global_position
		p_instance.rotation = final_direction.angle()
		var projcp:ProjectileComponent = p_instance.get_node("ProjectileComponent")
		projcp.direction = final_direction
		
		projcp.damage = final_damage
		projcp.knockback_force = final_knockback
		print("projectile_damage",projcp.damage)
		get_tree().root.add_child(p_instance)
		_decrease_ammo()
		fired.emit()
		colddown_timer.start()
		
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
	return colddown_timer.time_left > 0
	
func calculate_charge_value(base_value: float, charge_time: float,
	max_charge_time: float) -> float:
	const QUICK_SHOT_THRESHOLD = 0.1
	const QUICK_SHOT_DAMAGE = 0.1     #
	
	var charge_ratio = min(charge_time / max_charge_time, 1.0)

	if charge_ratio < QUICK_SHOT_THRESHOLD:
		return base_value * QUICK_SHOT_DAMAGE
	
	return base_value * charge_ratio
	
func calculate_shot_accuracy(charge_time: float, max_charge_time: float) -> float:
	# Accuracy baseada no charge (0-100%)
	var accuracy_percentage = get_accuracy_percentage(charge_time, max_charge_time)
	
	# Converte para ângulo máximo de desvio
	var max_spread_angle = deg_to_rad(30.0)  # Máximo 30° de desvio
	var current_spread = max_spread_angle * (1.0 - accuracy_percentage)
	
	# Gera ângulo aleatório dentro do spread
	var random_angle = randf_range(-current_spread, current_spread)
	
	return random_angle
	
func get_accuracy_percentage(charge_time: float, max_charge_time: float) -> float:
	
	var charge_ratio = min(charge_time / max_charge_time, 1.0)
	
	var min_accuracy = accuracy  
	var accuracy = lerp(min_accuracy, 1.0, charge_ratio)
	
	return accuracy
