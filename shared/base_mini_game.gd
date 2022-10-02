class_name BaseMiniGame
extends Node2D


func getPlayerDidWin():
	return false

func getInstruction():
	return "Do the thing!"
	
var player
export var player_index = "p1"
var difficulty: int

func get_input_vector() -> Vector2:
	return Input.get_vector(player.index+"_left", player.index+"_right", player.index+"_up", player.index+"_down")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
