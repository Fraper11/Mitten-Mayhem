extends Node

var previous_scene_id = SceneStorage.SceneID.MAP
var current_scene = SceneStorage.SceneID.MAP

func load_scene(scene_id: SceneStorage.SceneID):
	previous_scene_id = SceneStorage.get_current_scene()
	SceneStorage.set_current_scene(scene_id)
	
	var scene_to_load = SceneStorage.get_scene(scene_id)
	if scene_to_load == null:
		push_error("Scene not found for ID: " + str(scene_id))
		return
	
	# Fade transition
	await FadeLayer.fade_out()
	get_tree().change_scene_to_packed(scene_to_load)
	await get_tree().process_frame
	await FadeLayer.fade_in()
	current_scene = scene_id

# Go back to previous scene
func load_previous_scene():
	load_scene(previous_scene_id)
	
func get_current_scene():
	return current_scene
