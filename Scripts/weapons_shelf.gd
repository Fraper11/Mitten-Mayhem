extends Node2D

@export var weapon_name : String 

func _ready() -> void:
	self.visible = false
	connect("input_event", Callable(self, "_on_mouse_clicked_left"))

func _process(delta: float) -> void:
	if WeaponDeposit.weapons_data.has(weapon_name):
		if WeaponDeposit.weapons_data[weapon_name].has("purchased"):
			if WeaponDeposit.weapons_data[weapon_name]["purchased"]:
				self.visible = true


func _on_mouse_clicked_left(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			PlayerData.equip_weapon(weapon_name)
			print("YOU EQUIPPED:" + PlayerData.weapon_equipped)
