extends Button
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/Map_test.tscn")

func _ready():
	pressed.connect(_on_restart_pressed)
