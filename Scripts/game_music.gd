extends Node2D

@onready var music : AudioStreamPlayer2D = $game_music
@onready var torture_music : AudioStreamPlayer2D = $torture_room

var playing : bool = true


func  _process(delta: float) -> void:
	if (playing):
		if(SceneLoader.current_scene == SceneStorage.SceneID.TORTURE):
			if (!torture_music.is_playing()):
				music.stop()
				torture_music.play()
		else:
			if (!music.is_playing()):
				torture_music.stop()
				music.play()
		if(SceneLoader.current_scene == SceneStorage.SceneID.WIN):
				stopMusic()
	#			win music play
		#if(SceneLoader.current_scene == SceneStorage.SceneID.INTRO):
				#music.stop()
				#torture_music.stop()

func stopMusic():
	playing = false
	music.stop()
	torture_music.stop()

func playMusic():
	playing = true
