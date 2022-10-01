class_name Arcade 
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var debug_level = ""
var game


static func all_games() -> Array:
	var gamesd = Directory.new()
	gamesd.open("res://minigames/")
	gamesd.list_dir_begin()
	var gamenames = []
	var game_name = gamesd.get_next()
	while game_name != "":
		if game_name[0] != ".":
			print("Found minigame "+game_name)
			gamenames.push_back(game_name)
		game_name = gamesd.get_next()
	return gamenames

func loadRandomMinigame():
	var gamenames = all_games()
	gamenames.shuffle()
	var chosen_game = gamenames[0]
	if debug_level != "":
		chosen_game = debug_level
	print("PLAYING minigame "+chosen_game)
	
	var scene = load("res://minigames/" + chosen_game + "/" + chosen_game + ".tscn")
	if scene == null:
		scene = load("res://minigames/" + chosen_game + "/puzzle.tscn")
	assert(scene != null)
	return scene

func _ready():
	randomize()
	

	var screen_size = get_viewport_rect().size
	var mg_scale = 0.25 # Minigame scale factor
	var mg_size = Vector2(1024 * mg_scale, 1024 * mg_scale)
	var n_games = Vector2(2, 2)
	
	var scene = loadRandomMinigame()
	
	for p in game.players:
		var split = scene.instance()
		split.transform = split.transform.scaled(Vector2(mg_scale, mg_scale))
		split.player = p
		split.player_index = p.index
		find_node(p.index).add_child(split)
	
	$Countdown.connect("countdown_done",self,"end_game")

func end_game():
	for p in game.players:
		var split = $splits.find_node(p.index)
		var splitgame = split.get_child(0)
		var won = splitgame.getPlayerDidWin()
		if won:
			p.add_point()
		print("Won? ", p.index, won, p.score)
	game.play_next()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
