extends Node

var mouse_position : Vector2

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("mouse_confine")):
		PauseScreen.pause()

func stop_mouse():
	mouse_position = get_viewport().get_mouse_position()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func activate_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_viewport().warp_mouse(mouse_position)
