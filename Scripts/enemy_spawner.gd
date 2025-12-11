extends Node2D

var crab = preload("res://Scenes/crab.tscn")
var crab_positions = []

@onready var spawn_positions = $SpawnPositions

func _ready():
	
	for marker in spawn_positions.get_children():
		crab_positions.append({
			"marker": marker,
			"occupied": false
		})

func spawn_crab(count: int):

	var free_positions = crab_positions.filter(
		func(p):
			return not p["occupied"]
	)
	
	if free_positions.size() == 0:
		print("No free positions!")
		return

	free_positions.shuffle()
	count = min(count, free_positions.size())
	
	for i in range(count):
		var pos_entry = free_positions[i]
		var marker = pos_entry["marker"]
		var crab_instance = crab.instantiate()
		crab_instance.global_position = marker.global_position 
		crab_instance.z_index = 20
		crab_instance.marker_node = marker
		get_tree().current_scene.add_child(crab_instance)
		
		pos_entry["occupied"] = true
		CrabData.addCrab(1)
		print("I spawned a crab at:", crab_instance.global_position)

func free_marker(marker_node: Marker2D):
	for pos_entry in crab_positions:
		if pos_entry["marker"] == marker_node:
			pos_entry["occupied"] = false
			break
