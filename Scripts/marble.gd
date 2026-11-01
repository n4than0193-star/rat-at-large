extends Node2D

@onready var shadow: Sprite2D = $Warning
@onready var foot: Sprite2D = $Marble
@onready var hitbox: Area2D = $Marble/Hitbox

func _ready() -> void:
	if not Global.death and not Global.win:
		shadow.visible = true
		shadow.self_modulate = Color8(-35, 255, -35)
		foot.visible = false
		hitbox.monitoring = false
		
		hitbox.body_entered.connect(_on_hitbox_body_entered)
		
		await get_tree().create_timer(0.75).timeout
		if not is_inside_tree(): return
		spawn()
	else:
		hide()
		hitbox.monitoring = false

func spawn() -> void:
	if Global.death or Global.win: 
		return
		
	shadow.visible = false
	foot.visible = true
	hitbox.monitoring = true
	create_tween().tween_property(foot, "scale", Vector2(1.5, 1.5), 0.15)
	
	for body in hitbox.get_overlapping_bodies():
		_on_hitbox_body_entered(body)
		
	await get_tree().create_timer(5.0).timeout
	if not is_inside_tree(): return
	despawn()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if hitbox.monitoring and "Player" in body.name and not Global.death and not Global.win:
		Global.enemy_health -= 1
		if Global.enemy_health <= 0:
			Global.win = true
		despawn_fast()

func despawn() -> void:
	hitbox.monitoring = false
	var exit_tween = create_tween()
	exit_tween.tween_property(self, "modulate:a", 0.0, 0.2)
	await exit_tween.finished
	queue_free()


func despawn_fast() -> void:
	hitbox.monitoring = false
	var exit_tween = create_tween()
	exit_tween.tween_property(self, "modulate:a", 0.0, 0.075)
	await exit_tween.finished
	queue_free()
