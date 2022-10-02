extends Control

var player: Player

func set_player(p):
	player = p
	update()

func update():
	$NameLabel.text = player.display_name
	$JoinButton.text = player.button_label("action")
	# $BG.color =  Color("c5166d02") if player.is_playing else Color("8e220a0a")
	$SelectRect.visible = player.is_playing 
	$JoinButton/joinLabel.text = "joined!" if player.is_playing else "to join"
	$PlayerGraphics.get_node(player.index+"_start").visible = true
	$PlayerGraphics.get_node(player.index+"_active").visible = player.is_playing

func _input(evt):
	if player and evt.is_action_pressed(player.action_name("action")):
		toggle_playing()


func toggle_playing():
	player.is_playing = not player.is_playing
	update()
