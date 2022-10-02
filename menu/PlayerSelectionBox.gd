extends Control

var player: Player

func set_player(p):
	player = p
	update()

func update():
	$NameLabel.text = player.display_name
	$JoinButton.text = player.button_label("action")
	$BG.color =  Color("c5166d02") if player.is_playing else Color("8e220a0a")
	$JoinButton/joinLabel.text = "joined!" if player.is_playing else "to join"

func _input(evt):
	if player.is_action_pressed():
		toggle_playing()


func toggle_playing():
	player.is_playing = not player.is_playing
	update()
