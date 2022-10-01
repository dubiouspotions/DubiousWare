extends Node
class_name Player

export var playing: bool = false
export var score: int = 0
export var index: String = ""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init(idx):
	self.index = idx
	self.name = idx

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
