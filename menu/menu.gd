extends Control

var config:Config

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Countdown".connect("countdown_done",self,"start_game")
	config = load("user://config.tres")
	if not config:
		config = Config.new()
	$DebugLevelText.text = config.debug_level

func start_game():
	print("Start Game")

func save_config():
	ResourceSaver.save("user://config.tres", config)

func _on_Button_pressed():
	var arcade_scene = preload("res://gamestates/arcade/arcade.tscn").instance()
	arcade_scene.debug_level = $DebugLevelText.text
	get_tree().get_root().add_child(arcade_scene)
	


func _on_TextEdit_text_changed():
	config.debug_level = $DebugLevelText.text
	save_config()
	pass # Replace with function body.
