class_name SkillDash
extends SkillBase

@export var dash_distance: float = 40.0
@export var dash_duration: float = 0.15

@export var trail_particles: CPUParticles2D
@export var dash_sound: AudioStream
var audio_player: AudioStreamPlayer

func _ready():
	cooldown = dash_duration
	super._ready()
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = dash_sound
	add_child(audio_player)

func use():
	if can_use:
		
		super.use()
		anim_ctrl.play_anim("attack")
		trail_particles.emitting = true
		audio_player.pitch_scale = randf_range(1, 1.2)
		audio_player.play()
		var tween = create_tween()
		tween.tween_property(owner, "position", owner.global_position + (direction * dash_distance), dash_duration)
		await get_tree().create_timer(dash_duration).timeout
		finished.emit()
		trail_particles.emitting = false
