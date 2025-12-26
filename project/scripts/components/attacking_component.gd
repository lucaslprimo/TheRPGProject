class_name AttackingComponent extends Node

@export var cooldown:float = 4
@export var damage:int = 20
@export var hitbox1:HitBox
@export var hitbox2:HitBox
@export var hitbox3:HitBox
@export var combo_time:float = 5

var cooldown_timer: Timer
var combo_timer: Timer

var attack_state:AttackState = AttackState.IDLE

signal hit(body:Node2D, damage:int)

enum AttackState{
	IDLE, ATTACK1, ATTACK2, COOLDOWN
}

func _ready() -> void:
	hitbox1.on_hit.connect(_process_attack)
	hitbox2.on_hit.connect(_process_attack)
	hitbox3.on_hit.connect(_process_attack)
	cooldown_timer = Timer.new()
	combo_timer = Timer.new()
	add_child(cooldown_timer)
	add_child(combo_timer)
	cooldown_timer.timeout.connect(func(): attack_state = AttackState.IDLE)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	
	combo_timer.wait_time = combo_time
	combo_timer.one_shot = true
	
func attack():
	attack_state = AttackState.ATTACK1
	cooldown_timer.start()
	combo_timer.start()
	
func _process_attack(body:Hurtbox):
	body.take_damage(damage, damage, owner.global_position)
	hit.emit(body, damage)
	
func is_on_cooldown() -> bool:
	return cooldown_timer.time_left > 0
	
	
	
