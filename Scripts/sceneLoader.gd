extends Node

var previous_scene = SceneStorage.SceneID.MAINMENU
var current_scene = SceneStorage.SceneID.MAP

signal finished

func load_scene(scene_id: SceneStorage.SceneID):
	previous_scene = SceneStorage.get_current_scene()
	SceneStorage.set_current_scene(scene_id)
	
	var scene_to_load = SceneStorage.get_scene(scene_id)
	if scene_to_load == null:
		push_error("Scene not found for ID: " + str(scene_id))
		return
	
	
	# Fade transition
	await FadeLayer.fade_out()
	get_tree().change_scene_to_packed(scene_to_load)
	await get_tree().process_frame
	if (scene_id != SceneStorage.SceneID.MAP):
		ExpCurrencyTest.toggle_board(false)
	else: ExpCurrencyTest.toggle_board(true)
	await FadeLayer.fade_in()
	current_scene = scene_id
	emit_signal("finished")
	
# Go back to previous scene
func load_previous_scene():
	load_scene(previous_scene)
	
func get_current_scene():
	return current_scene
	
func get_previous_scene():
	return previous_scene
