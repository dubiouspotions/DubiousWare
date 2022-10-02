extends Control

var game

func _ready():
	var winscore = -1
	var winner
	for p in game.players:
		get_node(p.index+"_score").visible = p.is_playing
		get_node(p.index+"_score").text = str(p.score)
		if p.score > winscore:
			winner = p
			winscore = p.score
	var winner_name = winner.index
	$WhoWon.text = "Player " + winner_name[1]
	$endmusic.play()

#func _process(delta):
#	pass

func _on_MenuButton_pressed():
	game.end()
	$endmusic.stop()
