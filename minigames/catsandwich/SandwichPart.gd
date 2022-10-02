extends Node2D

export var state = "FALING" # CATCHED / FAIL
var _frame

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func success(sound=true):
	if state == "FALING":
		if sound:
			if _frame in [3,5,7,10]:
				$cat.play()
			elif _frame in [1,2,4,6,8,9,11]:
				$bread.play()
			elif _frame in [0]:
				$flag.play()
		state = "CATCHED"

func fail():
	state = "FAIL"

func set_frame(frame):
	_frame = frame
	$AnimatedSprite.frame = frame
