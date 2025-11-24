extends Node

@onready var current_scene_id: SceneID = SceneID.MAIN


enum SceneID { MAIN, HOUSE, DEPOSIT,WEAPONSTORAGE,WEAPONSTORE,ENCYCLOPEDIA, NOTHING}
# PackedScene references
var scenes = {
	SceneID.MAIN: preload("res://Scenes/sample_scene_2d.tscn"),
	SceneID.HOUSE: preload("res://Scenes/House.tscn"),
	SceneID.DEPOSIT: preload("res://Scenes/Deposit.tscn"),
	SceneID.WEAPONSTORAGE : load("res://Scenes/weapon_deposit.tscn"),
	SceneID.WEAPONSTORE : load("res://Scenes/Weapon_Store.tscn"),
	SceneID.ENCYCLOPEDIA : load("res://Scenes/Encyclopedia.tscn"),
	SceneID.NOTHING: null
}





func get_scene(scene_id: SceneID) -> PackedScene:
	return scenes.get(scene_id, null)

func set_current_scene(scene_id: SceneID) -> void:
	current_scene_id = scene_id

func get_current_scene() -> SceneID:
	return current_scene_id
