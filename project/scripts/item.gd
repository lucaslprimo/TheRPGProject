class_name Item
extends Node2D

@export var sprite:Sprite2D

@export var data:ItemData:
	set(value):
		sprite.texture = data.sprite
		
