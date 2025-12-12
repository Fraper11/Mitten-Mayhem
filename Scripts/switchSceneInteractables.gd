extends Node

@onready var border : TextureRect = $Borders
@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING
@export var no_animation : bool = false

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered")) 
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))
	border.visible = false
	
func _on_mouse_entered():
	if (no_animation == true): return
	border.visible =  true
	
func _on_mouse_exited():
	if (no_animation == true): return
	border.visible =  false
	
func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if (target_scene != SceneStorage.SceneID.NOTHING):
				print("Bringing you to another place")
				SceneLoader.load_scene(target_scene)
				ExpCurrencyTest.useDoor()
				if (target_scene == SceneStorage.SceneID.WEAPONSTORAGE):
					GlobalTimer.add_timer(0.5)
					GlobalTimer.timeout.connect(Callable(self,"on_timeout"))
					GlobalTimer.add_timer(0.5)
					GlobalTimer.timeout.connect(Callable(self,"on_timeout_map"))
					

func on_timeout():
	print("Ho aspettato")
	WeaponDeposit.visible = true
