extends Node


@onready var crab_pounder_button = %CrabPounder
@onready var chunky_splatter_button = %ChunkySplatter
@onready var mom_Sandal_button = %MomSandal
@onready var frozen_slapper_button = %FrozenSlapper

@onready var icon_panel = $PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/Upper/Icon
@onready var description_label = $PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/Description/DescriptionLabel

@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING


var weapons_data = {}


func _ready() -> void:
	PlayerData.weapon_unlocked.connect(Callable(self, "_on_weapon_unlocked"))
	weapons_data = {
		"CRABPOUNDER": {
			"button": crab_pounder_button,
			"texture": preload("res://Assets/Weapons/crabPounder.png"),
			"description": "Just a regular old fashioned Crab Pounder,SMASH!",
			"price": 200,
			"purchased": false,
			"damage" : 1,
			"audio": preload("res://Audio/CrabPounder.wav")
		},
		"CHUNKYSPLATTER": {
			"button": chunky_splatter_button,
			"texture": preload("res://Assets/Weapons/chunkySplatter.png"),
			"description": "A solution to all of your problems",
			"price": 400,
			"purchased": false,
			"damage": 2,
			"audio": preload("res://Audio/BigRock.wav")
		},
		"MOMSANDAL": {
			"button": mom_Sandal_button,
			"texture": preload("res://Assets/Weapons/momSandal.png"),
			"description": "Did you stole from your mother closet? She is gonna kill you when she is gonna find out",
			"price": 600,
			"purchased": false,
			"damage": 4,
			"audio": preload("res://Audio/MomSandal.wav")
		},
		"FROZENSLAPPER": {
			"button": frozen_slapper_button,
			"texture": preload("res://Assets/Weapons/frozenSlapper.PNG"),
			"description": "Payback must be served, Frost!",
			"price": 800,
			"purchased": false,
			"damage": 999,
			"audio": preload("res://Audio/frozenSlapper.wav")
		}
	}
	for weapon_name in weapons_data.keys():
		var btn = weapons_data[weapon_name]["button"]
		btn.visible = false
		btn.pressed.connect(func() -> void:
			show_weapon(weapon_name)
		)
	
func _process(delta: float) -> void:
	if (get_tree().current_scene != null && get_tree().current_scene.scene_file_path =="res://Scenes/weapon_deposit.tscn"):
		self.visible = true
	else : self.visible = false

func _on_weapon_unlocked(weapon_name: String) -> void:
	var weapon = weapons_data.get(weapon_name)
	if weapon["purchased"] == true:
		print("WEAPON IS : ",weapon)
		var btn = weapon["button"]
		btn.visible = true

func _on_close_weapon_storage_button_pressed() -> void:
	if target_scene != SceneStorage.SceneID.NOTHING:
		print("Bringing you to another place")
		SceneLoader.load_scene(target_scene)
		GlobalTimer.add_timer(0.5)
		
func show_weapon(weapon_name: String) -> void:
	var weapon = weapons_data.get(weapon_name)
	if not weapon:
		return
	var stylebox = StyleBoxTexture.new()
	stylebox.texture = weapon["texture"]
	icon_panel.add_theme_stylebox_override("panel", stylebox)
	description_label.text = weapon["description"]
