extends Camera2D

"""@export var scroll_speed: float = 100.0
@export var player_path: NodePath
@onready var player = get_node(player_path) as CharacterBody2D

func _process(delta: float) -> void:
	position.y -= scroll_speed * delta
	
	if is_instance_valid(player):
		var viewport_size = get_viewport_rect().size / zoom
		var top_boundary = position.y - (viewport_size.y / 2) + 32
		var bottom_boundary = position.y + (viewport_size.y / 2) - 32
		
		player.position.y = clamp(player.position.y, top_boundary, bottom_boundary)"""
