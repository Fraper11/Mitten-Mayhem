extends CanvasLayer

func pause():
	self.visible = !self.visible

func _ready() -> void:
	self.visible = false

func _on_resume_pressed() -> void:
	print("PRESSED")
	self.visible = false

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
	#SceneLoader.load_scene(SceneStorage.scenes["HELP"])
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	print("PRESSED")
	self.visible = false
	#SceneLoader.load_scene(SceneStorage.scenes["MAINMENU"])
	pass # Replace with function body.
