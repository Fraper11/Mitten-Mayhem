extends CanvasLayer

var is_animating := false

func _ready():
	visible = false
	

func fade_out():
	if is_animating:
		return
	is_animating = true
	visible = true
	$AnimationPlayer.play("fade_out")
	await get_tree().process_frame 
	await $AnimationPlayer.animation_finished


func fade_in():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	visible = false
	is_animating = false
