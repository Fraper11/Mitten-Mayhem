extends Node

@onready var crab_population : int = 0

func addCrab (crab : int): 
	crab_population += crab
	print(crab_population)
	
	
