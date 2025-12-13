extends Sprite2D

@onready var game_over_sound : AudioStreamPlayer2D = $Game_over

var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.GAMEOVER
var meter:Array = []

func _ready():
	for child in get_children():
		meter.append(child)
	
	print(meter)

func _process(delta: float) -> void:
	if(CrabData.crab_population>=9):
		SceneLoader.load_scene(target_scene)
		game_over_sound.play()
		CrabData.crab_population=0
	
	for child in get_children():
		child.visible=false
	
	for i in CrabData.crab_population:
		if (i <10):
			meter[i].visible=true
	
