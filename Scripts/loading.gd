extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("loading")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SceneLoader.load_scene(SceneStorage.SceneID.MAP)
	GameMusic.playMusic()
	
