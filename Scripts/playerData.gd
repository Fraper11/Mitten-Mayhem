extends Node


signal weapon_unlocked(weapon_name: String)


@onready var level : int = 5
@onready var experience : int = 0
@onready var exp_to_next_level : int = 10
@onready var currency : int = 10000
@onready var crab_inventory_counter : int = 10
@onready var weapon_equipped : String = ""
@onready var crab_killed_counter :int = 0

var unlocked_pages = {}
var unlocked_pages_counter : int 


func add_exp(exp_to_add : int):
	experience += exp_to_add
	ExpCurrencyTest.change_text("exp",exp_to_add)
	ExpCurrencyTest.usePopUp("exp")
	process_levelling()
	print ("Total Eperience: ",experience)

func process_levelling():
	if (experience >= exp_to_next_level):
		add_Level(1)
		experience -= exp_to_next_level
		exp_to_next_level = 10 + (level * level * 2)
		print("Exp to the next Level: ",exp_to_next_level)

func add_Level(lev_to_add: int):
	level += lev_to_add
	print("Level: ",level)

func add_currency(cur_to_add: int):
	currency += cur_to_add
	ExpCurrencyTest.change_text("coins",cur_to_add)
	ExpCurrencyTest.usePopUp("coins")
	print("Balance: ",currency)

func spend_currency(cur_to_spend: int):
	currency -= cur_to_spend
	ExpCurrencyTest.spend_currency()
	print("Balance: ",currency)


func unlock_page(page_id: String):
	if (unlocked_pages.has(page_id) && unlocked_pages[page_id] == true):
		return
	
	unlocked_pages[page_id] = true
	unlocked_pages_counter += 1
	ExpCurrencyTest.usePopUp("page")
	print("UNLOCKED PAGES: ", unlocked_pages)
	#print("YOU HAVE A TOTAL OF PAGEN N. : " + str(unlocked_pages_counter))
	if unlocked_pages_counter == 6:
		SceneLoader.load_scene(SceneStorage.SceneID.WIN)

func is_unlocked(page_id: String) -> bool:
	return unlocked_pages.get(page_id, false)
	
func get_unlocked_pages():
	var list = []
	for page_id in unlocked_pages.keys():
		if unlocked_pages[page_id]:
			list[page_id] = EncyclopediaDb.pages[page_id]
	return list

func add_crab_to_inventory(crabs : int) :
	crab_inventory_counter += crabs
	
func equip_weapon(new_weapon : String):
	weapon_equipped = new_weapon

func add_crab_killed(crab : int):
	crab_killed_counter += crab
	if crab_killed_counter == 1 :
		unlock_page("PAGE_002")
	if crab_killed_counter == 10 : 
		unlock_page("PAGE_003")
