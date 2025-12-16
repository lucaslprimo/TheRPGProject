class_name ExplosionComponent extends Node

@export var apply_knockback: bool = true
@export var knockback_force: float = 200.0
@export var damage: int = 30

@export_group("Collision Filter")
@export var affect_groups: Array[StringName] = ["enemies", "players"]
@export var ignore_groups: Array[StringName] = []

var explosion_area:Area2D
var anim:AnimationPlayer

signal explosion_hit(target: Node, damage: int)
signal explosion_finished(hit_count: int)

func _ready() -> void:
	if owner.has_node("AnimationPlayer"):
		anim = owner.get_node("AnimationPlayer")
	
	if get_parent() is Area2D:
		explosion_area = get_parent()
		anim.play()
		anim.animation_finished.connect(func():queue_free())
		
func _explode_on_frame():
	var targets = explosion_area.get_overlapping_bodies()
	var hit_count = 0;
	
	for target in targets:
		if(Utils.should_collide_with(target, affect_groups, ignore_groups)):
			if target.has_method("apply_damage"):
				target.apply_damage(damage)
				hit_count+=1
				explosion_hit.emit(target, damage)
			
			explosion_finished.emit(hit_count)
	


	
