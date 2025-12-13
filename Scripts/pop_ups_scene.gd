extends Control

@onready var page_unlocked : Control = $Page_unlocked
@onready var exp_earned : Control = $Exp_Earned
@onready var coins_earned : Control = $Coins_Earned
@onready var exp_label : Label = $Exp_Earned/Label
@onready var coins_label : Label = $Coins_Earned/Label
@onready var spend_money_sound : AudioStreamPlayer2D = $spend_coins
@onready var weapon_equipped : Control = $weapon_equipped
@onready var weapon_label : Label = $weapon_equipped/Label

var currency_spent_audio_file = preload("res://Audio/Coin_spent.wav")
var popup_audio_file = preload("res://Audio/PopUp.wav")


func _ready() -> void:
	page_unlocked.visible = false
	exp_earned.visible = false
	coins_earned.visible = false
	weapon_equipped.visible = false
	
	
func usePopUp (name : String):
	var popup_sound: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	add_child(popup_sound)
	popup_sound.stream = popup_audio_file
	popup_sound.play()
	popup_sound.finished.connect(popup_sound.queue_free)
	
	toggle_visibility(name)
	GlobalTimer.add_timer(1, Callable(self, "toggle_visibility").bind(name))
		
func toggle_visibility(popup_name : String):
	if popup_name == "page":
		page_unlocked.visible = !page_unlocked.visible
	if popup_name == "exp":
		exp_earned.visible = !exp_earned.visible
	if popup_name == "coins":
		coins_earned.visible = !coins_earned.visible
	if popup_name == "weapon":
		weapon_equipped.visible = !weapon_equipped.visible

func spend_currency():
	spend_money_sound.play()

func change_text(label : String,sum :int):
	if label == "exp":
		exp_label.text = ("You Gained "+ str(sum) + " EXP")
	if label == "coins":
		coins_label.text = ("You Gained "+ str(sum) + " Coins")
	if label == "weapon":
		weapon_label.text = ("You Equipped: "+ PlayerData.weapon_equipped)
	
