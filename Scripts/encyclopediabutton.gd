extends Button
func encyclopedia():
	$"../Encyclopedia".visible=true

func closeencyclopedia():
	$"../Encyclopedia".visible=false

func habitat():
	$"../Encyclopedia/Panel".visible=true

func closehabitat():
	$"../Encyclopedia/Panel".visible=false

func _ready():
	$".".pressed.connect(encyclopedia)
	$"../Encyclopedia/Button".pressed.connect(closeencyclopedia)
	$"../Encyclopedia/Button2".pressed.connect(habitat)
	$"../Encyclopedia/Panel/Button".pressed.connect(closehabitat)
