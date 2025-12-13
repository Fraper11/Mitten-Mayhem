extends RigidBody2D

var health : int = 5
var initial_push : Vector2

@onready var audio = $Damage_taken_audio
@onready var death_audio = $DeathAudio

func _ready() -> void:
	var x = randi_range(int(-1), int(1))
	var y = randi_range(int(-1), int(1))
	initial_push = Vector2(x,y)
	self.add_constant_force(initial_push)

func takeDamage(damage : int):
	audio.stop()
	audio.play()
	health -= damage
	print(health)
	if health <= 0 :
		PlayerData.crab_killed_counter += 1
		PlayerData.experience += 5
		print(PlayerData.crab_killed_counter)
		audio.stop()
		death_audio.stop()
		death_audio.play()
		if(PlayerData.crab_killed_counter == 1):
			PlayerData.unlock_page("PAGE_002")
		if(PlayerData.crab_killed_counter == 5):
			PlayerData.unlock_page("PAGE_003")
		await death_audio.finished
		self.queue_free() 
