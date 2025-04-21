extends Node2D

var robots = [2, 3, 4]
var current_robot = 0

var consumption = 0
var total_consumption = 0

var inside_room = false
@export var rooms_to_clean = 1

@onready var energy = get_node("Camera2D/Control/VBoxContainer/HBoxContainer2/Energy")
@onready var current_energy = get_node("Camera2D/Control/VBoxContainer/HBoxContainer/CurrentEnergy")


func _ready():
	consumption = $Player.energy
	energy.text = str(consumption)
	$"/root/GlobalSignal".add_listener("inside_room", _update_inside_room)
	$"/root/GlobalSignal".add_listener("room_cleaned", _update_room_ro_clean)


func _process(delta):
	if inside_room:
		total_consumption += consumption * delta
		current_energy.text = str(round(total_consumption * 10) / 10)
		$Camera2D.position = lerp($Camera2D.position, $Room1.position, delta * 2)
	else:
		$Camera2D.position = lerp($Camera2D.position, $Player.position, delta * 2)


func _input(event):
	if not inside_room:
		if event.is_action_pressed("switch_robot"):
			set_robot((current_robot + 1) % len(robots))
		if event is InputEventKey and event.pressed:
			match event.keycode:
				KEY_1: set_robot(0)
				KEY_2: set_robot(1)
				KEY_3: set_robot(2)

func set_robot(number):
	current_robot = number
	$Player.set_robot(robots[current_robot])
	consumption = $Player.energy
	energy.text = str(consumption)
	
func _update_inside_room(value):
	inside_room = value

	if rooms_to_clean == 0:
		print("Well done every room has been cleaned, score: " + str(total_consumption))
		Global.current_score = int(total_consumption)


func _update_room_ro_clean():
	rooms_to_clean -= 1
