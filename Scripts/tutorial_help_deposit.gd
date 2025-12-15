extends Node2D


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("left_click")):
		if SceneLoader.get_current_scene() == SceneStorage.SceneID.DEPOSIT:
			SceneLoader.load_scene(SceneStorage.SceneID.TUTORIALDEPOSIT)
		if SceneLoader.get_current_scene() == SceneStorage.SceneID.TORTURE:
			SceneLoader.load_scene(SceneStorage.SceneID.TUTORIALTORTURE)
