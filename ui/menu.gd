extends Node2D

func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://tiles_and_background_foreground/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
