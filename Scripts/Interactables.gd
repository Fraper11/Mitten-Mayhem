extends Area2D

@onready var border = $Border
@onready var label = $Label

#@onready var animation = $AnimationPlayer  FOR ANIMATIONS

@export var unlock_at_level :int 
@export var exp_to_add : int = 0
@export var currency_to_add : int = 0
@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING

var normal_size: Vector2
var hover_size: Vector2
var originalColor = Color.WHITE
var hoverColor = Color.NAVAJO_WHITE

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))
	normal_size = border.size
	hover_size = border.size + Vector2(20, 20)
	border.position = -border.size / 2


func _on_mouse_entered():
	#animation.play("mouse_entered") FOR ANIMATION
	print("Mouse Entered")
	border.size = hover_size
	border.position = -border.size / 2 
	label.modulate = hoverColor


func _on_mouse_exited():
	#animation.play("mouse_exited") FOR ANIMATION
	print("Mouse Exited")
	border.size = normal_size
	border.position = -border.size / 2 
	label.modulate = originalColor
	
func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if (PlayerData.level < unlock_at_level):
				print("YOU NEED TO LEVEL UP","CURRENT LEVEL: ",PlayerData.level, "LEVEL NEEDED: ",unlock_at_level)
				return
			print("You clicked, Something happens NOW!")
			PlayerData.add_exp(exp_to_add)
			PlayerData.add_currency(currency_to_add)
			if (target_scene != SceneStorage.SceneID.NOTHING):
				print("I'm Loading a New Scene")
				SceneLoader.load_scene(target_scene)
			
