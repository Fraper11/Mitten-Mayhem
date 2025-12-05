extends Control

@onready var label_currency: Label = $Board01/currency
@onready var label_level: Label = $Board01/Level
@onready var label_experience: Label = $Board01/Experience

func _process(delta): 
	pass
	label_level.text = "Lv: %d" % PlayerData.level
	label_currency.text = "Coins: %d" % PlayerData.currency 
	label_experience.text = " Exp: %d / %d" %[PlayerData.experience,PlayerData.exp_to_next_level]
