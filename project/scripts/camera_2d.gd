extends Camera2D
class_name CameraHandler

@export var player:Node2D
		
func _physics_process(_delta: float) -> void:
	_update_pos()
	
func _update_pos():
	if player:
		global_position = player.global_position
