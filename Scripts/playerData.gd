extends Node


signal weapon_unlocked(weapon_name: String)


@onready var level : int = 1
@onready var experience : int = 0
@onready var exp_to_next_level : int = 10
@onready var currency : int = 100


var unlocked_pages = {}


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

func unlock_page(page_id: String):
	unlocked_pages[page_id] = true
	print("UNLOCKED PAGES: ", unlocked_pages)

func is_unlocked(page_id: String) -> bool:
	return unlocked_pages.get(page_id, false)
	
func get_unlocked_pages():
	var list = []
	for page_id in unlocked_pages.keys():
		if unlocked_pages[page_id]:
			list[page_id] = EncyclopediaDb.pages[page_id]
	return list
