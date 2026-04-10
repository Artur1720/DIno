extends Area2D

# Перетягніть файл сцени прямо сюди в інспекторі, щоб шлях був правильним
@export var next_scene: String = "res://tiles_and_background_foreground/level_2.tscn"

var player_inside: bool = false
var is_transitioning: bool = false

func _ready() -> void:
	# На випадок, якщо сигнали не підключені в інспекторі — підключаємо їх кодом
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _input(event: InputEvent) -> void:
	# Перевіряємо натискання F (Portal)
	if player_inside and not is_transitioning:
		if event.is_action_pressed("Portal"):
			_start_transition()

func _start_transition() -> void:
	if next_scene == "" or not FileAccess.file_exists(next_scene):
		print("ПОМИЛКА: Сцена не знайдена за шляхом: ", next_scene)
		return

	is_transitioning = true
	print("Перехід на рівень: ", next_scene)
	
	# Використовуємо call_deferred для безпечної зміни сцени
	get_tree().call_deferred("change_scene_to_file", next_scene)

func _on_body_entered(body: Node2D) -> void:
	# Перевіряємо обидва варіанти написання групи та тип об'єкта
	if body.is_in_group("Player") or body.is_in_group("player") or body is CharacterBody2D:
		print("Гравець увійшов у зону порталу")
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("player") or body is CharacterBody2D:
		print("Гравець вийшов із зони порталу")
		player_inside = false
