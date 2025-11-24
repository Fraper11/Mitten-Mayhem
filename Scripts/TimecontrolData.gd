extends Node2D
@onready var passed_day :int =0
@export var action_per_phase :int = 2
@onready var actionnow :int =0
@onready var phase_of_day :int =0

func next_phase():
	if(phase_of_day==3):
		phase_of_day=0
		passed_day=passed_day+1
	else:
		phase_of_day=phase_of_day+1
		
func skip():
	actionnow=0
	next_phase()

func action():
	actionnow=actionnow+1
	if actionnow==action_per_phase:
		skip()
