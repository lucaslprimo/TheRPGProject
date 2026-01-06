extends TextureProgressBar

var healthcp:HealthComponent
var updated_hp:int 

@export var label:Label

func _ready() -> void:
	if owner is CharacterBody2D:
		healthcp = owner.get_node("HealthComponent")
		healthcp.hp_changed.connect(update_hp)
		max_value = healthcp.max_hp
		value = healthcp.current_hp
		updated_hp = healthcp.max_hp

func update_hp(_old_hp, new_hp):
	updated_hp = new_hp
	label.text = str(int(updated_hp))
	
func _process(_delta: float) -> void:
	if value != updated_hp:
		value = lerp(value, float(updated_hp), 0.2)
