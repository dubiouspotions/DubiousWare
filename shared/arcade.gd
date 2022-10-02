class_name Arcade 
extends Node2D

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
	while chosen_game == game.last_game_name:
		gamenames.shuffle()
		chosen_game = gamenames[0]
	game.last_game_name = chosen_game

	if debug_level != "":
		chosen_game = debug_level
	print("PLAYING minigame "+chosen_game+" at difficulty "+str(game.current_minigame_index))
	
	var scene = load("res://minigames/" + chosen_game + "/" + chosen_game + ".tscn")
	if scene == null:
		scene = load("res://minigames/" + chosen_game + "/puzzle.tscn")
	assert(scene != null)
	
	$tictoc.play() 
		
	var audio_file = "res://minigames/" + chosen_game + "/assets/music.wav"
	if File.new().file_exists(audio_file):
		var sfx = load(audio_file) 
		$gamemusic.stream = sfx
		$gamemusic.play()
	
	return scene

func _ready():
	randomize()
	# var screen_size = get_viewport_rect().size
	# var mg_scale = 0.25 # Minigame scale factor
	# var mg_size = Vector2(1024 * mg_scale, 1024 * mg_scale)
	# var n_games = Vector2(2, 2)
	var game_scale = 0.30859
	
	var scene = loadRandomMinigame()
	 
	for p in game.players:
		if p.is_playing:
			var split = scene.instance()
			split.transform = split.transform.scaled(Vector2(game_scale, game_scale))
			split.player = p
			split.player_index = p.index
			split.difficulty = game.current_minigame_index
			find_node(p.index).add_child(split)
	$MainControl/Countdown.connect("countdown_done",self,"end_game")
	update_score_labels()

func end_game():
	for p in game.players:
		$end.get_node(p.index).visible = p.is_playing
		if p.is_playing:
			var split = $splits.find_node(p.index)
			var splitgame = split.get_child(0)
			var won = splitgame.getPlayerDidWin()
			if won:
				p.add_point()
			$end.get_node(p.index+"/Loose").visible = not won
			$end.get_node(p.index+"/Win").visible = won
			print("Won? ", p.index, won, p.score)
	update_score_labels()
	$end.visible = true
	$PauseTimer.start(2)

func update_score_labels():
	for label in $scores.get_children():
		label.text = str(game.find_node(label.name, true, false).score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_PauseTimer_timeout():
	game.play_next()
