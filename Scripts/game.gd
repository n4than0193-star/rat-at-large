extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.death = false
	Global.win = false
	$"Messages/Death Screen".hide()
	$"Messages/Win Screen".hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.death == true:
		$"Messages/Death Screen".show()
	if Global.win == true:
		$"Messages/Win Screen".show()
	
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
