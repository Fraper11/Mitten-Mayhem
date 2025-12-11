extends Node2D



func _on_rigid_body_2d_body_entered(body: Node) -> void:
	print(body.get_groups())
	if body.is_in_group("CRAB"):
		print("HO TOCCATO UN GRANCHIO")
		body.queue_free()  # rimuove il nemico
