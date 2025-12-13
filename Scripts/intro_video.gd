extends Control

@onready var video : VideoStreamPlayer = $VideoStreamPlayer
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	GameMusic.stopMusic()
	video.play()
	audio.play()

func _on_video_stream_player_finished() -> void:
	audio.stop()
	SceneLoader.load_scene(SceneStorage.SceneID.LOADING)
