class_name AttackingComponent extends Node

@export var cooldown:float = 4
@export var damage:int = 20
@export var hitbox:HitBox

var cooldown_timer: Timer

var attack_state:AttackState = AttackState.IDLE

signal hit(body:Node2D, damage:int)

enum AttackState{
	IDLE, STARTED, ATTACKING, COOLDOWN
}

func _ready() -> void:
	hitbox.on_hit.connect(_process_attack)
	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.timeout.connect(func(): attack_state = AttackState.IDLE)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	
func start_attack():
	if attack_state != AttackState.IDLE:
		return
	
	attack_state = AttackState.STARTED
	cooldown_timer.start()
	
func _process_attack(body:Hurtbox):
	body.take_damage(damage,0, Vector2.ZERO)
	hit.emit(body, damage)
	
func is_on_cooldown() -> bool:
	return cooldown_timer.time_left > 0
	
	
	
