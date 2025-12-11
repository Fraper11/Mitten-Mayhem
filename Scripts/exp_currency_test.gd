extends Control

@onready var label_currency: Label =$Board/currency 
@onready var label_level: Label = $Board/Level
@onready var label_experience: Label = $Board/Experience
@onready var page_unlocked : Control = $Popups/Page_unlocked
@onready var exp_earned : Control = $Popups/Exp_Earned
@onready var coins_earned : Control = $Popups/Coins_Earned
@onready var exp_label : Label = $Popups/Exp_Earned/Label
@onready var coins_label : Label = $Popups/Coins_Earned/Label

var in_use : bool = false

func _ready() -> void:
	page_unlocked.visible = false
	exp_earned.visible = false
	coins_earned.visible = false

func _process(delta): 
	label_level.text = "%d" % PlayerData.level
	label_currency.text = "%d" % PlayerData.currency 
	label_experience.text = "%d / %d" %[PlayerData.experience,PlayerData.exp_to_next_level]
	if (get_tree().current_scene != null && get_tree().current_scene.scene_file_path == "res://Scenes/Map_test.tscn") :
		self.visible = true
	else : self.visible = false

func usePopUp (name : String):
	if in_use == true && name!="page":
		return
		
	if name == "page" :
		page_unlocked.visible = true
		in_use = true
		GlobalTimer.add_timer(1.5)
		GlobalTimer.timeout.connect(Callable(self,"on_timeout_page"))
	if name == "exp" :
		exp_earned.visible = true
		in_use = true
		GlobalTimer.add_timer(1.5)
		GlobalTimer.timeout.connect(Callable(self,"on_timeout_exp")) 
	if name == "coins" :
		coins_earned.visible = true
		in_use = true
		GlobalTimer.add_timer(1.5)
		GlobalTimer.timeout.connect(Callable(self,"on_timeout_coins"))

func change_text(label : String,sum :int):
	if label == "exp":
		exp_label.text = ("You Gained "+ str(sum) + " EXP")
	if label == "coins":
		coins_label.text = ("You Gained "+ str(sum) + " Coins")
	


func on_timeout_page():
	page_unlocked.visible = false
	in_use = false
	
func on_timeout_exp():
	exp_earned.visible = false
	in_use = false

func on_timeout_coins():
	coins_earned.visible = false
	in_use = false
