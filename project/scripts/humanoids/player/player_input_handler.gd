extends InputHandler

@export var movcp:MovementComponent
@export var weapon_node:Node2D

var move_to:Vector2

var _should_move = false

var player:CharacterBody2D

enum PlayerSlot{
	Player_1,
	Player_2,
	Player_3,
	Player_4
}

@export var playerSlot:PlayerSlot = PlayerSlot.Player_1

func _ready() -> void:
	if owner is CharacterBody2D:
		player = owner

func get_movement_vector() -> Vector2:
	if _should_move:
		return (move_to - player.global_position).normalized()
		
	return Vector2.ZERO

func process():
	print(player.global_position.distance_to(player.get_global_mouse_position()))
	if player.global_position.distance_to(move_to) < 10:
		_should_move = false

func _input(event: InputEvent) -> void:
	#Verifiy if this is my character with the information saved somewere
	if event.is_action_pressed("attack"):
		_should_move = false
		melee_attack.emit()
	
	if event.is_action_pressed("move"):
		_should_move = true
		move_to = player.get_global_mouse_position()


func get_target_pos() -> Vector2:
	return player.get_global_mouse_position()
	
func get_target_dir() -> Vector2:
	if owner is CharacterBody2D:
		return (owner.get_global_mouse_position() - owner.global_position).normalized()
	
	return Vector2.ZERO
