extends Node


@onready var sandal_button = $PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/Sandal
@onready var crabpounder_button = $PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/CrabPounder
@onready var gun_button = $PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/Gun
@onready var hammer_button = $PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/Hammer


@onready var icon_panel = $PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/Upper/Icon
@onready var description_label = $PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/Description/DescriptionLabel

@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING


var weapons_data = {}

func _ready() -> void:
	self.visible = false
	PlayerData.weapon_unlocked.connect(Callable(self, "_on_weapon_unlocked"))
	
	weapons_data = {
		"CRABPOUNDER": {
			"button": crabpounder_button,
			"texture": preload("res://Assets/weapon00.png"),
			"description": "",
			"price": 800,
			"purchased": false
		},
		"GUN": {
			"button": gun_button,
			"texture": preload("res://Assets/salmon.PNG"),
			"description": "Yeah it's not really a gun isn't it?",
			"price": 600,
			"purchased": false
		},
		"SANDAL": {
			"button": sandal_button,
			"texture": preload("res://Assets/weapon00.png"),
			"description": "",
			"price": 1000,
			"purchased": false
		},
		"HAMMER": {
			"button": hammer_button,
			"texture": preload("res://Assets/weapon00.png"),
			"description": "This is a hammer, SMASH!",
			"price": 500,
			"purchased": false
		}
	}

	for weapon_name in weapons_data.keys():
		var btn = weapons_data[weapon_name]["button"]
		btn.visible = false
		btn.pressed.connect(func() -> void:
			show_weapon(weapon_name)
		)
	

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
		GlobalTimer.timeout.connect(Callable(self,"on_timeout"))

func show_weapon(weapon_name: String) -> void:
	var weapon = weapons_data.get(weapon_name)
	if not weapon:
		return
	var stylebox = StyleBoxTexture.new()
	stylebox.texture = weapon["texture"]
	icon_panel.add_theme_stylebox_override("panel", stylebox)
	description_label.text = weapon["description"]

func on_timeout() -> void:
	self.visible = false
