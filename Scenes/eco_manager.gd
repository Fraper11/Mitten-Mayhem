extends Node

@onready var label = $InfoTestLabel

var season = 0
var nets = 0
var clam_collectors = 0
var action_counter = 0
var ap_per_season = 4
var water_quality:float = 1.0
var clam_filtration_rate = 0.1

var trap_level = 0
const trap_effectiveness = 0.1
const trap_level_cap = 5

var algae_appetite_small = 0.1
var algae_appetite_big = 0.2
var clam_appetite = 0.1

var crab_hunt_rate = 0.01
var fish_hunt_rate = 0.02
var crab_death_rate = 0.05
var crab_growth_rate = 1.0/ap_per_season
var crabs_spawn_rate = 0.3
var fish_death_rate = 0.05
var fish1_spawn_rate = 0.05
var fish2_spawn_rate = 0.05
var fish3_spawn_rate = 0.05
var clam_spawn_rate = 0.05
var algae_spawn_rate = 0.05

var young_crabs:int = 10
var old_crabs:int = 20
var fish1:int = 200 # Small fish
var fish2:int = 150 # Large fish
var fish3:int = 100 # Predator fish
var algae:int = 1500
var clam:int = 150

var money = 0
var fish1_price = 1
var fish2_price = 2
var fish3_price = 3
var clam_price = 3

var zone1 = false
var zone2 = false
var zone3 = false
var zone4 = false

var clam_catch_rate = 0.1
var small_catch_rate = 0.1
var big_catch_rate = 0.2
var crab_catch_rate = 0.05


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func action():
	# Algae spawn
	algae += round(algae_spawn_rate * algae * water_quality - algae_appetite_small * (fish1 + young_crabs) - algae_appetite_big * (old_crabs + fish2))
	# Clam spawn
	clam += round(clam * clam_spawn_rate * water_quality/1 - clam_appetite * old_crabs)
	
	# Water quality calculation
	if clam:
		water_quality += clam_filtration_rate * clam
	if water_quality:
		water_quality -= 0.1
	if water_quality > 1.0:
		water_quality = 1.0
	if water_quality < 0:
		water_quality = 0
	
	# Crab catching results
	var crab_caught = trap_level * trap_level * trap_effectiveness + nets * crab_catch_rate
	young_crabs -= ceil(crab_caught * 2/3)
	old_crabs -= ceil(crab_caught * 1/3)
	
	# Fishing and hunt results
	var fish1_caught = nets * small_catch_rate
	var fish2_caught = nets * big_catch_rate
	var fish3_caught = nets * big_catch_rate
	var clam_caught = clam_collectors * clam_catch_rate
	fish1 -= ceil((young_crabs + old_crabs) * crab_hunt_rate + fish3 * fish_hunt_rate + fish1_caught)
	fish2 -= ceil(old_crabs * crab_hunt_rate + fish2_caught)
	fish3 -= ceil(old_crabs * crab_hunt_rate + fish3_caught)
	clam -= ceil(old_crabs * crab_hunt_rate + clam_caught)
	# Gotta add a check if there is enough animals to have such a catch
	
	# Profit
	money += fish1_caught * fish1_price + fish2_caught * fish2_price + fish3_caught * fish3_price + clam_caught * clam_price
	
	match season:
		0: # Hatching season
			if algae > 0:
				fish1 += round(fish1 * fish1_spawn_rate * water_quality)
				fish2 += round(fish2 * fish2_spawn_rate * water_quality)
			
			if fish1 > 0 and fish2 > 0:
				fish3 += round(fish3 * fish3_spawn_rate * water_quality)
			
			if fish1 > 0 and fish2 > 0 and fish3 > 0 and clam > 0 and algae > 0:
				young_crabs += round(old_crabs * crabs_spawn_rate)
			
		1: # Growth season
			# Crab growth
			var growing_crabs:int = round(young_crabs / 2.0)
			if fish1 > 0 and fish2 > 0 and fish3 > 0 and clam > 0 and algae > 0:
				old_crabs += growing_crabs # Crabs don't grow without food
			young_crabs -= growing_crabs
		
		2: # Mating season
			# Old crabs die
			old_crabs += round(young_crabs - old_crabs * crab_death_rate)
			young_crabs = 0
	
	# Ensure positive population values and no single survivors
	if fish1 <= 1:
		fish1 = 0
	if fish2 <= 1:
		fish2 = 0
	if fish3 <= 1:
		fish3 = 0
	if algae <= 1:
		algae = 0
	if clam <= 1:
		clam = 0
	if young_crabs <= 1:
		young_crabs = 0
	if old_crabs <= 1:
		old_crabs = 0
	
	# Hunger
	if algae < fish1/2:
		fish1 = floor(fish1/2) 
	if algae < fish2/2:
		fish2 = floor(fish2/2)
	if fish1 + fish2 < fish3/2:
		fish3 = floor(fish3/2)
	if fish1 + fish2 + fish3 + clam + algae < young_crabs/2:
		young_crabs = floor(young_crabs/2)
	if fish1 + fish2 + fish3 + clam + algae < old_crabs/2:
		old_crabs = floor(old_crabs/2)
	
	action_counter += 1
	if action_counter >= ap_per_season:
		season += 1
		action_counter = 0
		if season >= 3:
			season = 0
	update_output()


func update_output():
	var season_text = 'Hatching'
	match season:
		1:
			season_text = 'Growing'
		2:
			season_text = 'Breeding'
	
	var output ="""Season: %s
	Actions left this season: %s/%s
	Water Quality: %s
	
	Juvenile crab: %s
	Adult crab: %s
	Fish 1: %s
	Fish 2: %s
	Fish 3: %s
	Clam: %s
	Algae: %s
	
	Money: %s
	Trap level:  %s
	""" % [season_text, action_counter, ap_per_season, round(water_quality*100), young_crabs, old_crabs, fish1, fish2, fish3, clam, algae, money, trap_level]
	
	label.text = output


func _on_skip_action_button_up() -> void:
	action()


func _on_build_trap_button_up() -> void:
	trap_level = 1
	$"../Controls/BuildTrap".visible = false
	$"../Controls/UpgradeTrap".visible = true
	$"../Buildings/Trap".visible = true
	action()


func _on_upgrade_trap_button_up() -> void:
	if trap_level < trap_level_cap:
		trap_level += 1
	if trap_level == trap_level_cap:
		$"../Controls/UpgradeTrap".disabled = true
	action()


func _on_zone_1_net_set() -> void:
	nets += 1
	zone1 = true
	action()


func _on_zone_1_net_collect() -> void:
	nets -= 1
	zone1 = false
	action()


func _on_zone_2_net_set() -> void:
	nets += 1
	zone2 = true
	action()


func _on_zone_2_net_collect() -> void:
	nets -= 1
	zone2 = false
	action()


func _on_zone_3_net_set() -> void:
	clam_collectors += 1
	zone3 = true
	action()


func _on_zone_3_net_collect() -> void:
	clam_collectors -= 1
	zone3 = false
	action()


func _on_zone_4_net_set() -> void:
	clam_collectors += 1
	zone4 = true
	action()


func _on_zone_4_net_collect() -> void:
	clam_collectors -= 1
	zone4 = false
	action()


func _on_reset_button_up() -> void:
	get_tree().reload_current_scene()
