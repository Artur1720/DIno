extends Node

var lives = 3
var coins = 0
var total_coins = 0

signal lives_changed(value)
signal coins_changed(value)
signal level_complete
signal game_over  

func _ready():
	reset()

func reset():
	lives = 3
	coins = 0
	
	emit_signal("lives_changed", lives)
	emit_signal("coins_changed", coins)


func start_level(coins_on_level: int):
	coins = 0
	total_coins = coins_on_level
	emit_signal("coins_changed", coins)

func add_coin():
	coins += 1
	emit_signal("coins_changed", coins)

	if total_coins > 0 and coins >= total_coins:
		emit_signal("level_complete")

func lose_life():
	lives -= 1
	emit_signal("lives_changed", lives)
	
	if lives <= 0:
		emit_signal("game_over")

func gain_life():
	lives += 1
	emit_signal("lives_changed", lives)
