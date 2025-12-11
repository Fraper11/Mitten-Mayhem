extends Node2D

var marker_node : Marker2D = null 

func _ready() -> void:
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))


func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if (!PlayerData.unlocked_pages.has("PAGE_001")):
				PlayerData.unlock_page("PAGE_001")
			die()


func die ():
	PlayerData.add_crab_to_inventory(1)
	CrabData.addCrab(-1)
	if marker_node != null:
		EnemySpawner.free_marker(marker_node)
	queue_free()
