extends CanvasLayer

var is_animating := false

func _ready():
	visible = false
	

func fade_out():
	if is_animating:
		return
	Input.set_mouse_mode(Input.MouseMode.MOUSE_MODE_HIDDEN)
	is_animating = true
	visible = true
	$AnimationPlayer.play("fade_out")
	await get_tree().process_frame 
	await $AnimationPlayer.animation_finished


func fade_in():
	Input.set_mouse_mode(Input.MouseMode.MOUSE_MODE_VISIBLE)
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	visible = false
	is_animating = false
