extends Node

@export var player_ui:PlayerUI
var player:Node2D

func _ready() -> void:
	var player = get_tree().get_first_node_in_group(&"players")
	if player:
		var player_main_controller:MainController= player.get_node("MainController")
		player_main_controller.player_ui = player_ui
		
