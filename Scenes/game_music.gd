extends Node2D

@onready var music : AudioStreamPlayer2D = $AudioStreamPlayer2D

func ready():
	music.stream_loop = true
	#music.stream.loop = true
	
	#music.play()
	
func _on_audio_stream_player_2d_finished() -> void:
	print("Music is finished")
	#music.play()
