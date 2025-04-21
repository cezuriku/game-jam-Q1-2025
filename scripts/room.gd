extends Node2D
class_name Room

@export var dust_number = 5
@export var size: Vector2 = Vector2(1150, 650)


func _ready() -> void:
	$"/root/GlobalSignal".add_listener("puddle_cleaned", _update_dust)
	var area2d = Area2D.new()
	var collisionShape = CollisionShape2D.new()
	collisionShape.shape = RectangleShape2D.new()
	collisionShape.shape.size = size
	area2d.add_child(collisionShape)
	add_child(area2d)
	area2d.body_entered.connect(_on_area_2d_body_entered)
	area2d.body_exited.connect(_on_area_2d_body_exited)


func is_done():
	return dust_number < 1


func _update_dust(room_id):
	if room_id == get_instance_id():
		dust_number -= 1
	
		if dust_number == 0:
			$"/root/GlobalSignal".trigger_signal(
				"room_cleaned", []
			)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if dust_number > 0:
		if body.is_in_group("player"):
			$"/root/GlobalSignal".trigger_signal(
				"inside_room", [true]
			)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"/root/GlobalSignal".trigger_signal(
			"inside_room", [false]
		)
