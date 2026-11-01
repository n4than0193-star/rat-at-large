extends Timer

@export var boot := preload("res://Scenes/boot.tscn")
@export var slicer :=  preload("res://Scenes/slicer.tscn")
@export var marble := preload("res://Scenes/marble.tscn")

func _ready() -> void:
	Global.death = false
	boot_loop()
	slicer_loop()
	marble_loop()

func boot_loop() -> void:
	while is_inside_tree() and not Global.death and not Global.win:
		await get_tree().create_timer(1.0).timeout
		if Global.death or not is_inside_tree():
			break

		var new_obst = boot.instantiate()
		new_obst.position = Vector2(randf_range(0, 1000), randf_range(300, 800))
		add_child(new_obst)

func slicer_loop() -> void:
	while is_inside_tree() and not Global.death and not Global.win:
		await get_tree().create_timer(3.0).timeout
		if Global.death or not is_inside_tree():
			break

		var new_obst = slicer.instantiate()
		add_child(new_obst)

func marble_loop() -> void:
	while is_inside_tree() and not Global.death and not Global.win:
		await get_tree().create_timer(randi_range(7, 12)).timeout
		if Global.death or not is_inside_tree(): 
			break

		var new_marb = marble.instantiate()
		new_marb.position = Vector2(randf_range(0, 1000), randf_range(300, 800))
		add_child(new_marb)
