class_name InputHandler
extends Node

signal attack
signal attack_release

func process():
	pass

func get_movement_vector() -> Vector2:
	return Vector2.ZERO

func get_target_pos() -> Vector2:
	return Vector2.ZERO
	
func get_target_dir() -> Vector2:
	return Vector2.ZERO
	
func reset_movement():
	pass
