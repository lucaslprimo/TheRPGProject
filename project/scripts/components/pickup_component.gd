class_name PickupComponent
extends Area2D

func info() -> String:
	if owner is Item:
		return owner.data.name
	else:
		return "Unknown"
	
func get_item():
	if owner is Item:
		return owner
	
func delete():
	owner.queue_free()
