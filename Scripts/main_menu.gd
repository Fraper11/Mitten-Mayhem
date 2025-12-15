extends CanvasLayer


func pause():
	self.visible = !self.visible

func _ready() -> void:
	ExpCurrencyTest.toggle_board(false)
	GameMusic.stopMusic()

func _on_play_game_pressed() -> void:
	PlayerData.from_menu = false
	SceneLoader.load_scene(SceneStorage.SceneID.INTRO)

func _on_encyclopedia_pressed() -> void:
	if(SceneLoader.get_current_scene()!= SceneStorage.SceneID.ENCYCLOPEDIA):
		print("PRESSED")
		SceneLoader.load_scene(SceneStorage.SceneID.ENCYCLOPEDIA)
	else:
		print("You are already there")
		
	self.visible = false


func _on_help_pressed() -> void:
	print("PRESSED")
	self.visible = false
	SceneLoader.load_scene(SceneStorage.SceneID.TUTORIAL)
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	print("PRESSED")
	self.visible = false
	if Engine.is_editor_hint():
		get_tree().paused = true  
	else:
		get_tree().quit()
