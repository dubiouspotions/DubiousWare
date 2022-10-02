class_name GameButton
extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_button_pressed")

func _button_pressed():
	var menu = find_parent("Menu")
	# menu.find_node("DebugLevelText").text = text
	menu.debug_level = text
	menu._on_StartButton_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
