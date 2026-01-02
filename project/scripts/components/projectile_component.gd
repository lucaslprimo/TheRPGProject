class_name ProjectileComponent extends Node

@export var speed: float = 10.0
@export var damage: int = 10
@export var knockback_force: int = 10
@export var lifetime: float = 5
@export var explosion:PackedScene
@export var hitbox:HitBox
@export var hit_sound:AudioStreamPlayer2D

var timer:Timer

var direction: Vector2 = Vector2.RIGHT

signal lifetime_over()
signal collided(body:Node2D, damage:int)

func _ready() -> void:
	hitbox.on_hit.connect(_process_attack)
	
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = lifetime 
	timer.one_shot = true
	timer.start()
	
func _physics_process(_delta: float) -> void:
	if owner:
		owner.position += direction * speed

func _on_timer_timeout() -> void:
	if owner:
		lifetime_over.emit()
		owner.queue_free()


func _process_attack(body:Hurtbox):
	speed = 0
	hitbox.set_deferred("monitoring", false)
	body.take_damage(damage, knockback_force, owner.global_position)
	var arrowSprite:Sprite2D = owner.get_node("Sprite2D")
	var tween = create_tween()
	tween.tween_property(arrowSprite, "modulate:a", 0, 0.5).set_delay(1)
	timer.wait_time = 2
	play_hit_sound()
	self.get_parent().call_deferred("reparent", body.get_parent())
	
func play_hit_sound():
	hit_sound.pitch_scale = randf_range(0.8, 1.2)
	hit_sound.play()
	
	
