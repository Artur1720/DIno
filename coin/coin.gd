extends Area2D

var player_in_area = false

func _ready():
	$AnimatedSprite2D.play("anim")
	GameState.total_coins += 1
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_area = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_area = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		collect()

func collect():
	GameState.add_coin()
	queue_free()
