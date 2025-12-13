extends Node2D

@onready var music : AudioStreamPlayer2D = $game_music
@onready var torture_music : AudioStreamPlayer2D = $torture_room


func  _process(delta: float) -> void:
	if(SceneLoader.current_scene == SceneStorage.SceneID.TORTURE):
		if (!torture_music.is_playing()):
			music.stop()
			torture_music.play()
	else:
		if (!music.is_playing()):
			torture_music.stop()
			music.play()
	if(SceneLoader.current_scene == SceneStorage.SceneID.WIN):
			music.stop()
			torture_music.stop()
#			win music play
