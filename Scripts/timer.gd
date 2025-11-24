# Sleep.gd (singleton)
extends Node

signal timeout

func add_timer(seconds: float):
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.timeout.connect(self._on_timer_timeout)
	
func _on_timer_timeout():
	emit_signal("timeout")
