extends Node2D

const SHOCKWAVE := preload("res://Scenes/shockwave.tscn")

@onready var warning := $Warning
@onready var broom := $Broom
@onready var hitbox := $Broom/Hitbox

var target_position := Vector2.ZERO

func _ready() -> void:
	if not Global.death and not Global.win:
		broom.visible = false
		broom.frame = Global.level - 1
		hitbox.monitoring = true
		
		_setup_sweep()
		await get_tree().create_timer(1.0).timeout
		sweep()
	else:
		hide()
		hitbox.monitoring = false

func _setup_sweep() -> void:
	var size := get_viewport_rect().size
	var start_x := randf_range(0.0, size.x)
	var target_x := randf_range(0.0, size.x)
	
	global_position = Vector2(start_x, 0.0)
	target_position = Vector2(target_x, size.y + 200.0)
	
	global_rotation = (target_position - global_position).angle() - PI/2 #ai help asw
	
	warning.clear_points()
	warning.position = Vector2.ZERO
	warning.rotation = 0.0 
	
	var local_target := to_local(target_position) #ai help
	warning.add_point(Vector2.ZERO)
	warning.add_point(local_target)


func sweep() -> void:
	if Global.death and Global.win:
		return
	broom.visible = true
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "global_position", target_position, 0.5)
	

	
	for i in range(5):
		_spawn_shockwave()
		await get_tree().physics_frame
		for body in hitbox.get_overlapping_bodies():
			if body.has_method("hit"):
				body.hit()
		await get_tree().create_timer(0.1).timeout
				
				
	if not is_inside_tree():
		return
		
	var exit_tween = create_tween()
	exit_tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.2)
	await exit_tween.finished
	queue_free()

func _spawn_shockwave() -> void:
	if not Global.death:
		var wave := SHOCKWAVE.instantiate()
		get_parent().add_child(wave)
		wave.global_position = broom.global_position
