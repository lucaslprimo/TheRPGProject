class_name AttackingComponent extends Node

@export var cooldown:float = 4
@export var damage:int = 20
@export var attack_area:Area2D

@export_group("Collision Filter")
@export var collide_with_groups: Array[StringName] = ["enemies"]
@export var ignore_groups: Array[StringName] = ["projectiles"]

var cooldown_timer: Timer

var already_hit:Array[Node2D] = []
var attack_state: AttackState = AttackState.IDLE

signal attack_started()
signal hit(body:Node2D, damage:int)

enum AttackState{
	IDLE, STARTED, ATTACKING, COOLDOWN
}

func _ready() -> void:
	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.timeout.connect(func(): attack_state = AttackState.IDLE)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	
func start_attack():
	if attack_state != AttackState.IDLE:
		return
	
	already_hit.clear()
	attack_state = AttackState.STARTED
	cooldown_timer.start()
	attack_started.emit()
	
func process_attack():
	if attack_state != AttackState.STARTED and attack_state != AttackState.ATTACKING:
		return
		
	attack_state = AttackState.ATTACKING
		
	if(attack_area):
		var targets = attack_area.get_overlapping_bodies()
		
		for target in targets:
			if(Utils.should_collide_with(target, collide_with_groups, ignore_groups) and target not in already_hit):
				if target.get_node("Components").has_node("HealthComponent"):
					hit.emit(hit, damage)
					target.get_node("Components").get_node("HealthComponent").apply_damage(damage)
					if target.get_node("Components").has_node("MovementComponent"):
						var direction = owner.get_node("Components").get_node("MovementComponent").direction
						target.get_node("Components").get_node("MovementComponent").apply_force(direction, damage)
					already_hit.append(target)
	
func is_on_cooldown() -> bool:
	return cooldown_timer.time_left > 0
	
	
	
