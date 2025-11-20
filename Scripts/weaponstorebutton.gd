extends Button
var money :int = 200
var paymentofgun :int = 100
var havegun = false
func weaponstore():
	if havegun==false&&money>=paymentofgun:
		$"../Weaponstore/Button2".disabled=false
	else:
		$"../Weaponstore/Button2".disabled=true
		
	$"../Weaponstore".visible = true

func closeweaponstore():
	$"../Weaponstore".visible = false

func buygun():
	havegun = true
	$"../Weaponstore/Button2".disabled=true
	print("havegun")

func _ready():
	$".".pressed.connect(weaponstore)
	$"../Weaponstore/Button".pressed.connect(closeweaponstore)
	$"../Weaponstore/Button2".pressed.connect(buygun)
