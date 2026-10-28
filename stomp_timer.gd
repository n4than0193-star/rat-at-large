extends Timer

@export var boot := preload("res://boot.tscn")

func _ready() -> void:
	spawn_loop()

func spawn_loop() -> void:
	while true:
		await get_tree().create_timer(1.5).timeout
		var new_obst = boot.instantiate()
		new_obst.position = Vector2(randf_range(0, 1174), randf_range(200, 800))
		add_child(new_obst)
