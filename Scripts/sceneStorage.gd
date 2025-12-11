extends Node

@onready var current_scene_id: SceneID = SceneID.MAP


enum SceneID {MAIN,HOUSE, DEPOSIT, WEAPONSTORAGE, WEAPONSTORE, ENCYCLOPEDIA, MAP,TORTURE,WIN,GAMEOVER, NOTHING}
# PackedScene references
var scenes = {
	SceneID.MAIN : preload("res://Scenes/MainLevel.tscn"),
	SceneID.HOUSE: preload("res://Scenes/House.tscn"),
	SceneID.DEPOSIT: preload("res://Scenes/Deposit.tscn"),
	SceneID.WEAPONSTORAGE : load("res://Scenes/weapon_deposit.tscn"),
	SceneID.WEAPONSTORE : load("res://Scenes/Weapon_Store.tscn"),
	SceneID.ENCYCLOPEDIA : load("res://Scenes/Encyclopedia.tscn"),
	SceneID.MAP : load("res://Scenes/Map_test.tscn"),
	SceneID.TORTURE : load("res://Scenes/torture_room.tscn"),
	SceneID.WIN: preload("res://Scenes/win.tscn"),
	SceneID.GAMEOVER: preload("res://Scenes/sample_scene_2d.tscn"),
	SceneID.NOTHING: null
}





func get_scene(scene_id: SceneID) -> PackedScene:
	return scenes.get(scene_id, null)

func set_current_scene(scene_id: SceneID) -> void:
	current_scene_id = scene_id

func get_current_scene() -> SceneID:
	return current_scene_id
