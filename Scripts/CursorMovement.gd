extends Node


func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("mouse_confine")):
		PauseScreen.pause()
