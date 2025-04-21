extends Control

@onready var simpleboards = get_node("SimpleBoardsApi")

var min_high_score = 0
var board_id = "26526100-6a98-4334-f120-08dd7d05b551"


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
	await simpleboards.get_entries(board_id)


func _on_entries_got(entries):
	for children in $Panel/VBoxContainer/ScoreContainer.get_children():
		children.queue_free()
	for entry in entries:
		if int(entry["score"]) > min_high_score:
			min_high_score = entry["score"]
		var new_label = $Panel/VBoxContainer/ExampleLabel.duplicate()
		new_label.visible = true
		new_label.text = entry["playerDisplayName"] + " " + entry["score"]
		$Panel/VBoxContainer/ScoreContainer.add_child(new_label)
	if len(entries) < 15 or Global.current_score < min_high_score:
		await simpleboards.send_score_without_id(board_id, "Cedric", str(Global.current_score), "{}")
	#	await simpleboards.get_entries(board_id)
