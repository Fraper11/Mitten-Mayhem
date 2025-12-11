extends Area2D

@export var unlock_at_level :int 
@export var page_to_unlock : String

func _ready():
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))
	
func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if (PlayerData.level < unlock_at_level):
				print("YOU NEED TO LEVEL UP","CURRENT LEVEL: ",PlayerData.level, "LEVEL NEEDED: ",unlock_at_level)
				return
			print("You clicked, Something happens NOW!")
			if page_to_unlock != "":
				PlayerData.unlock_page(page_to_unlock)
