extends Node
var  mouseConfine: bool = true

func _ready() -> void:
	ToggleMouseConfine()

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("mouse_confine")):
		mouseConfine = !mouseConfine
		ToggleMouseConfine()

func ToggleMouseConfine() -> void :#PRESS ESC TO FREE/CAPTURE THE CURSOR
	if (mouseConfine):
		Input.set_mouse_mode (Input.MOUSE_MODE_CONFINED)
		print("Mouse Confined")
	else :
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		print("Mouse Freed")
