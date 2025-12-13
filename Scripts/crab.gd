extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sound = $grab

var sound_stream : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var marker_node : Marker2D = null 
enum states {IDLER,GOINGRIGHT,GOINGLEFT,IDLEL,COLLECTED,DIE}
var current_state = states.IDLER

func _ready() -> void:
	if(self != null && animation_player != null):
		run_states()
		animation_player.speed_scale = 2.0
	
func run_states():
	if(self != null && animation_player != null):
		match current_state:
			states.IDLER:
				
				animation_player.play("Idle")
				await animation_player.animation_finished
				current_state = states.GOINGRIGHT
				run_states()
				print(current_state)
			
			states.GOINGRIGHT:
				animation_player.play("crab_moving")
				await animation_player.animation_finished
				current_state = states.IDLEL
				run_states()
				
			states.IDLEL:
				animation_player.play("Idle")
				await animation_player.animation_finished
				current_state = states.GOINGLEFT
				run_states()
				
			
			states.GOINGLEFT:
				animation_player.play_backwards("crab_moving")
				await animation_player.animation_finished
				current_state = states.IDLER
				run_states()
				
			states.COLLECTED:
				CursorMovement.stop_mouse()
				current_state = states.DIE
				run_states()
			
			states.DIE:
				die()
			


func die ():
	sound.play()
	await (sound.finished)
	PlayerData.add_crab_to_inventory(1)
	CrabData.addCrab(-1)
	if marker_node != null:
		EnemySpawner.free_marker(marker_node)
	CursorMovement.activate_mouse()
	queue_free()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		current_state = states.COLLECTED
		run_states()
		if (!PlayerData.unlocked_pages.has("PAGE_001")):
			PlayerData.unlock_page("PAGE_001")
