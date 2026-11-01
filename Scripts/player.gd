extends CharacterBody2D

@export var speed := 450.0
@export var friction := 0.2
@export var squeak_duration := 2
@export var squeak_cooldown := 5
@export var can_squeak := true
@export var dash_speed := 1200.0
@export var dash_duration := 0.15
@export var dash_cooldown := 0.6

var input_direction := Vector2.ZERO
var dash_time_left := 0.0
var cooldown_left := 0.0
var dash_direction := Vector2.ZERO
var last_direction := Vector2.RIGHT
var color = false

func _process(_delta: float) -> void:
	if not Global.death and not Global.win:
		input_direction = Input.get_vector("Left", "Right", "Up", "Down")
		if dash_time_left > 0.0:
			$ColorRect.play("Dash")
		elif input_direction == Vector2.ZERO:
			$ColorRect.play("Idle")
		else:
			$ColorRect.play("Walk")
	else:
		$ColorRect.play("Dead")

func _physics_process(delta: float) -> void:
	if not Global.death and not Global.win:
		if input_direction != Vector2.ZERO:
			last_direction = input_direction
			rotation = last_direction.angle() + PI / 2
			
		cooldown_left = max(cooldown_left - delta, 0.0)
		
		if Input.is_action_just_pressed("Dash") and cooldown_left <= 0.0 and dash_time_left <= 0.0:
			dash_direction = last_direction.normalized()
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
		
		position.x = clamp(position.x, -575, 525)
		position.y = clamp(position.y, -305, 290)

func hit() -> void:
	if not Global.death and not Global.win:
		if Global.invincible == true:
			return
		Global.health -= 1
		await get_tree().create_timer(0.2).timeout
