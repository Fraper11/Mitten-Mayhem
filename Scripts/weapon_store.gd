extends Control

signal weapon_unlocked(weapon_name: String)


@onready var crab_pounder_cost = %CrabPounderCost
@onready var chunky_splatter_cost = %ChunkySplatterCost
@onready var mom_sandal_cost = %MomSandalCost
@onready var frozen_slapper_cost = %FrozenSlapperCost

@onready var crab_pounder_buy = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Lower/Buy
@onready var chunky_splatter_buy = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/Lower/Buy
@onready var mom_sandal_buy = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer3/VBoxContainer/Lower/Buy
@onready var frozen_slapper_buy = $PanelContainer/VBoxContainer/HBoxContainer/MarginContainer4/VBoxContainer/Lower/Buy

@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING

func _ready() -> void:
	crab_pounder_cost.text = str(WeaponDeposit.weapons_data["CRABPOUNDER"]["price"])
	chunky_splatter_cost.text = str(WeaponDeposit.weapons_data["CHUNKYSPLATTER"]["price"])
	mom_sandal_cost.text = str(WeaponDeposit.weapons_data["MOMSANDAL"]["price"])
	frozen_slapper_cost.text = str(WeaponDeposit.weapons_data["FROZENSLAPPER"]["price"])
	
	crab_pounder_buy.pressed.connect(_buy_weapon.bind("CRABPOUNDER"))
	chunky_splatter_buy.pressed.connect(_buy_weapon.bind("CHUNKYSPLATTER"))
	mom_sandal_buy.pressed.connect(_buy_weapon.bind("MOMSANDAL"))
	frozen_slapper_buy.pressed.connect(_buy_weapon.bind("FROZENSLAPPER"))
	
	#Method to Database connection
	self.weapon_unlocked.connect(WeaponDeposit._on_weapon_unlocked)

	
	
	
func _buy_weapon(weapon_key: String) -> void:
	if ((PlayerData.currency >= WeaponDeposit.weapons_data[weapon_key]["price"]) && (WeaponDeposit.weapons_data[weapon_key]["purchased"]==false)):
		PlayerData.spend_currency(WeaponDeposit.weapons_data[weapon_key]["price"])
		WeaponDeposit.weapons_data[weapon_key]["purchased"] = true
		emit_signal("weapon_unlocked", weapon_key)
		print ("WEAPON PURCHASED")
		
	else : #Can be modified in future to add not enough money/ already purchased logic
		print("Weapon already purchased probably , if you can count")

func _on_close_weapon_store_button_pressed() -> void:
	if target_scene != SceneStorage.SceneID.NOTHING:
		print("Bringing you to another place")
		SceneLoader.load_scene(target_scene)
		GlobalTimer.add_timer(0.5,Callable())
		
