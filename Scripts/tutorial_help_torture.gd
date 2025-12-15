extends Node2D


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		SceneLoader.load_scene(SceneStorage.SceneID.TUTORIALTORTURE)
