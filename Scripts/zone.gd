extends Node
signal net_set
signal net_collect

@onready var progress_bar = $ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if progress_bar.value >= progress_bar.max_value:
		$CollectFull.visible = true
		$CollectEarly.visible = false


func _on_any_collect_button_up() -> void:
	$Set.visible = true
	$CollectFull.visible = false
	$CollectEarly.visible = false
	emit_signal('net_collect')


func _on_set_button_up() -> void:
	$CollectEarly.visible = true
	$Set.visible = false
	emit_signal('net_set')
