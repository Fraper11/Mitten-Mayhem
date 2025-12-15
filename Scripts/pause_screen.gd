extends CanvasLayer


func pause():
	self.visible = true
	GameMusic.stopMusic()

func _ready() -> void:
	self.visible = false

func _on_resume_pressed() -> void:
	print("PRESSED")
	self.visible = false
	GameMusic.playMusic()

func _on_encyclopedia_pressed() -> void:
	if(SceneLoader.get_current_scene()!= SceneStorage.SceneID.ENCYCLOPEDIA):
		print("PRESSED")
		SceneLoader.load_scene(SceneStorage.SceneID.ENCYCLOPEDIA)
	else:
		print("You are already there")
		
	self.visible = false
	GameMusic.playMusic()


func _on_help_pressed() -> void:
	print("PRESSED")
	self.visible = false
	GameMusic.playMusic()
	SceneLoader.load_scene(SceneStorage.SceneID.TUTORIAL)


func _on_exit_pressed() -> void:
	print("PRESSED")
	self.visible = false
	SceneLoader.load_scene(SceneStorage.SceneID.MAINMENU)
	
