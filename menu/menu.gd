extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Countdown".connect("countdown_done",self,"start_game")

func start_game():
	print("Start Game")

func _on_Button_pressed():
	get_tree().change_scene("res://gamestates/arcade/arcade.tscn")
	
