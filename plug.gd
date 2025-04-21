extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug(
		"godot-extended-libraries/godot-debug-menu",
		{"commit": "0e5f15217285c76170039c9cefcf79c8ab0ec6b3", "renovate-branch": "master"}
	)
	plug(
		"KoBeWi/Godot-Universal-Fade",
		{"commit": "f091514bba652880f81c5bc8809e0ee4498988ea", "renovate-branch": "master"}
	)
	plug(
		"isetr/simpleboards_godot",
		{"commit": "1c1c84fe349ca279b4d2e7cdbe2440de99b37bd4", "renovate-branch": "main"}
	)

	# Patched version
	plug(
		"florianvazelle/EasyMenus",
		{"commit": "018ab39001f862abbd6ca424258a9a548589d61c", "renovate-branch": "master"}
	)
	plug(
		"florianvazelle/Log",
		{"commit": "f23215571cb398c16272227130885d867d12cb4b", "renovate-branch": "main"}
	)
