extends Node2D

@export var max_radius := 350.0
@export var duration := 0.7
@export var thickness := 28.0
@export var color: Color

var area: Area2D
var shape: CircleShape2D

var radius := 1.0:
	set(value):
		radius = value
		if shape:
			shape.radius = max(value, 1.0)
		queue_redraw()

func _ready() -> void:
	shape = CircleShape2D.new()
	shape.radius = 1.0
	var col := CollisionShape2D.new()
	col.shape = shape

	area = Area2D.new()
	area.collision_layer = 1
	area.collision_mask = 0xFFFFFFFF   
	area.monitoring = true
	area.add_child(col)
	add_child(area)
	area.body_entered.connect(_on_body_entered)

	var tween := create_tween().set_parallel(true)
	tween.tween_property(self, "radius", max_radius, duration) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)		#
	tween.tween_property(self, "modulate:a", 0.0, duration)			#this tween was helped by AI sorry (and it guided me through coding this shockwave)
	tween.finished.connect(queue_free)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit()

func _draw() -> void:
	if Global.level == 1:
		color = Color(1.0, 0.8, 0.3, 1.0)
	else:
		color = Color(0.4, 0.7, 1.0, 1.0)
	
	draw_circle(Vector2.ZERO, radius, Color(color, 0.12))
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 96, color, thickness, true)
