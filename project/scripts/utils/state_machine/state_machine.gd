class_name StateMachine extends Node

var states:Dictionary[StringName, State] = {}
var current_state:State

@export var animator:AnimController

var last_state:StringName = ""
var is_stacked:bool = false
var is_final_state:bool = false

func _ready() -> void:
	initialize()

func initialize():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.state_machine = self
			
	current_state = states[states.keys()[0]]
	current_state.enter()

func change_state(new_state:StringName):
	if not current_state:
		return
		
	if current_state.name == new_state:
		return
	
	current_state.exit()
	current_state = states[new_state]	
	current_state.enter()
	
	print("State changed to ", current_state.name)
	
func final_state(new_state:StringName):
	if not current_state:
		return
		
	if current_state.name == new_state:
		return
		
	is_final_state = true
	
	current_state.exit()
	current_state = states[new_state]	
	current_state.enter()
	
	print("State override to ", current_state.name)
	
func stack_state(new_state:StringName):
	if not current_state:
		return
	
	current_state.exit()
	if not is_stacked:
		last_state = current_state.name
		is_stacked = true
		
	current_state = states[new_state]
	
	current_state.enter()
	print("State stacked: ", current_state.name)
	
func pop_state():
	if not current_state:
		return
		
	if is_final_state:
		return
		
	is_stacked = false
	
	current_state.exit()
	current_state = states[last_state]
	current_state.enter()
	print("State poped to ", current_state.name)

func _process(_delta: float):
	current_state.process(_delta)
	
func _physics_process(_delta: float):
	current_state.physics_process(_delta)
