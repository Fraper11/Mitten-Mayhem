extends Node

@onready var level : int = 1
@onready var experience : int = 0
@onready var exp_to_next_level : int = 10
@onready var currency : int = 100

func add_exp(exp_to_add):
	experience += exp_to_add
	process_levelling()
	print ("Total Eperience: ",experience)

func process_levelling():
	if (experience >= exp_to_next_level):
		add_Level(1)
		experience -= exp_to_next_level
		exp_to_next_level = 10 + (level * level * 2)
		print("Exp to the next Level: ",exp_to_next_level)

func add_Level(lev_to_add):
	level += lev_to_add
	print("Level: ",level)

func add_currency(cur_to_add):
	currency += cur_to_add
	print("Balance: ",currency)
