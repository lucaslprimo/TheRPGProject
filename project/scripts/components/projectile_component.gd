class_name ProjectileComponent extends Node

@export var speed: float = 10.0
@export var damage: int = 10
@export var lifetime: float = 5.0
@export var explosion:PackedScene

@export_group("Collision Filter")
@export var collide_with_groups: Array[StringName] = ["enemies"]
@export var ignore_groups: Array[StringName] = ["projectiles"]

var timer:Timer

var direction: Vector2 = Vector2.RIGHT
var projectile_body:Area2D

signal lifetime_over()
signal collided(body:Node2D, damage:int)

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	if(get_parent() is Area2D):
		projectile_body = get_parent()
		projectile_body.body_entered.connect(_handle_colision)
	
	timer.wait_time = lifetime
	timer.one_shot = true
	timer.start()
	
func _physics_process(_delta: float) -> void:
	if(!projectile_body):
		return
		
	projectile_body.position += direction * speed

func _on_timer_timeout() -> void:
	lifetime_over.emit()
	
	if(!projectile_body):
		return
		
	projectile_body.queue_free()


func _handle_colision(body:Node2D):
	if(Utils.should_collide_with(body, collide_with_groups, ignore_groups)):
		if body.has_node("Components"):
			if body.get_node("Components").has_node("HealthComponent"):
				body.get_node("Components").get_node("HealthComponent").apply_damage(damage)
		collided.emit(body, damage)
		projectile_body.queue_free()
	
