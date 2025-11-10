extends Area2D

@onready var border = $Border
@onready var label = $LightBlue/Label
#@onready var animation = $AnimationPlayer  FOR ANIMATIONS

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
			print("You clicked, Something happens NOW!")
