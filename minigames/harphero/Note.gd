extends Node2D

export var DIR = ""
export var STATE = "IN_PLAY" # FAILED / SUCCESS

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(dir):
	DIR = dir
	$DirectionAnim.play(dir)

func fail():
	STATE = "FAILED"
	print("meh")

func succes():
	STATE = "SUCCESS"
	print(":D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
