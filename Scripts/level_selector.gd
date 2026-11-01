extends Node2D

func _on_level_1_pressed() -> void:
	Global.level = 1
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_level_2_pressed() -> void:
	Global.level = 2
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
