extends Node

var pages:= {}

func _ready() -> void:
	var file = FileAccess.open("res://EncyclopediaData/encyclopedia.json", FileAccess.READ)
	var text = file.get_as_text()
	pages = JSON.parse_string(text)
	
	if pages == null:
		push_error("Failed to parse encyclopedia.json")
