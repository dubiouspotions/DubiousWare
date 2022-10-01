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
	var screen_size = get_viewport_rect().size
	var mg_scale = 0.3 # Minigame scale factor
	var mg_size = Vector2(800 * mg_scale, 800 * mg_scale)
	var n_games = Vector2(2, 2)
	
	var padding = Vector2(
		(screen_size.x - (n_games.x * mg_size.x))/3,
		(screen_size.y - (n_games.y * mg_size.y))/3
	)
	
	var scene = loadRandomMinigame()
	# var scene = load("res://minigames/03/puzzle.tscn")

	p1 = scene.instance()
	p1.player_index = "p1"
	p1.transform = p1.transform.scaled(Vector2(mg_scale, mg_scale))
	p1.position = Vector2(padding.x, padding.y)
	get_tree().get_root().add_child(p1)

	p2 = scene.instance()
	p2.player_index = "p2"
	p2.transform = p2.transform.scaled(Vector2(mg_scale, mg_scale))
	p2.position = Vector2(padding.x * 2 + mg_size.x, padding.y)
	get_tree().get_root().add_child(p2)

	p3 = scene.instance()
	p3.player_index = "p3"
	p3.transform = p3.transform.scaled(Vector2(mg_scale, mg_scale))
	p3.position = Vector2(padding.x, padding.y * 2 + mg_size.y)
	get_tree().get_root().add_child(p3)

	p4 = scene.instance()
	p4.player_index = "p4"
	p4.transform = p4.transform.scaled(Vector2(mg_scale, mg_scale))
	p4.position = Vector2(padding.x * 2 + mg_size.x, padding.y * 2 + mg_size.y)
	get_tree().get_root().add_child(p4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
