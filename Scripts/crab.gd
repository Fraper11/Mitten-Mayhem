extends Node2D


func _ready() -> void:
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))


func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			die()


func die ():
	PlayerData.add_crab_to_inventory(1)
	PlayerData.add_exp(100)
	CrabData.addCrab(-1)
	queue_free()
