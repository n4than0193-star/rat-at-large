extends CharacterBody2D

@export var speed := 350.0
@export var friction := 0.2
@export var iframe_duration := 2
@export var iframe_cooldown := 5
@export var dash_speed := 900.0
@export var dash_duration := 0.15
@export var dash_cooldown := 0.6 

var is_invincible: bool = false
var can_use_iframe: bool = true
var dash_time_left := 0.0
var cooldown_left := 0.0
var dash_direction := Vector2.ZERO
var last_direction := Vector2.RIGHT

func _process(delta: float) -> void:
	if dash_time_left > 0.0:
		$ColorRect.self_modulate = Color8(0,0,255)
	elif Global.invincible == true:
		$ColorRect.self_modulate = Color8(0,255,0)
	else:
		$ColorRect.self_modulate = Color8(255,255,255)
		
func _physics_process(delta: float) -> void:
	var input_direction := Input.get_vector("Left", "Right", "Up", "Down")

	if input_direction != Vector2.ZERO:
		last_direction = input_direction

	cooldown_left = max(cooldown_left - delta, 0.0)

	if Input.is_action_just_pressed("Dash") and cooldown_left <= 0.0 and dash_time_left <= 0.0:
		dash_direction = last_direction
		dash_time_left = dash_duration
		cooldown_left = dash_cooldown

	if dash_time_left > 0.0:
		dash_time_left = max(dash_time_left - delta, 0.0)
		velocity = dash_direction * dash_speed
	elif input_direction != Vector2.ZERO:
		velocity = input_direction * speed
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	Global.invincible = dash_time_left > 0.0
	move_and_slide()

	if Input.is_action_just_pressed("Scream") and can_use_iframe:
		squeak()

func squeak() -> void:
	Global.invincible = true
	can_use_iframe = false
	
	await get_tree().create_timer(iframe_duration).timeout
	Global.invincible = false

	await get_tree().create_timer(iframe_cooldown).timeout
	can_use_iframe = true

func hit() -> void:
	if Global.invincible:
		return
	print("Crushed! Game Over!")
	get_tree().reload_current_scene()
