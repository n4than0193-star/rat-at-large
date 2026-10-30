extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.name == "Player": 
		print("You safely escaped the crowd! You won!")
		set_deferred("monitoring", false) 
