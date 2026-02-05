class_name SkillDash
extends SkillBase

@export var dash_distance: float = 40.0
@export var dash_duration: float = 0.15

func _ready():
	cooldown = dash_duration
	super._ready()

func use():
	if can_use:
		super.use()
		anim_ctrl.play_anim("attack")
		var tween = create_tween()
		tween.tween_property(get_parent().get_parent(), "position", get_parent().get_parent().global_position + (direction* dash_distance), dash_duration)
