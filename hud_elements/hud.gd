extends CanvasLayer

@onready var lives_label = $VBoxContainer/LivesLabel
@onready var coins_label = $VBoxContainer/CoinsLabel

func _ready():
	GameState.lives_changed.connect(update_lives)
	GameState.coins_changed.connect(update_coins)
	GameState.level_complete.connect(on_level_complete)
	
	update_lives(GameState.lives)
	update_coins(GameState.coins)

func update_lives(value):
	lives_label.text = "❤️ " + str(value)

func update_coins(value):
	coins_label.text = "💰 " + str(value)

func on_level_complete():
	lives_label.text = "🏆"
	coins_label.text = "🎉 Рівень пройдено!"
