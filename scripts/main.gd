extends Node2D

var robots = [2, 3, 4]
var current_robot = 0

var consumption = 0
var total_consumption = 0

var inside_room = false

@onready var energy = get_node("Camera2D/Control/VBoxContainer/HBoxContainer2/Energy")
@onready var current_energy = get_node("Camera2D/Control/VBoxContainer/HBoxContainer/CurrentEnergy")

func _ready():
	consumption = $Player.energy
	energy.text = str(consumption)

func _process(delta):
	if inside_room:
		total_consumption += consumption * delta
		current_energy.text = str(round(total_consumption*10)/10)
		$Camera2D.position = lerp($Camera2D.position, $Room1.position + $Room1.size/2, delta * 2)
	else:
		$Camera2D.position = lerp($Camera2D.position, $Player.position, delta * 2)

func _input(event):
	if not inside_room:
		if event.is_action_pressed("switch_robot"):
			current_robot = (current_robot + 1) % len(robots)
			$Player.set_robot(robots[current_robot])
			consumption = $Player.energy
			energy.text = str(consumption)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inside_room = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inside_room = false
