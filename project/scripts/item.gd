class_name Item
extends Node2D

@export var sprite:Sprite2D

@export var data:ItemData:
	set(value):
		if value:
			data = value
			_update_sprite()

func _ready() -> void:
	_update_sprite()

func _update_sprite():
	if data:
		sprite.texture = data.sprite
