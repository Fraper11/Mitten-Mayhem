extends Node2D

var crab = preload("res://Scenes/crab_torture.tscn")
var target_scene = SceneStorage.SceneID.DEPOSIT


@onready var spawn_area :Area2D =$Torture_Zone/Spawn_area
@onready var weapon: PackedScene = preload("res://Scenes/WeaponsScenes/weapon_scene.tscn")
@onready var crab_inventory : Label =$PanelContainer/MarginContainer/HBoxContainer/Crab_Inventory

func _ready() -> void:
	crab_inventory.text = (" %d" %PlayerData.crab_inventory_counter)


func _on_spawn_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			spawn_weapon()
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			var free_space = get_tree().get_nodes_in_group("WEAPONS")
			for weapon in free_space:
				weapon.queue_free()

func spawn_weapon ():
	
	var weapon_present = get_tree().get_nodes_in_group("WEAPONS")
	if ((weapon_present.size() > 0) || (PlayerData.weapon_equipped == "")):
		return
		
	
	var weapon_instance = weapon.instantiate()
	weapon_instance.global_position = get_global_mouse_position()
	get_tree().current_scene.add_child(weapon_instance)
	
		
func _on_crab_button_pressed() -> void:
	if(PlayerData.crab_inventory_counter >0):
		var crab_instance = crab.instantiate()
		crab_instance.global_position = get_viewport_rect().size/2 + Vector2(0,-200)
		crab_instance.z_index = 20
		get_tree().current_scene.add_child(crab_instance)
		PlayerData.add_crab_to_inventory(-1)
		crab_inventory.text = (" %d" %PlayerData.crab_inventory_counter)
		

func _on_close_torture_room_button_pressed() -> void:
	if target_scene != SceneStorage.SceneID.NOTHING:
		print("Bringing you to another place")
		SceneLoader.load_scene(target_scene)
		GlobalTimer.add_timer(0.5)
		GlobalTimer.timeout.connect(Callable(self,"on_timeout"))
