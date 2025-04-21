extends CharacterBody2D

@export var player_speed = 500
@export var rotation_speed = 5.0
var robot = 2
@export var energy = 75.3


func _ready() -> void:
	set_robot(2)


func set_robot(number):
	$Sprite2D.texture = load("res://assets/robot" + str(number) + ".png")
	robot = number
	match robot:
		2:
			energy = 75.3
		3:
			energy = 34.7
		4:
			energy = 20.0


func _input(event):
	match robot:
		4:
			if event.is_action_pressed("ui_up"):
				rotation = rotation + PI * 5 / 6


func _process(delta):
	match robot:
		2:
			var direction = Vector2(
				Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
				Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
			)

			velocity = direction * player_speed

			if direction != Vector2.ZERO:
				var target_rotation = direction.angle() - PI / 2
				rotation = lerp_angle(rotation, target_rotation, delta * rotation_speed)

			move_and_slide()
		3:
			var rotation_dir = (
				Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			)
			rotation += rotation_dir * rotation_speed * delta
			if rotation_dir == 0:
				var forward = (
					Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
				)
				velocity = Vector2(forward, 0).rotated(rotation + PI / 2) * player_speed
				move_and_slide()
		4:
			velocity = Vector2(1, 0).rotated(rotation + PI / 2) * player_speed
			move_and_slide()
