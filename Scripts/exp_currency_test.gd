extends Control

@onready var label_currency: Label = $Currency
@onready var label_level: Label = $Level
@onready var label_experience: Label = $Experience
func _process(delta): 
	label_level.text = "Level: %d" % PlayerData.level
	label_currency.text = "Currency: %d" % PlayerData.currency 
	label_experience.text = "Experience Points : %d / %d" %[PlayerData.experience,PlayerData.exp_to_next_level]
