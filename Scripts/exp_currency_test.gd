extends Control

@onready var label_currency: Label = $CurrencyBar/Currency 
@onready var label_level: Label = $LvExpBar/Level
@onready var label_experience: Label = $LvExpBar/Experience

func _process(delta): 
	label_level.text = "Lv: %d" % PlayerData.level
	label_currency.text = "Coins: %d" % PlayerData.currency 
	label_experience.text = " Exp: %d / %d" %[PlayerData.experience,PlayerData.exp_to_next_level]
