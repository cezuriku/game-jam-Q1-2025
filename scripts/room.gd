extends Node2D
class_name Room

@export var dust_number = 5

func is_done():
	return dust_number < 1
