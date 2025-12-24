class_name HitBox
extends Area2D

signal on_hit(body:Area2D)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(body:Area2D):
	if body is Hurtbox:
		on_hit.emit(body)
