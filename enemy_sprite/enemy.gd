extends CharacterBody2D

const SPEED = 100.0
const GRAVITY = 700.0

var direction = 1
var patrol_distance = 80.0
var start_x = 0.0

func _ready():
	start_x = global_position.x
	$AnimatedSprite2D.play("run")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	velocity.x = SPEED * direction
	$AnimatedSprite2D.flip_h = direction < 0

	move_and_slide()

	if is_on_wall():
		direction *= -1
		start_x = global_position.x

	if abs(global_position.x - start_x) >= patrol_distance:
		direction *= -1
		start_x = global_position.x

	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		var body = col.get_collider()
		if body.is_in_group("Player"):
			body.die()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(1, global_position)
