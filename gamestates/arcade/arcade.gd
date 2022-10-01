extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var p1
var p2
var p3
var p4


func loadRandomMinigame():
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
	gamenames.shuffle()
	var chosen_game = gamenames[0]
	print("PLAYING minigame "+chosen_game)
	var scene = load("res://minigames/"+chosen_game+"/puzzle.tscn")
	return scene

func _ready():
	randomize()
	var scene = loadRandomMinigame()
	p1 = scene.instance()
	p1.player_index = "p1"
	get_tree().get_root().add_child(p1)
	p1.transform = p1.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(100, 100))
	
	p2 = scene.instance()
	p2.player_index = "p2"
	p2.transform = p2.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(1100, 100))
	get_tree().get_root().add_child(p2)

	p3 = scene.instance()
	p3.player_index = "p3"
	p3.transform = p3.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(100, 650))
	get_tree().get_root().add_child(p3)
	
	p4 = scene.instance()
	p4.player_index = "p4"
	p4.transform = p4.transform.scaled(Vector2(0.5, 0.5)).translated(Vector2(1100, 650))
	get_tree().get_root().add_child(p4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
