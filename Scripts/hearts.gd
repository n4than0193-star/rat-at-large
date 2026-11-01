extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.health = 3
	Global.death = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match Global.health:
		3:
				$Hearts.frame = 0
		2:
				$Hearts.frame = 1
		1:
				$Hearts.frame = 2
		0:
				$Hearts.frame = 3
				Global.death = true
