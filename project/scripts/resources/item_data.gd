class_name ItemData
extends Resource

enum ItemType{
	WEAPON,
	CONSUMABLE
}

@export var sprite:Texture2D
@export var name := ""
@export var description := ""
@export var type:ItemType
