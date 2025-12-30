class_name CollectorComponent
extends Area2D

var pickups:Array[PickupComponent] = []

signal allow_pickup(info:String)
signal deny_pickup()

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(_pickup:Area2D):
	
	if _pickup is PickupComponent:		
		pickups.append(_pickup)
		if not pickups.is_empty():
			allow_pickup.emit(pickups[0].info())

func _on_area_exited(_pickup:Area2D):
	if pickups.find(_pickup) != -1:
		pickups.remove_at(pickups.find(_pickup))
		
	if pickups.is_empty():
		deny_pickup.emit()
	else:
		allow_pickup.emit(pickups[0].info())
	
func pickup():
	if pickups.is_empty():
		return
		
	var pickup_object = pickups.pop_back()
	var item = pickup_object.get_item()
	pickup_object.delete()
	
	return item
