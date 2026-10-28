extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.name == "Player": # Or your player's actual node name
		print("You safely escaped the crowd! You won!")
		# Stop camera scrolling or load a win screen here
		set_deferred("monitoring", false) 
