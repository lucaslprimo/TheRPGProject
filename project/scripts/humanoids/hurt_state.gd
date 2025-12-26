extends State

@export var hurt_duration:float
@export var sprite:Sprite2D

func enter():
	state_machine.animator.play_anim(&"idle")
	flash()
	shake()
	await get_tree().create_timer(hurt_duration).timeout
	state_machine.pop_state()
	

func flash(time = 0.2):
	sprite.modulate = Color(5,5,5)
	await get_tree().create_timer(time).timeout
	sprite.modulate = Color.WHITE


func shake(intensity := 2.0,time := 0.1):
	var tween = create_tween()
	var offset = sprite.offset
	tween.tween_property(sprite,"offset",Vector2(-1,-1)*intensity,time/3)
	tween.tween_property(sprite,"offset",Vector2.LEFT*intensity,time/3)
	tween.tween_property(sprite,"offset",offset,time/3)
	
