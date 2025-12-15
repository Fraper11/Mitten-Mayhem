extends Node2D

var previous_scene : bool = false


func _on_button_pressed() -> void:
	if(PlayerData.from_menu):
		SceneLoader.load_scene(SceneStorage.SceneID.MAINMENU)
		return

	SceneLoader.load_previous_scene()
