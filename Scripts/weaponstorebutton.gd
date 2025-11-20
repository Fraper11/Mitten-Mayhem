extends Button
@export var price :int
var purchased = false
func weaponstore():
	if purchased==false&& PlayerData.currency>=price:
		$"../Weaponstore/Button2".disabled=false
	else:
		$"../Weaponstore/Button2".disabled=true
		
	$"../Weaponstore".visible = true

func closeweaponstore():
	$"../Weaponstore".visible = false

func buyweapon():
	purchased = true
	$"../Weaponstore/Button2".disabled=true
	PlayerData.add_currency(-price)
	print("havegun")

func _ready():
	$".".pressed.connect(weaponstore)
	$"../Weaponstore/Button".pressed.connect(closeweaponstore)
	$"../Weaponstore/Button2".pressed.connect(buyweapon)
