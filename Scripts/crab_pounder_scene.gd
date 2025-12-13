extends RigidBody2D

@onready var texture :Sprite2D = $Sprite2D
@onready var audio_stream : AudioStreamPlayer2D = $AudioStreamPlayer2D

var audio 
var damage : int 

#var dragging = false
#var joint: PinJoint2D
#var anchor: Node2D
#
func _ready():
	texture.texture = WeaponDeposit.weapons_data[PlayerData.weapon_equipped]["texture"]
	damage = WeaponDeposit.weapons_data[PlayerData.weapon_equipped]["damage"]
	audio = WeaponDeposit.weapons_data[PlayerData.weapon_equipped]["audio"]
	audio_stream.stream = audio
	#input_pickable = true  # important for click detection
#
#func _input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.pressed:
				#start_drag()
			#else:
				#stop_drag()
#
#func start_drag():
	#if dragging:
		#return
#
	#dragging = true
#
	## Create an invisible anchor that follows the mouse
	#anchor = Node2D.new()
	#get_tree().current_scene.add_child(anchor)
	#anchor.global_position = get_global_mouse_position()
#
	## Create joint
	#joint = PinJoint2D.new()
	#joint.node_a = anchor.get_path()
	#joint.node_b = self.get_path()
	#get_tree().current_scene.add_child(joint)
#
#func stop_drag():
	#if not dragging:
		#return
#
		#dragging = false
		#joint.queue_free()
		#anchor.queue_free()
#
#func _physics_process(delta):
	#if dragging and anchor:
		#anchor.global_position = get_global_mouse_position()
		
		


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("CRAB"):
		body.takeDamage(damage) 
		audio_stream.play()
		await(audio_stream.finished)
		self.queue_free()
