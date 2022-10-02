extends Node2D
class_name Game

const TOTAL_MINIGAMES_IN_GAME = 10
export var debug_level: String = ""
var current_arcade
var players = []
var menu
var current_minigame_index = 0
export var last_game_name = ""

func _init():
	self.name = "Game"
	var playersNode = Node.new()
	playersNode.name = "Players"
	self.add_child(playersNode)
	playersNode.add_child(Player.new("p1", "Player 1"))
	playersNode.add_child(Player.new("p2", "Player 2"))
	playersNode.add_child(Player.new("p3", "Player 3"))
	playersNode.add_child(Player.new("p4", "Player 4"))
	players = playersNode.get_children()
	

func start():
	current_arcade = preload("res://gamestates/arcade/arcade.tscn").instance()
	current_arcade.game = self
	current_arcade.debug_level = self.debug_level
	add_child(current_arcade)

func finish_game():
	var final_scene = preload("res://gamestates/fullgame_win/fullgame_win.tscn").instance()
	final_scene.game = self
	add_child(final_scene)
	
func play_next():
	remove_child(current_arcade)
	current_arcade.queue_free()
	current_arcade = null
	current_minigame_index = current_minigame_index + 1
	
	if current_minigame_index < TOTAL_MINIGAMES_IN_GAME:
		start()
	else:
		finish_game()

func end():
	# go back to main menu
	menu.prep_game()
	self.queue_free()

func has_any_players():
	for p in players:
		if p.is_playing:
			return true
	return false

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		end()
	# stop events from propagating up to main menu if a game is running
	if current_arcade:
		get_tree().set_input_as_handled()
