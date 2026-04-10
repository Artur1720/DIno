extends CharacterBody2D

# Посилання на вузли
@onready var sprite = $AnimatedSprite2D

# Константи фізики
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const KNOCKBACK_FORCE = 350.0

# Стани
var is_knocked_back = false

func _physics_process(delta: float) -> void:
	# 1. Гравітація
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not is_knocked_back:
		handle_movement()
	
	move_and_slide()
	
	update_animations()

func handle_movement():
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func update_animations():
	if is_knocked_back:
		if sprite.sprite_frames.has_animation("hurt"):
			sprite.play("hurt")
		return

	if not is_on_floor():
		sprite.play("jump")
	elif velocity.x != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

func take_damage(amount: int, source_position: Vector2) -> void:
	GameState.lose_life()
	
	if GameState.lives <= 0:
		die()
	else:
		apply_knockback(source_position)

func apply_knockback(source_position: Vector2) -> void:
	is_knocked_back = true
	
	var dir = sign(global_position.x - source_position.x)
	if dir == 0: dir = 1 
	
	velocity.x = dir * KNOCKBACK_FORCE
	velocity.y = -150 
	
	await get_tree().create_timer(0.2).timeout
	is_knocked_back = false

func die() -> void:
	GameState.reset() 
	
	get_tree().paused = false
	
	get_tree().call_deferred("change_scene_to_file", "res://death.tscn")
