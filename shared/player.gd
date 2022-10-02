extends Node
class_name Player

export var is_playing: bool = false
export var score: int = 0
export var index: String = ""
export var display_name: String = ""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init(idx, dispname):
	self.index = idx
	self.name = idx
	self.display_name = dispname

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_point():
	score = score + 1

func action_name(action):
	return index+"_"+action

func is_action_pressed():
	return Input.is_action_pressed(action_name("action"))

func button_label(action):
	var full_action = index+"_"+action
	var evts = InputMap.get_action_list(full_action)
	var evt = evts[0]
	var gevt = evt as InputEventJoypadButton
	if gevt:
		var btns = "×○□△"
		return "P"+str(gevt.device+1) + " " + btns[gevt.button_index]
	else:
		return evt.as_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
