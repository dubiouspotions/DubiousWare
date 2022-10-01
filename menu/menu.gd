extends Control

var config:Config

# Called when the node enters the scene tree for the first time.
func _ready():

	config = load("user://config.tres")
	if not config:
		config = Config.new()
	$DebugLevelText.text = config.debug_level
	var games = Arcade.all_games()
	for name in games:
		add_game_button(name)

func add_game_button(name: String):
	var button = GameButton.new()
	button.text = name
	$GridContainer.add_child(button)

func save_config():
	ResourceSaver.save("user://config.tres", config)

func _on_Button_pressed():
	var game = Game.new()
	game.debug_level = $DebugLevelText.text
	get_tree().get_root().add_child(game)
	game.start()
	


func _on_TextEdit_text_changed():
	config.debug_level = $DebugLevelText.text
	save_config()
	pass # Replace with function body.
