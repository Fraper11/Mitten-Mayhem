# Sleep.gd (singleton)
extends Node


func add_timer(seconds: float,callable:Callable):
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	CursorMovement.stop_mouse()
	timer.start()
	if callable != null:
		timer.timeout.connect(callable)
		
	timer.timeout.connect(Callable(CursorMovement, "activate_mouse"))
	timer.timeout.connect(timer.queue_free)
