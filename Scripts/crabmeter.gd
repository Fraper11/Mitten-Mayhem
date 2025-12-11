extends Sprite2D


var meter:Array = []

func _ready():
	for child in get_children():
		meter.append(child)
	
	print(meter)

func _process(delta: float) -> void:
	for child in get_children():
		child.visible=false
	
	for i in CrabData.crab_population:
		if (i <10):
			meter[i].visible=true
	
