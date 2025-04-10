extends Node2D

var robots = [2, 3]
var current_robot = 0

var consumption = 0
var total_consumption = 0

var inside_room = true

@onready var energy = get_node("Control/VBoxContainer/HBoxContainer2/Energy")
@onready var current_energy = get_node("Control/VBoxContainer/HBoxContainer/CurrentEnergy")

func _ready() -> void:
	consumption = $Player.energy
	energy.text = str(consumption)

func _process(delta):
	if inside_room:
		total_consumption += consumption * delta
		current_energy.text = str(round(total_consumption*10)/10)

func _input(event):
	if not inside_room:
		if event.is_action_pressed("switch_robot"):
			current_robot = (current_robot + 1) % len(robots)
			$Player.set_robot(robots[current_robot])
			consumption = $Player.energy
			energy.text = str(consumption)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Inside a room")
		inside_room = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Outside a room")
		inside_room = false
