extends Area2D

@export var size = 50.0

func _process(_delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			if body.global_position.distance_to(global_position) < size:
				$"/root/GlobalSignal".trigger_signal("puddle_cleaned", [get_parent().get_instance_id()])
				queue_free()
