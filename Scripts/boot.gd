extends Node2D

const SHOCKWAVE := preload("res://Scenes/shockwave.tscn")

@onready var shadow: Sprite2D = $Shadow
@onready var foot: AnimatedSprite2D = $Foot
@onready var hitbox: Area2D = $Foot/Hitbox


func _ready() -> void:
	if not Global.death and not Global.win:
		shadow.visible = true
		shadow.self_modulate = Color8(255,170,170)
		foot.visible = false
		foot.frame = Global.level - 1
		shadow.scale = Vector2(1.5, 1.5)
		hitbox.monitoring = true

		create_tween().tween_property(shadow, "scale", Vector2(2.0, 2.0), 1.0)
		
		await get_tree().create_timer(0.75).timeout
		stomp()
	else:
		hide()
		hitbox.monitoring = false
func stomp() -> void:
	if not Global.death and not Global.win:
		shadow.visible = false
		foot.visible = true
		foot.scale = Vector2(12.25, 12.41)
		create_tween().tween_property(foot, "scale", Vector2(9.0, 9.0), 0.15)

		_spawn_shockwave()

		await get_tree().physics_frame
		for body in hitbox.get_overlapping_bodies():
			if body.has_method("hit"):
				body.hit()
				await body.hit()

		if not is_inside_tree():
			return
		await get_tree().create_timer(0.75).timeout
		if not is_inside_tree():
			return

		var exit_tween = create_tween()
		exit_tween.tween_property(self, "modulate:a", 0.0, 0.2)
		await exit_tween.finished
		queue_free()

func _spawn_shockwave() -> void:
	if not Global.death and not Global.win:
		var wave := SHOCKWAVE.instantiate()
		get_parent().add_child(wave)
		wave.global_position = foot.global_position
