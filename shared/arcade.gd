class_name Arcade 
extends Node2D

var debug_level = ""
var game
export var game_name = ""


func loadRandomMinigame():
	var chosen_game = game_name
	game.last_game_name = chosen_game

	if debug_level != "":
		chosen_game = debug_level
	print("PLAYING minigame "+chosen_game+" at difficulty "+str(game.current_minigame_index))
	
	var scene = load("res://minigames/" + chosen_game + "/" + chosen_game + ".tscn")
	if scene == null:
		scene = load("res://minigames/" + chosen_game + "/puzzle.tscn")
	assert(scene != null)
	
	$tictoc.play() 
		
	var audio_file = "res://minigames/" + chosen_game + "/assets/music.mp3"
	if ResourceLoader.exists(audio_file):
		var sfx = load(audio_file) 
		$gamemusic.stop()
		$gamemusic.stream = sfx
		$gamemusic.play()
	
	return scene

func _ready():
	randomize()
	var game_scale = 0.30859
	
	var scene = loadRandomMinigame()
	 
	for p in game.players:
		if p.is_playing:
			var split = scene.instance()
			split.transform = split.transform.scaled(Vector2(game_scale, game_scale))
			split.player = p
			split.player_index = p.index
			split.difficulty = game.current_minigame_index
			$MainControl/Instructions/InstructionsPanel/Label.text = split.getInstruction()
			find_node(p.index).add_child(split)
	$MainControl/Countdown.connect("countdown_done",self,"end_game")
	update_score_labels()
	
	if game.current_minigame_index == game.TOTAL_MINIGAMES_IN_GAME-1:
		$MainControl/Instructions/InstructionsPanel/Label.text = "BOSS FIGHT!\n"+$MainControl/Instructions/InstructionsPanel/Label.text
	yield(get_tree().create_timer(1.5),"timeout")
	$MainControl/Instructions.hide()

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
