class_name EnemyAIComponenent
extends InputHandler

enum AttackType { MELEE, RANGED }

enum AIDecision { CHASE, ATTACK, IDLE }

@export var attack_type: AttackType = AttackType.MELEE
@export var attack_distance:float

var last_direction:Vector2 = Vector2.DOWN
var last_decision:AIDecision = AIDecision.IDLE

var target:Node2D
var body:Node2D

func _ready() -> void:
	target = get_tree().get_first_node_in_group(&"players")
	body = owner as Node2D

func process():
	if target:
		last_direction = (target.global_position - body.global_position).normalized()
		if  body.global_position.distance_to(target.global_position) > attack_distance:
			last_decision =  AIDecision.CHASE
		else:
			last_decision =  AIDecision.ATTACK
	else:
		last_direction = Vector2.ZERO
		last_decision = AIDecision.IDLE
	
	if last_decision == AIDecision.ATTACK:
		melee_attack.emit()
		
	
func get_movement_vector() -> Vector2:
	if last_decision == AIDecision.CHASE:
		return last_direction
	else: return Vector2.ZERO
	
func get_target_pos() -> Vector2:
	if target:
		return target.global_position
	
	return Vector2.ZERO
