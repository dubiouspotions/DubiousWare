extends Control

var config:Config

var game

# Called when the node enters the scene tree for the first time.
func _ready():
	prep_game()
	config = load("user://config.tres")
	if not config:
		config = Config.new()
	$DebugLevelText.text = config.debug_level
	var games = Arcade.all_games()
	for name in games:
		add_game_button(name)

func prep_game():
	game = Game.new()
	game.menu = self
	update_player_selection()
	
func update_player_selection():
	for p in game.players:
		var selbox = $PlayerSelection.find_node(p.index)
		selbox.set_player(p)

func add_game_button(name: String):
	var button = GameButton.new()
	button.text = name
	$DebugButtons.add_child(button)

func save_config():
	ResourceSaver.save("user://config.tres", config)

func _on_Button_pressed():
	if not game.has_any_players():
		OS.alert("You must be at least one player to start a game. Press an action button (space, period, X on controller) to join.", "Oops!")
		return
	game.debug_level = $DebugLevelText.text
	get_tree().get_root().add_child(game)
	game.start()
	


func _on_TextEdit_text_changed():
	config.debug_level = $DebugLevelText.text
	save_config()
	pass # Replace with function body.

func _input(evt):
	if Input.is_action_pressed("ui_accept"):
		_on_Button_pressed()

