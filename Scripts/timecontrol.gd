extends Node2D
@export var ActionperTurn : int = 2
var ActionNow : int = 0
var PassedDay : int = 0

func one_round():
		if$EMclpointer01.visible == true:
			$EMclpointer01.visible = false
			$Mclpointer01.visible = true	
		elif$Mclpointer01.visible == true:
			$Mclpointer01.visible = false
			$Eclpointer01.visible =true
		elif$Eclpointer01.visible ==true:
			$Eclpointer01.visible =false
			$Nclpoint01.visible = true
		else:
			$Nclpoint01.visible = false
			$EMclpointer01.visible = true
			PassedDay=PassedDay+1

func skip():
	ActionNow=0
	one_round()

func action():
	ActionNow=ActionNow+1
	if ActionNow==ActionperTurn:
		skip()
			
func _ready():
	$Button.pressed.connect(skip)
