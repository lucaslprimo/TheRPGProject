class_name AttackingComponent extends Node

@export var cooldown:float = 4
@export var damage:int = 20
@export var kockback_force:int = 20
@export var hitbox_list:Array[HitBox]
@export var combo_time:float = 5
@export var weapon_sound_player:AudioStreamPlayer2D
@export var blood_particles:CPUParticles2D

var combo_counter:int = 0
var cooldown_timer: Timer
var combo_timer: Timer
var attack_queue:int = 0
var click_counter = 0

signal hit(body:Node2D, damage:int)

func _ready() -> void:
	
	for hitbox in hitbox_list:
		hitbox.on_hit.connect(_process_attack)

	cooldown_timer = Timer.new()
	combo_timer = Timer.new()
	add_child(cooldown_timer)
	add_child(combo_timer)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	
	combo_timer.wait_time = combo_time
	combo_timer.one_shot = true
	
func start_attack():
	click_counter = 1
	combo_counter = 0
	cooldown_timer.start()
	combo_timer.start()
	
func combo_attack():
	if combo_timer.time_left > 0 and click_counter < hitbox_list.size():
		combo_timer.start()
		attack_queue+=1
		click_counter+=1
		
func has_attack_on_queue() -> bool:
	if attack_queue > 0:
		attack_queue-=1
		combo_counter+=1
		return true
	else:
		return false
		
func stop():
	attack_queue = 0
	combo_timer.stop()
	for hitbox in hitbox_list:
		hitbox.monitoring = false
		hitbox.get_node("FX").visible = false
		
func _process_attack(body:Hurtbox):
	body.take_damage(damage, kockback_force, owner.global_position)
	hit.emit(body, damage)
	play_hit_sound()
	
func is_on_cooldown() -> bool:
	return cooldown_timer.time_left > 0
	
func play_hit_sound():
	weapon_sound_player.pitch_scale = randf_range(0.8, 1.2)
	weapon_sound_player.play()
	
	
	
