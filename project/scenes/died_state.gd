extends State


func enter():
	state_machine.animator.play_anim(&"died")
