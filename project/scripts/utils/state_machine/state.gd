class_name State extends Node

var state_machine:StateMachine = null

@export var can_move:bool = false
@export var can_interact:bool = false

var debug := false

var is_active := false

func enter():
	if debug:
		print("Enter state:", name)
	pass
	
func process(_delta:float):
	pass	

func physics_process(_delta:float):
	pass
	
func exit():
	if debug:
		print("Exit state:", name)
	pass
