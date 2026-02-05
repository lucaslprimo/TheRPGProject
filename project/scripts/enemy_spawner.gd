extends Node2D

@export var enemy_prefab: PackedScene
@export var skins: Array[int]
@export var radius_area2d: Area2D
@export var count: int = 1
@export var one_shot: bool = false
@export var interval: float = 1
@export var weapons: Array[WeaponData]
@export var spawn_layer_target: Node2D

@export var punch_weapon_data: WeaponData

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = interval
	timer.one_shot = one_shot
	timer.start()
	
	timer.timeout.connect(_time_finished)
	
	spawn()
	
func _time_finished():
	if one_shot:
		return
		
	spawn()

func spawn():
	for x: int in count:
		var enemy: HumanoidBase = enemy_prefab.instantiate()
		var randon_skin = randi_range(0, skins.size() - 1)
		enemy.selected_skin = skins[randon_skin] + 1
		var main_controller: MainController = enemy.get_node("MainController")
		main_controller.starting_weapon_primary = weapons[randi_range(0, weapons.size() - 1)]
		
		var ai_enemy: EnemyAIComponenent = enemy.get_node("EnemyAIComponenent")
		ai_enemy.attack_type = main_controller.starting_weapon_primary.range_type
		
		spawn_layer_target.add_child.call_deferred(enemy)
		enemy.global_position = get_uniform_position_in_circle()

func get_uniform_position_in_circle() -> Vector2:
	var radius = get_radius_from_area2d(radius_area2d)
	
	var angle = randf_range(0, TAU)
	var r = sqrt(randf_range(0, 1)) * radius # sqrt para distribuição uniforme
	
	return global_position + Vector2(
		cos(angle) * r,
		sin(angle) * r
	)
	
func get_radius_from_area2d(area: Area2D):
	var shape = area.get_node("CollisionShape2D").shape
	if shape is CircleShape2D:
		var circle_shape = shape as CircleShape2D
		var radius = circle_shape.radius
		
		return radius
