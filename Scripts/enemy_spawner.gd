extends Node2D

var crab = preload("res://Scenes/crab.tscn")


@onready var spawn_positions = $SpawnPositions

func spawn_crab(count: int):
	var position_array = spawn_positions.get_children()
	var available_positions := position_array.duplicate()
	available_positions.shuffle()
	var random_spawn_position = position_array.pick_random()
	
	var offset = Vector2(
		randf_range(-2, 2),
		randf_range(-2, 2)
	)
	
	count = min(count, available_positions.size())
	
	for i in count:
		CrabData.addCrab(1)
		var pos_node = available_positions[i]
		var crab_instance = crab.instantiate()
		crab_instance.global_position = pos_node.global_position + offset
		crab_instance.z_index = 20
		get_tree().current_scene.add_child(crab_instance)
		print("I spawned a crab at : ", str(crab_instance.global_position))
