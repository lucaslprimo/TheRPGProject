extends Node

@export var prefab:PackedScene = load("res://project/scenes/FloatingInfo.tscn")
@export var offset:Vector2 = Vector2.ZERO
@export var info_time:float = 0.5

enum InfoType{
	INFO,
	DAMAGE,
	HEAL,
	CRIT,
	POISON,
	FIRE,
	ICE
}

const TYPE_COLORS = {
	InfoType.INFO: Color.WHITE,
	InfoType.DAMAGE: Color.RED,
	InfoType.HEAL: Color.GREEN,
	InfoType.CRIT: Color.GOLD,
	InfoType.POISON: Color.PURPLE,
	InfoType.FIRE: Color.ORANGE_RED,
	InfoType.ICE: Color.CYAN
}

func get_color_for_type(type: InfoType) -> Color:
	return TYPE_COLORS.get(type, Color.WHITE)


func _ready() -> void:
	pass
	
func show(info:String, infoType:InfoType, position:Vector2):
	var floating_info:Node2D = prefab.instantiate()
	floating_info.global_position = position + offset
	
	floating_info.global_position += Vector2(randi_range(0,5), randi_range(0,5))
	
	var label:Label = floating_info.get_node("Label")
	label.text = info
	label.label_settings.font_color = get_color_for_type(infoType)
	get_tree().root.add_child(floating_info)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(floating_info, "position:y", floating_info.position.y - 10, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(floating_info, "modulate:a", 0, 0.5).set_delay(0.3)
	
	await get_tree().create_timer(info_time).timeout
	floating_info.queue_free()
	
	
	
