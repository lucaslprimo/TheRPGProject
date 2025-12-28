class_name PickupComponent
extends Area2D

func info() -> String:
	return "Item"
	
func get_item():
	return owner
