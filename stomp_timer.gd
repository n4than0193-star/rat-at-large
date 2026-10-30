extends Timer

@export var boot := preload("res://boot.tscn")
@export var broom :=  preload("res://broom.tscn")

func _ready() -> void:
	boot_loop()
	broom_loop()

func boot_loop() -> void:
	Global.death = false
	while not Global.death:
		await get_tree().create_timer(1.0).timeout
		var new_obst = boot.instantiate()
		new_obst.position = Vector2(randf_range(0, 1000), randf_range(300, 800))
		add_child(new_obst)
	
func broom_loop() -> void:
	Global.death = false
	while not Global.death:
		await get_tree().create_timer(4.0).timeout
		var new_obst = broom.instantiate()
		add_child(new_obst)
