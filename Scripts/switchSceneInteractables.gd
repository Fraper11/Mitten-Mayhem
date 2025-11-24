extends Node

@onready var border : TextureRect = $Borders

@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING


func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered")) 
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))
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
				SceneLoader.load_scene(target_scene)
				if (target_scene == SceneStorage.SceneID.WEAPONSTORAGE):
					GlobalTimer.add_timer(0.5)
					GlobalTimer.timeout.connect(Callable(self,"on_timeout"))
					
					
func on_timeout():
	print("Ho aspettato")
	WeaponDeposit.visible = true
