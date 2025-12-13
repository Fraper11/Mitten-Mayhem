extends Control

@onready var label_currency: Label =$Board/currency 
@onready var label_level: Label = $Board/Level
@onready var label_experience: Label = $Board/Experience




var in_use : bool = false



func _process(delta): 
	label_level.text = "%d" % PlayerData.level
	label_currency.text = "%d" % PlayerData.currency 
	label_experience.text = "%d / %d" %[PlayerData.experience,PlayerData.exp_to_next_level]
	



	
func toggle_board(boolean : bool):
	self.visible = boolean
