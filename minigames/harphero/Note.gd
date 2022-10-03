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
	$DirectionAnim.scale.x = 1
	$DirectionAnim.scale.y = 1
#	$Fail.play()

func success():
	STATE = "SUCCESS"
	$DirectionAnim.scale.x = 3
	$DirectionAnim.scale.y = 3
	if DIR == "Up":
		$Up.play()
	elif DIR == "Down":
		$Down.play()
	elif DIR == "Left":
		$Left.play()
	elif DIR == "Right":
		$Right.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
