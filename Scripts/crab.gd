extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sound = $grab

var sound_stream : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var marker_node : Marker2D = null 
enum states {IDLER,GOINGRIGHT,GOINGLEFT,IDLEL,DIE}
var current_state = states.IDLER

func _ready() -> void:
	if(self != null && animation_player != null):
		connect("input_event", Callable(self, "_on_mouse_clicked_left"))
		animation_player.speed_scale = 2.0
	
func _process(delta: float) -> void:
	if(self != null && animation_player != null):
		match current_state:
			states.IDLER:
				
				animation_player.play("Idle")
				await animation_player.animation_finished
				current_state = states.GOINGRIGHT
				print(current_state)
			
			states.GOINGRIGHT:
				animation_player.play("crab_moving")
				await animation_player.animation_finished
				current_state = states.IDLEL
			
			states.IDLEL:
				animation_player.play("Idle")
				await animation_player.animation_finished
				current_state = states.GOINGLEFT
		
			states.GOINGLEFT:
				animation_player.play_backwards("crab_moving")
				await animation_player.animation_finished
				current_state = states.IDLER
				
			states.DIE:
				die()
			
func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if (!PlayerData.unlocked_pages.has("PAGE_001")):
				PlayerData.unlock_page("PAGE_001")
			current_state = states.DIE


func die ():
	sound.play()
	await (sound.finished)
	PlayerData.add_crab_to_inventory(1)
	CrabData.addCrab(-1)
	if marker_node != null:
		EnemySpawner.free_marker(marker_node)
	queue_free()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if (!PlayerData.unlocked_pages.has("PAGE_001")):
				PlayerData.unlock_page("PAGE_001")
			die()
