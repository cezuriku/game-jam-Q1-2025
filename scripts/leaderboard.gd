extends Control

@onready var simpleboards = get_node("SimpleBoardsApi")


func _ready():
	# Set the API key
	simpleboards.set_api_key("48ef3ed3-c301-4c9e-92e4-058546fadc80")

	# Connect signals
	simpleboards.entries_got.connect(_on_entries_got)
	# simpleboards.entry_sent.connect(_on_entry_sent)

	# Send a score
	# await simpleboards.send_score_without_id("26526100-6a98-4334-f120-08dd7d05b551",
	# "Cedric", "511520200", "{}")

	# Get leaderboard entries
	await simpleboards.get_entries("26526100-6a98-4334-f120-08dd7d05b551")


func _on_entries_got(entries):
	for children in $Panel/VBoxContainer/ScoreContainer.get_children():
		children.queue_free()
	for entry in entries:
		var new_label = $Panel/VBoxContainer/ExampleLabel.duplicate()
		new_label.visible = true
		new_label.text = entry["playerDisplayName"] + " " + entry["score"]
		$Panel/VBoxContainer/ScoreContainer.add_child(new_label)


func _on_entry_sent(_entry):
	# print(entry)
	pass
