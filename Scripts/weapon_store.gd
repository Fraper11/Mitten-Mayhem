extends Control

signal weapon_unlocked(weapon_name: String)


@onready var hammer_cost = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Lower/Cost
@onready var salmon_cost = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/Lower/Cost

@onready var hammer_buy = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Lower/Buy
@onready var gun_buy = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/Lower/Buy


@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING

func _ready() -> void:
	hammer_cost.text = str(WeaponDeposit.weapons_data["HAMMER"]["price"])
	print ("COST " ,hammer_cost)
	salmon_cost.text = str(WeaponDeposit.weapons_data["GUN"]["price"])
	hammer_buy.pressed.connect(_buy_weapon.bind("HAMMER"))
	gun_buy.pressed.connect(_buy_weapon.bind("GUN"))
	#sandal_button.pressed.connect(_buy_weapon.bind("SANDAL"))
	self.weapon_unlocked.connect(WeaponDeposit._on_weapon_unlocked)

	
	
	
func _buy_weapon(weapon_key: String) -> void:
	if ((PlayerData.currency >= WeaponDeposit.weapons_data[weapon_key]["price"]) && (WeaponDeposit.weapons_data[weapon_key]["purchased"]==false)):
		PlayerData.add_currency(-WeaponDeposit.weapons_data[weapon_key]["price"])
		WeaponDeposit.weapons_data[weapon_key]["purchased"] = true
		emit_signal("weapon_unlocked", weapon_key)
		print ("WEAPON PURCHASED")
	else :
		print("Weapon already purchased probably , if you can count")

func _on_close_weapon_store_button_pressed() -> void:
	if target_scene != SceneStorage.SceneID.NOTHING:
		print("Bringing you to another place")
		SceneLoader.load_scene(target_scene)
		GlobalTimer.add_timer(0.5)
		GlobalTimer.timeout.connect(Callable(self,"on_timeout"))
