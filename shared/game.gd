extends Node2D
class_name Game

export var debug_level: String = ""
var current_arcade

func _init():
	self.name = "Game"
	var players = Node.new()
	players.name = "Players"
	self.add_child(players)
	players.add_child(Player.new("p1"))
	players.add_child(Player.new("p2"))
	players.add_child(Player.new("p3"))
	players.add_child(Player.new("p4"))

func start():
	current_arcade = preload("res://gamestates/arcade/arcade.tscn").instance()
	current_arcade.game = self
	current_arcade.debug_level = self.debug_level
	get_tree().get_root().add_child(current_arcade)
	
func play_next():
	get_tree().get_root().remove_child(current_arcade)
	current_arcade = null
	
	self.debug_level = ""
	start()
