extends Node2D
class_name Room

@export var dust_number = 5
@export var size: Vector2 = Vector2(1150, 650)


func _ready() -> void:
	$"/root/GlobalSignal".add_listener("puddle_cleaned", _update_dust)


func is_done():
	return dust_number < 1


func _update_dust(room_id):
	if room_id == get_instance_id():
		dust_number -= 1

	if dust_number == 0:
		print("bravo tu as gagné")
