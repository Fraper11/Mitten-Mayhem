extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sound = $grab

@onready var ray_rw = $RayRightWater
@onready var ray_lw = $RayLeftWater
@onready var ray_rl = $RayRightLand
@onready var ray_ll = $RayLeftLand

const h_speed = 30
var h_direction = 1
const v_speed = 20
var v_direction = 1

var nums = [-1,1]
var h_dir_timer := Timer.new()
var v_dir_timer := Timer.new()

var sound_stream : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var marker_node : Marker2D = null 
enum states {IDLE,COLLECTED,DIE}
var current_state = states.IDLE

var on_land = false

func _ready() -> void:
	add_child(h_dir_timer)
	h_dir_timer.timeout.connect(_on_h_timer_timeout)
	h_dir_timer.one_shot = false
	h_dir_timer.start(randi_range(2,10))
	
	add_child(v_dir_timer)
	v_dir_timer.timeout.connect(_on_v_timer_timeout)
	h_dir_timer.one_shot = false
	v_dir_timer.wait_time = 0.25
	v_dir_timer.start()
	
	if(self != null && animation_player != null):
		run_states()
		animation_player.speed_scale = 2.0
	animation_player.play("Idle")


func _on_h_timer_timeout() -> void:
	h_direction = nums[randi() % nums.size()] #Random horizontal direction


func _on_v_timer_timeout() -> void:
	v_direction = -v_direction


func _process(delta):
	# Collisions with land and water
	if ray_rl.is_colliding() or ray_rw.is_colliding():
		h_direction = -1
		
	elif ray_ll.is_colliding() or ray_lw.is_colliding():
		h_direction = 1
	
	# Movement
	position.x += h_direction * h_speed * delta
	position.y += v_direction * v_speed * delta


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


func run_states():
	if(self != null && animation_player != null):
		match current_state:
			states.COLLECTED:
				CursorMovement.stop_mouse()
				current_state = states.DIE
				run_states()
			
			states.DIE:
				die()
