extends Node2D

func _ready() -> void:
	$Tutorial01/Button.pressed.connect(SceneLoader.load_previous_scene)
