class_name BloodParticles	
extends Node2D

@export var particles:CPUParticles2D

func _ready() -> void:
	await get_tree().create_timer(particles.lifetime).timeout
	queue_free()
	
