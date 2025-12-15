extends Area2D

@onready var border : TextureRect = $Borders
@onready var computer_icon = preload("res://Audio/computer_click.wav")

@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING

var sound_stream : AudioStreamPlayer2D = AudioStreamPlayer2D.new()


func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered")) 
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))
	sound_stream.stream = computer_icon
	add_child(sound_stream)
	border.visible = false
	
func _on_mouse_entered():
	border.visible =  true
	
func _on_mouse_exited():
	border.visible =  false
	
func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if (target_scene != SceneStorage.SceneID.NOTHING):
				print("Bringing you to another place")
				sound_stream.play()
				SceneLoader.load_scene(target_scene)
