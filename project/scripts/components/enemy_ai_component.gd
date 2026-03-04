class_name EnemyAIComponenent
extends InputHandler

enum AIDecision {CHASE, ATTACK, IDLE}

@export var attack_type: WeaponData.RangeType = WeaponData.RangeType.MELEE:
	set(value):
		attack_type = value
		if attack_type == WeaponData.RangeType.MELEE:
			attack_distance = 40
		else:
			attack_distance = 150
				
@export var attack_distance: float
@export var awareness_range: Area2D

var is_aiming = false

var last_direction: Vector2 = Vector2.DOWN
var last_decision: AIDecision = AIDecision.IDLE

var target: Node2D
var body: Node2D

var timer: Timer

func _ready() -> void:
	awareness_range.area_entered.connect(_something_in_area)
	body = owner as Node2D
	
	timer = Timer.new()
	add_child(timer)
	
	timer.timeout.connect(_time_to_release_attack)
	
func _time_to_release_attack():
	attack_release.emit()

func _something_in_area(_body: Area2D):
	if _body.get_parent().is_in_group(&"players"):
		target = _body

func process():
	if target:
		last_direction = (target.global_position - body.global_position).normalized()
		if body.global_position.distance_to(target.global_position) > attack_distance:
			last_decision = AIDecision.CHASE
		else:
			last_decision = AIDecision.ATTACK
	else:
		last_direction = Vector2.ZERO
		last_decision = AIDecision.IDLE
	
	if last_decision == AIDecision.ATTACK:
		attack.emit()
		if attack_type == WeaponData.RangeType.RANGED:
			timer.wait_time = randf_range(0, 2)
			timer.one_shot = true
			timer.start()
			
func get_movement_vector() -> Vector2:
	if last_decision == AIDecision.CHASE:
		return last_direction
	else: return Vector2.ZERO
	
func get_target_pos() -> Vector2:
	if target:
		return target.global_position
	
	return Vector2.ZERO
	
func get_target_dir() -> Vector2:
	if target:
		return (target.global_position - owner.global_position).normalized()
	
	return Vector2.ZERO
