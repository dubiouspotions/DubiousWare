extends Control

var game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var winscore = -1
	var winner
	for p in game.players:
		if p.score > winscore:
			winner = p
			winscore = p.score
	$WhoWon.text = "Player " + winner.index + "\nWon!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	game.end()
