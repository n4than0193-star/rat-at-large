extends Node2D

@onready var shadow: Sprite2D = $Shadow
@onready var foot: Sprite2D = $Foot
@onready var hitbox: Area2D = $Hitbox

func _ready() -> void:
	shadow.visible = true
	foot.visible = false
	shadow.scale = Vector2(1.5, 1.5)
	hitbox.monitoring = true

	create_tween().tween_property(shadow, "scale", Vector2(2.0, 2.0), 1.0)
	
	await get_tree().create_timer(1.0).timeout
	_stomp()

func _stomp() -> void:
	shadow.visible = false
	foot.visible = true
	foot.scale = Vector2(1.3, 1.3)
	create_tween().tween_property(foot, "scale", Vector2(1.0, 1.0), 0.15)

	await get_tree().physics_frame
	var bodies := hitbox.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("hit"):
			body.hit()
	await get_tree().create_timer(0.4).timeout
	var exit_tween = create_tween()
	exit_tween.tween_property(self, "modulate:a", 0.0, 0.2)
	await exit_tween.finished
	queue_free()
