extends InputHandler

@export var movcp:MovementComponent

enum PlayerSlot{
	Player_1,
	Player_2,
	Player_3,
	Player_4
}

@export var playerSlot:PlayerSlot = PlayerSlot.Player_1

func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left","move_right","move_up","move_down")
	
func _input(event: InputEvent) -> void:
	#Verifiy if this is my character with the information saved somewere
	if event.is_action_pressed("Attack"):
		melee_attack.emit()
		
func get_target_pos() -> Vector2:
	return movcp.direction
