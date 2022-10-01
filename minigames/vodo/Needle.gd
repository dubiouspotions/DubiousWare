extends Node2D

export var rotation_speed = 20
var needle_speed = -400

export var STATE = "IDLE" # FLYING / HIT / IDLE_FAIL

var R

# Called when the node enters the scene tree for the first time.
func _ready():
	R = $"."
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if STATE == "IDLE_FAIL" or STATE == "HIT":
		R.rotation_degrees += delta * rotation_speed

func fail():
	STATE = "IDLE_FAIL"

func success():
	$Needle.position.y = 120
	STATE = "HIT"
