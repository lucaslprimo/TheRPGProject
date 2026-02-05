class_name SkillBase
extends Node2D

var can_use: bool = true
var cooldown: float = 0.0
var cooldown_timer: Timer

var direction: Vector2 = Vector2.ZERO
var target_pos: Vector2 = Vector2.ZERO

var anim_ctrl: AnimController

signal anim_finished

func _ready():
	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.timeout.connect(_on_cooldown_timeout)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	
func _on_anim_finished():
	anim_finished.emit()

func _on_cooldown_timeout():
	can_use = true

func use():
	if can_use:
		can_use = false
		cooldown_timer.start()
